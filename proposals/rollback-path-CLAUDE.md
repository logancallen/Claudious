# PROPOSAL — Fix Rollback Path in CLAUDE.md (Unix Tilde → Cross-Platform Note)

**Finding-ID:** 2026-04-17-rollback-path-claudemd
**Impact:** M | **Effort:** T | **Risk:** SAFE
**Source:** Section D config analysis — CLAUDE.md line 34

## Problem
`CLAUDE.md` line 34 references `~/Projects/claudious/scripts/rollback-config.sh` using a Unix tilde path. On Windows (Logan's primary machine), the canonical path is `C:\Users\logan\Projects\claudious\`. Tilde-path only resolves in WSL/Linux contexts — rollback script silently fails if invoked from PowerShell.

## Proposed Change
Update the Emergency Rollback section in `CLAUDE.md` to include the Windows path alongside the Unix path:

```
## Emergency Rollback
If a Pioneer-queued change breaks something:
- WSL/Linux: bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD
- Windows PowerShell: bash C:\Users\logan\Projects\claudious\scripts\rollback-config.sh YYYY-MM-DD
```

## Why Proposal (not Auto-Queue)
Modifying `CLAUDE.md` (a structural file) requires Logan's review — not a pure learnings append.

## Verification
`grep -c "Windows PowerShell" CLAUDE.md` ≥1
