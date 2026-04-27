# Claudious — Shared State Store

## Purpose
Manually-maintained shared knowledge layer across Logan's Claude Projects. Every Claude Project attaches `canonical/` as project knowledge. Three files, edited by hand.

## Repo Structure

### `canonical/` — Attached to all project knowledge
- `state.md` — Claude models, Claude Code, toolchain
- `playbook.md` — prompting rules + antipatterns
- `changelog.md` — dated entries describing what changed

### `scripts/`
- `backup-config.sh` — snapshot Claude config files into `snapshots/`
- `rollback-config.sh` — restore Claude config from snapshot
- `clear-git-locks.ps1` — Windows-side stale `.git/*.lock` cleanup

## Update Discipline

Editing canonical:
1. Bump `Last updated:` at the top of the file.
2. Add a one-line entry to `canonical/changelog.md`.
3. `git add canonical/ && git commit -m "canonical: <file> — <what>" && git push`.

Project knowledge auto-syncs on next Claude Project sync — no re-attachment needed.

## Rules

- Canonical edits are manual. No script writes to `canonical/`.
- No new dated files at repo root.
- Speak literal-interpretation Opus 4.7 — no silent prompt repair.

## Emergency Rollback

```bash
bash scripts/rollback-config.sh YYYY-MM-DD
```

Or `git revert <sha>`.
