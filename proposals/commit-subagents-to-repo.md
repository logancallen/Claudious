# PROPOSED: Commit Specialized Sub-Agents to .claude/agents/
**Finding-ID:** 2026-04-12-commit-subagents-to-repo
**Source:** https://dev.to/lizechengnet/how-to-structure-claude-code-for-production-mcp-servers-subagents-and-claudemd-2026-guide-4gjn
**Classification:** PROPOSED
**Risk:** TEST-FIRST | **Impact:** HIGH | **Effort:** MEDIUM (identify workflows, write agent configs, test)

## What It Does
Build dedicated sub-agents for repetitive tasks (PR review, DB seeding, pre-deploy checks) and commit them to `.claude/agents/` with restricted tool access. Turns repetitive workflows into one-command operations.

## Why Not Queued
Risk is TEST-FIRST (not SAFE). Requires identifying the right workflows to automate and writing proper agent configs with tool restrictions. First implementation needs supervision.

## Implementation Plan
1. Identify top 3-5 repetitive workflows across ASF Graphics and Courtside Pro
   - Candidates: PR review, deploy checks, data migration, schema validation, test runs
2. Create AGENTS.md files in `.claude/agents/` for each
3. Define allowed tools per agent (e.g., deploy-checker gets Read + Bash only, not Write)
4. Commit to repo so agents are versioned and shared
5. Invoke with `/agent [name]` or via sub-agent spawning

## Judgment Call
- High leverage if Logan does these tasks >2x/week each
- Restricted tool access is the key safety feature — prevents agents from doing more than intended
- Start with ONE agent (e.g., pre-deploy checks) and expand after validating the pattern
- Pairs well with the existing skill system but operates at a different level (agents vs. skills)
