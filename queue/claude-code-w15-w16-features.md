# Queue Item — claude-code-w15-w16-features

**Source:** intake/2026-04-19.md — Section B, Search 1
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/techniques.md

## Change block

```
### 2026-04-19 — TECHNIQUE — Claude Code Week 15-16 April 2026 Feature Set
**Severity:** HIGH
**Context:** Claude Code shipped two major weekly releases in April 2026 with high-signal workflow features.
**Learning:** Week 15 (Apr 6-10): Monitor tool streams background process events in real-time — replaces polling loops; `/loop` self-paces long sessions automatically; `/autofix-pr` fixes PRs from terminal without leaving Claude Code; `/team-onboarding` creates replayable setup guides; Ultraplan early preview (cloud planning on Opus 4.6, terminal stays free). Week 16 (Apr 14-18): `/powerup` interactive lessons for feature discovery; defer permission decisions mid-session (approve later without restarting); per-model `/cost` breakdown shows spend by model; skill description limit raised 250→1,536 chars. Update any slash-command workflows to use Monitor tool instead of background polling.
**Applies to:** All Claude Code sessions — especially Claudious process runs and parallel-agent workflows
```

## Verification grep

`grep -c "Week 15-16 April 2026" learnings/techniques.md`
