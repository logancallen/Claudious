# Queue Item — opus-47-ga-model-update

**Source:** intake/2026-04-19.md — Section B, Search 1
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/platforms/claude.md

## Change block

```
### 2026-04-19 — TECHNIQUE — Opus 4.7 GA: Most Capable Model + xhigh Effort
**Severity:** HIGH
**Context:** Opus 4.7 became generally available for Max subscribers in April 2026.
**Learning:** Opus 4.7 is the most capable Claude model as of April 2026. Adds `xhigh` effort level (above `high`) for maximum reasoning depth. Auto mode (automatic model selection per task) is available for Max subscribers on Opus 4.7 only. Use `--model claude-opus-4-7` in Claude Code or set in ~/.claude/settings.json. For planning heavy tasks, Opus 4.7 + effort:xhigh is now the ceiling.
**Applies to:** All Claude Code sessions — model routing in techniques.md subagent patterns
```

## Verification grep

`grep -c "Opus 4.7 GA" learnings/platforms/claude.md`
