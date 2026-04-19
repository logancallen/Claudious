# PROPOSED: CLAUDE_CODE_PLAN_V2_AGENT_COUNT — Tune Plan Mode Parallelism
**Finding-ID:** 2026-04-13-plan-v2-agent-count
**Source:** https://www.turboai.dev/blog/claude-code-environment-variables-complete-list
**Classification:** PROPOSED
**Risk:** TEST-FIRST | **Impact:** MEDIUM | **Effort:** LOW

## What It Does
Controls agents spawned by Plan v2 (1-10). Related `CLAUDE_CODE_PLAN_V2_EXPLORE_AGENT_COUNT` tunes explore-phase count separately. More agents = faster plans on large codebases but linear token cost.

## Why Not Queued
- TEST-FIRST — token cost scales linearly
- "Faster" depends on codebase size; for Logan's small-to-medium projects (ASF Graphics, Courtside Pro, Claudious), default may be optimal
- No empirical benchmark in source

## Implementation Plan
1. Benchmark current plan time on ASF Graphics (baseline, default = 3)
2. Set `CLAUDE_CODE_PLAN_V2_AGENT_COUNT=5` and rerun same plan
3. Compare wall clock time vs. token cost (use `/cost`)
4. Keep if 2x+ speed improvement; revert if marginal

## Judgment Call
- Lower impact than other env var findings this week
- Skip unless Plan v2 is slow on a specific repo
- Logan's Claudious and personal projects are small enough that default likely wins

## Where to Document
`learnings/techniques.md` Env Var Layer entry, only if kept.
