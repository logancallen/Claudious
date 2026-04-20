#!/usr/bin/env python3
"""
fetch_grok_scan.py — Fetch daily Grok ecosystem scan email via IMAP.

Auth: Gmail app-password (same credential as SMTP outbound in daily-briefing.yml).
App-passwords remain fully supported on IMAP post-LSAP deprecation (2022).
Reference: https://support.google.com/accounts/answer/185833

Protocol: IMAP4 over SSL, imap.gmail.com:993. Python stdlib only.

Scaling budget: ~2500MB/day Gmail IMAP download per account, ~15 concurrent
connections. Single daily poll of one small email is <<1% of quota.

Writes to: archive/scan-inbox/YYYY-MM-DD-grok-scan.md
           archive/scan-inbox/YYYY-MM-DD-grok-scan-HHMM.md (multi-scan days)

Hardening items implemented:
  #9  Progressive lookback window (24h -> 36h -> 48h)
  #10 Fuzzy subject-line regex matching
  #11 Multi-scan-per-day filename suffix
  #12 IMAP-semantic retry logic (imaplib.error, abort, socket errors, * BYE)
  #13 Missing-scan alarm lives in Intake routine, NOT here (fetcher stays lean)

Exit codes:
  0 = scan fetched and written (fresh or multi-scan suffix)
  1 = no matching message in any lookback window (expected on low-volume days)
  2 = auth or connection failure after retries
  3 = other unrecoverable error
"""

import email
import imaplib
import os
import re
import socket
import sys
import time
from datetime import datetime, timedelta, timezone
from email.utils import parsedate_to_datetime
from pathlib import Path

IMAP_HOST = "imap.gmail.com"
IMAP_PORT = 993
MAILBOX = "INBOX"
SUBJECT_REGEX = re.compile(r"claudious\s+daily\s+scan", re.IGNORECASE)
LOOKBACK_WINDOWS_HOURS = [24, 36, 48]
MAX_RETRIES = 3
BACKOFF_BASE_SECONDS = 2
REPO_ROOT = Path(__file__).resolve().parent.parent
SCAN_INBOX = REPO_ROOT / "archive" / "scan-inbox"


def log(msg: str) -> None:
    print(f"[fetch_grok_scan] {msg}", flush=True)


def get_credentials() -> tuple[str, str]:
    user = os.environ.get("GMAIL_USER")
    password = os.environ.get("GMAIL_APP_PASSWORD")
    if not user or not password:
        log("ERROR: GMAIL_USER or GMAIL_APP_PASSWORD not set in environment")
        sys.exit(2)
    return user, password


def connect_with_retry(user: str, password: str) -> imaplib.IMAP4_SSL:
    last_exc = None
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            conn = imaplib.IMAP4_SSL(IMAP_HOST, IMAP_PORT, timeout=30)
            conn.login(user, password)
            return conn
        except (imaplib.IMAP4.error, imaplib.IMAP4.abort,
                socket.timeout, ConnectionResetError, OSError) as e:
            last_exc = e
            backoff = BACKOFF_BASE_SECONDS ** attempt
            log(f"attempt {attempt} failed ({type(e).__name__}: {e}), retrying in {backoff}s")
            time.sleep(backoff)
    log(f"ERROR: IMAP auth/connect failed after {MAX_RETRIES} retries: {last_exc}")
    sys.exit(2)


def search_since(conn: imaplib.IMAP4_SSL, since_date: datetime) -> list[bytes]:
    # IMAP SEARCH SINCE is date-granular only (DD-Mon-YYYY), not timestamp.
    # We query by date then client-side filter on each message's Date: header.
    date_str = since_date.strftime("%d-%b-%Y")
    typ, data = conn.search(None, "SINCE", date_str)
    if typ != "OK":
        log(f"ERROR: IMAP SEARCH returned {typ}: {data}")
        return []
    if not data or not data[0]:
        return []
    return data[0].split()


def fetch_message(conn: imaplib.IMAP4_SSL, uid: bytes) -> email.message.Message | None:
    typ, data = conn.fetch(uid, "(RFC822)")
    if typ != "OK" or not data or not data[0]:
        return None
    raw = data[0][1]
    if not isinstance(raw, (bytes, bytearray)):
        return None
    return email.message_from_bytes(raw)


