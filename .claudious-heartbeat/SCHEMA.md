# Heartbeat Schema

Each machine Logan uses commits a JSON file here named `{machine-slug}.json`.

**Purpose:** Claudious needs to know what state each machine is in — what repos are cloned where, what SHA each repo is at, whether any is dirty or behind origin. Intake reads these files at 6am and surfaces cross-machine drift.

## File naming

Slug derived from `hostname` lowercased, non-alphanumerics replaced with `-`, collapsed dashes, trimmed. Examples: `logan-pc`, `mac-studio`, `macbook-pro`.

## Schema

```json
{
  "machine_id": "logan-pc",
  "hostname": "LOGAN-PC",
  "os": "Windows",
  "last_seen": "2026-04-23T22:35:00Z",
  "tracked_repos": {
    "Claudious": {
      "path": "C:\\Users\\logan\\Documents\\GitHub\\Claudious",
      "head_sha": "abc1234",
      "head_subject": "feat: add heartbeat layer",
      "branch": "main",
      "dirty_files": 0,
      "ahead": 0,
      "behind": 0,
      "last_fetch": "2026-04-23T22:35:00Z"
    },
    "asf-graphics-app": { "...": "..." },
    "courtside-pro": { "...": "..." }
  }
}
```

## Field definitions

- `last_seen` (UTC ISO-8601): when this machine last ran `scripts/update-heartbeat.*`.
- `tracked_repos.<name>.head_sha`: short SHA of the local HEAD.
- `tracked_repos.<name>.ahead` / `behind`: commits ahead of / behind `origin/<branch>` after `git fetch`.
- `tracked_repos.<name>.dirty_files`: count from `git status --porcelain`.
- `tracked_repos.<name>.last_fetch`: when the heartbeat script last ran `git fetch` on this repo.

## Absent repo policy

If a tracked repo path does not exist on this machine, omit the entry entirely — do not write a sentinel. The aggregator in Intake uses "absent" as meaningful signal (this machine does not have this repo).

## Freshness thresholds (read by Intake)

- `last_seen > 48h ago` → surface as "machine stale" in active-findings.md
- Any repo `behind > 0 AND last_seen > 4h ago` → surface as "pull required"
- Any repo `dirty_files > 0 AND last_seen > 24h ago` → surface as "stale WIP"

## Commit policy

Heartbeat updates commit directly to `main` with message `heartbeat: {machine-slug} {head-sha}`. Routine git noise is acceptable here — the metadata is the point.
