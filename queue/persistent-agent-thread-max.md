# Queue Item — persistent-agent-thread-max

**Source:** intake/2026-04-19.md — Section B, Search 4
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/platforms/claude.md

## Change block

```
### 2026-04-19 — TECHNIQUE — Persistent Agent Thread for Mobile+Desktop Cowork
**Severity:** HIGH
**Context:** Anthropic released Persistent Agent Thread for Cowork task management in April 2026 (Max first, then Pro).
**Learning:** Persistent Agent Thread lets Logan manage Cowork tasks from mobile (iOS/Android) and desktop (Claude Desktop) simultaneously. Tasks started in Cowork are accessible via the app — no need to stay at the computer while a long Cowork session runs. Max plan rollout is complete; Pro plan following. Use for: long-running Claudious process runs, overnight research tasks, build sessions that can be monitored from mobile.
**Applies to:** All Cowork sessions on Max plan — Claudious process, ASF build sessions
```

## Verification grep

`grep -c "Persistent Agent Thread" learnings/platforms/claude.md`
