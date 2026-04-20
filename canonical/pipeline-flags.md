# Pipeline Flags — Canonical

**Last updated:** 2026-04-19
**Purpose:** Boolean flags controlling which scan sources the Intake routine ingests. Let Intake skip a source cleanly when paused.

## Flags

```yaml
grok_ingest_enabled: true
chatgpt_ingest_enabled: false
perplexity_ingest_enabled: false
rss_ingest_enabled: false
```

## Update discipline

Flip a flag in this file; commit with message `pipeline: <source>_ingest_enabled = <bool>`. Intake reads this file at runtime. No code change needed.