def extract_text_body(msg: email.message.Message) -> str:
    # Handle MIME multipart: prefer text/plain, fall back to text/html stripped.
    # Covers future case where Grok Task email includes attachments.
    if msg.is_multipart():
        for part in msg.walk():
            ctype = part.get_content_type()
            if ctype == "text/plain":
                try:
                    payload = part.get_payload(decode=True)
                    if payload:
                        charset = part.get_content_charset() or "utf-8"
                        return payload.decode(charset, errors="replace")
                except Exception:
                    continue
        for part in msg.walk():
            if part.get_content_type() == "text/html":
                try:
                    payload = part.get_payload(decode=True)
                    if payload:
                        charset = part.get_content_charset() or "utf-8"
                        html = payload.decode(charset, errors="replace")
                        return re.sub(r"<[^>]+>", "", html)
                except Exception:
                    continue
        return ""
    payload = msg.get_payload(decode=True)
    if payload:
        charset = msg.get_content_charset() or "utf-8"
        return payload.decode(charset, errors="replace")
    return ""


def find_scan(conn: imaplib.IMAP4_SSL) -> tuple[email.message.Message, datetime] | None:
    now = datetime.now(timezone.utc)
    for window_hours in LOOKBACK_WINDOWS_HOURS:
        cutoff = now - timedelta(hours=window_hours)
        # Date-granular search: go one day earlier to catch edge-of-day messages.
        search_since_date = cutoff - timedelta(days=1)
        log(f"searching SINCE {search_since_date.strftime('%d-%b-%Y')} (window={window_hours}h)")
        uids = search_since(conn, search_since_date)
        log(f"  candidates: {len(uids)}")
        if not uids:
            continue
        # Scan newest first.
        for uid in reversed(uids):
            msg = fetch_message(conn, uid)
            if msg is None:
                continue
            subject = msg.get("Subject", "")
            if not SUBJECT_REGEX.search(subject):
                continue
            date_hdr = msg.get("Date")
            if not date_hdr:
                continue
            try:
                msg_dt = parsedate_to_datetime(date_hdr)
                if msg_dt.tzinfo is None:
                    msg_dt = msg_dt.replace(tzinfo=timezone.utc)
            except (TypeError, ValueError):
                continue
            if msg_dt < cutoff:
                continue
            log(f"  MATCH: uid={uid.decode()} subject={subject!r} date={msg_dt.isoformat()}")
            return msg, msg_dt
    return None


def write_scan_file(msg: email.message.Message, msg_dt: datetime) -> Path:
    SCAN_INBOX.mkdir(parents=True, exist_ok=True)
    date_str = msg_dt.strftime("%Y-%m-%d")
    base_name = f"{date_str}-grok-scan.md"
    target = SCAN_INBOX / base_name
    if target.exists():
        # Multi-scan-per-day: suffix with HHMM.
        time_str = msg_dt.strftime("%H%M")
        target = SCAN_INBOX / f"{date_str}-grok-scan-{time_str}.md"
    body = extract_text_body(msg).strip()
    if not body:
        log("WARNING: message body extracted as empty")
    header = [
        f"# Grok Daily Scan — {date_str}",
        "",
        f"**Subject:** {msg.get('Subject', '')}",
        f"**From:** {msg.get('From', '')}",
        f"**Date:** {msg_dt.isoformat()}",
        f"**Fetched:** {datetime.now(timezone.utc).isoformat()}",
        "",
        "---",
        "",
    ]
    target.write_text("\n".join(header) + body + "\n", encoding="utf-8")
    log(f"wrote {target.relative_to(REPO_ROOT)}")
    return target


def main() -> int:
    user, password = get_credentials()
    conn = connect_with_retry(user, password)
    try:
        typ, _ = conn.select(MAILBOX, readonly=True)
        if typ != "OK":
            log(f"ERROR: IMAP SELECT {MAILBOX} failed")
            return 2
        result = find_scan(conn)
        if result is None:
            log("no matching scan message found in 24/36/48h windows")
            return 1
        msg, msg_dt = result
        write_scan_file(msg, msg_dt)
        return 0
    finally:
        try:
            conn.close()
        except Exception:
            pass
        try:
            conn.logout()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
