# PROPOSED: Implement SessionEnd/Start Handoff Directive in Global CLAUDE.md
**Finding-ID:** 2026-04-12-implement-handoff-directive
**Classification:** PROPOSED
**Risk:** TEST-FIRST | **Impact:** HIGH | **Effort:** LOW

## The Problem
`learnings/patterns.md` documents the SessionEnd/Start Hook Chain pattern:
> SessionEnd directive prompts Claude to write handoff to .claude/handoff.md. SessionStart reads handoff.md and pre-appends to new session.

`docs/learnings.md` documents that the primary harvest mechanism is a SessionEnd directive in global CLAUDE.md.

But the actual Claudious CLAUDE.md contains **no SessionEnd or SessionStart directive**. The pattern is documented but not implemented.

## Why Not Queued
- Modifies global CLAUDE.md which loads on every message across all sessions
- Adding directives here has multiplicative token cost
- Needs careful wording to be compact (per antipatterns.md guidance)

## Recommended Implementation
Add to Claudious CLAUDE.md (3-4 lines max):
```
## Session Handoff
On session end: write completed/pending/blockers/next-action to .claude/handoff.md.
On session start: if .claude/handoff.md exists, read it and resume from last state.
```

## Action Required
1. Logan decides if this belongs in Claudious CLAUDE.md (global) or per-project CLAUDE.md
2. Test on one project first before global deployment
3. Add handoff.md to .gitignore in each project
