# Proposal — clarify-rollback-script-windows

**Source:** intake/2026-04-19.md — Section D, Unused Rules
**Impact:** L
**Effort:** T
**Risk:** SAFE
**Routing reason:** IMPACT=L → PROPOSE

## Description
`CLAUDE.md` Emergency Rollback section references `~/Projects/claudious/scripts/rollback-config.sh`. The tilde path expands differently on Mac (`/Users/logan/`), Linux (`/home/user/`), and Windows (undefined or `C:\Users\logan\`). A Windows session following this instruction verbatim could fail silently.

## Proposed action
Update CLAUDE.md Emergency Rollback section to include the Windows canonical path:
```
## Emergency Rollback
If a Pioneer-queued change breaks something:
- Mac/Linux: bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD
- Windows: bash C:\Users\logan\Projects\claudious\scripts\rollback-config.sh YYYY-MM-DD
```

## Target
`CLAUDE.md` — Emergency Rollback section (currently line ~34)
