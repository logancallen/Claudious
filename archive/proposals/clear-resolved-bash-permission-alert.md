# Clear resolved bash-permission-bypass alert from alerts.md

**Source:** pioneer-2026-04 re-run; cross-check with archive/proposals/superpowers-trial-log.md (CC 2.1.116 baseline)
**Impact:** M (alert hygiene; prevents false-positive at session start)
**Effort:** T
**Risk:** SAFE
**Routing:** SAFE + M + md-only → QUEUE

## Rationale
`alerts.md` line 7 says "Update immediately if below v2.1.98." Logan is currently on Claude Code v2.1.116 (evidence: `archive/proposals/superpowers-trial-log.md` baseline 2026-04-22). The alert is resolved — the instruction to update is obsolete and occupies attention at every session start for zero remaining signal.

The underlying proposal (`archive/proposals/bash-permission-bypass-patch.md`) is also ripe for closure as auto-resolved — that closure is tracked as a separate proposal item this run (see `proposals/close-bash-permission-bypass-proposal.md`).

## Implementation
Delete line 7 of `alerts.md`:

```
2026-04-13 HIGH SCOUT Bash tool permission bypass patched in v2.1.98 — backslash-escaped flags could bypass safety checks. Update immediately if below v2.1.98.
```

Leave the surrounding lines intact. Line 8 (skill description 250→1,536 char alert) has an outstanding `skill-description-1536-chars-audit` proposal and stays.

## Verification
- `grep -c "v2.1.98" alerts.md` → 0
- `grep -c "permission bypass" alerts.md` → 0
- Line count drops by 1
