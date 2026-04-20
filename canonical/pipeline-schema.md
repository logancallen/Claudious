# Pipeline Schema — Canonical

**Last updated:** 2026-04-19
**Purpose:** Multi-source ingestion schema for the Intake routine. Defines what shape scan-inbox files must have so Intake can ingest them uniformly regardless of source.

## File naming

- Base: `YYYY-MM-DD-<source>-scan.md`
- Multi-scan same day: `YYYY-MM-DD-<source>-scan-HHMM.md` (HHMM is message timestamp in UTC)
- Location: `archive/scan-inbox/`

## File header (required)

```
# <Source> Daily Scan — YYYY-MM-DD

**Subject:** <original email subject>
**From:** <sender>
**Date:** <ISO 8601 with timezone>
**Fetched:** <ISO 8601 with timezone>

---

<body content>
```

## Active sources (v1)

- Grok Daily Scan — fetched by `.github/workflows/grok-scan-ingest.yml`

## Reserved for future sources

- ChatGPT Pro Deep Research scheduled reports
- Perplexity Max scheduled reports
- RSS/feed-based sources

## Gmail IMAP scaling ceiling (for future multi-source)

- ~2500 MB/day download per Gmail account
- ~15 concurrent IMAP connections per account
- Single daily poll of one small email = <<1% of quota
- Multi-source expansion (e.g., 5 daily fetchers) still well within quota
- If traffic volume ever scales beyond small text emails, revisit quota math
