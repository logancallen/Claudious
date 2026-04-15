# QUEUED: Add Arize Prompt-Learning Methodology to techniques.md

**Finding-ID:** 2026-04-14-arize-prompt-learning-claudemd
**Source:** https://arize.com/blog/claude-md-best-practices-learned-from-optimizing-claude-code-with-prompt-learning/
**Classification:** QUEUED (SAFE + HIGH + TRIVIAL, md-only)
**Risk:** SAFE — methodology only, not a config change

## Why Queued
- Scout 2026-04-14 flagged this as SAFE; Scout alert 2026-04-14 echoes it with +5-10% SWE Bench gain
- Currently referenced in `alerts.md` but has no durable entry in `learnings/techniques.md`
- Logan's CLAUDE.md files are the highest-leverage surface area for iterative optimization (loads every message per antipatterns.md)
- No existing proposal covers this; no existing technique entry describes the diff-based CLAUDE.md iteration loop

## Implementation Steps
Append to `learnings/techniques.md` under "## Active Techniques" (before Archive section):

```
### 2026-04-14 — TECHNIQUE — Arize Prompt-Learning Loop for CLAUDE.md
**Severity:** HIGH
**Context:** Arize published a systematic method for CLAUDE.md optimization showing +5-10% SWE Bench improvement without model changes.
**Learning:** Pick a repeatable failing task. Run it against current CLAUDE.md. Diff Claude's actual output vs. desired output. Extract the exact instruction that would have prevented the error (e.g., "Run `npm test` before declaring done"). Append to CLAUDE.md, then test removal to confirm the new line is actually pulling weight — bloat hurts. Re-run. Cycle weekly on highest-failure-rate workflows. Pair with Bloated CLAUDE.md antipattern to keep net line count flat.
**Applies to:** All Claude Code projects — CLAUDE.md iteration on ASF Graphics, Courtside Pro, Claude Mastery Lab
```

## Verification
- `learnings/techniques.md` gains exactly one new entry, dated 2026-04-14
- File remains under 200 lines (currently 60)
- No duplicate content with existing "MEMORY.md Separation" or "Bloated CLAUDE.md" entries

## Applies To
`learnings/techniques.md` only — md-only change within Claudious repo.
