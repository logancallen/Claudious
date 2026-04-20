# Scan Inbox

Daily Grok ecosystem scan emails are fetched via IMAP by `.github/workflows/grok-scan-ingest.yml` and written here as `YYYY-MM-DD-grok-scan.md` (or `YYYY-MM-DD-grok-scan-HHMM.md` for multi-scan days).

The Intake routine reads this directory as a source on its 10am CT run. Files are dedupe-checked against `canonical/active-findings.md` and `archive/intake/` last 7 days.

Files in this directory are append-only history. Do not delete manually.
