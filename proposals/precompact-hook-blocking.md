# PROPOSED: PreCompact Hook Blocking (v2.1.105+)
**Finding-ID:** 2026-04-13-precompact-hook-blocking
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Classification:** PROPOSED
**Risk:** TEST-FIRST | **Impact:** HIGH | **Effort:** MEDIUM (hook authoring + testing)

## What It Does
PreCompact hooks can now block compaction via exit code 2 or `{"decision":"block"}`. Lets you prevent mid-migration or mid-debug compaction when context loss would break the flow.

## Why Not Queued
- Requires writing a new hook file and exit-code logic
- Needs a rule for WHEN to block (what state triggers it?)
- Hook authoring falls under TEST-FIRST; blocked compaction still retries, so misconfig is recoverable but annoying

## Implementation Plan
1. Confirm Claude Code version is v2.1.105+ (see separate bash-permission-patch proposal)
2. Draft `.claude/hooks/pre-compact` that checks for:
   - Active migration (e.g., a lockfile like `.claude/migration.lock`)
   - Current task marked critical in handoff.md
3. Return exit code 2 in block conditions
4. First deploy on ASF Graphics (highest-stakes Claude Code project), test for one week
5. Propagate to Courtside Pro and Claudious after validation

## Judgment Call
- Highest leverage during long multi-file migrations where compaction would drop schema state
- Pairs with SessionEnd/Start handoff pattern — block compaction while handoff is being written
- Start with ONE trigger condition (migration lock) before adding more

## Where to Document
- Add to `learnings/patterns.md` after first successful use
- Update project `CLAUDE.md` to mention the lockfile convention

## Action Required
Logan: decide block trigger conditions. Hook creation is per-project.
