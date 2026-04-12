# PROPOSED: Split-and-Merge with Worktree Isolation for Batch Migrations
**Finding-ID:** 2026-04-12-split-merge-worktree-batch
**Source:** https://www.mindstudio.ai/blog/claude-code-split-and-merge-pattern
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** HIGH | **Effort:** MEDIUM (pattern to learn + first application)

## What It Does
Spawns up to 10 sub-agents, each in its own git worktree, to process independent work in parallel. No file conflicts. Ideal for batch migrations, multi-file refactors, or competing approaches to the same problem.

## Why Not Queued
Effort is not trivial — requires learning the pattern, identifying a good first use case, and setting up the agent configs. First run needs supervision.

## Implementation Plan
1. In AGENTS.md or sub-agent config, set `isolation: worktree` per sub-agent
2. Each sub-agent gets a full repo copy on its own branch
3. For batch work: divide files into N groups, spawn N agents (max 10), each handles its group
4. Review branches, merge winners. Losers auto-cleanup.
5. Example: 50 files need API pattern update → 5 agents × 10 files each, all parallel

## Judgment Call
- Best first use case: next time Logan has a multi-file refactor or pattern update on ASF Graphics
- Risk is low (worktrees are isolated), but merge conflicts on shared files need manual review
- Pairs well with the existing CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS env var

## Where to Document
- Add to `learnings/techniques.md` after first successful use
