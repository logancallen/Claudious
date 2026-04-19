# PROPOSED: Sub-Agent Invocation Quality Framework (4 Required Components)
**Finding-ID:** 2026-04-13-subagent-invocation-quality
**Source:** https://claudefa.st/blog/guide/agents/sub-agent-best-practices
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** HIGH | **Effort:** MEDIUM (CLAUDE.md edits + discipline shift)

## What It Does
Structured sub-agent invocation protocol: every invocation includes (a) comprehensive context, (b) explicit deliverables, (c) specific file paths, (d) measurable success criteria. Uses domain-based routing (frontend/backend/database agents — no file overlap). Sequential chains: schema → API → frontend.

## Why Not Queued
- Touches CLAUDE.md which loads on every message — per `antipatterns.md`, every line has multiplicative token cost
- Needs careful compression to 3-5 lines
- Interacts with existing `.claude/agents/` pattern (`patterns.md` entry) — must be consistent
- First deploy should be one project, not global

## Implementation Plan
1. Draft compact rule block for project-level CLAUDE.md (not Claudious global):

```
## Sub-Agent Dispatch Rules
When invoking a sub-agent, include: (1) relevant context, (2) explicit deliverables, (3) exact file paths, (4) measurable success criteria. Assign by domain (frontend/backend/db) with no file overlap. For sequential chains: schema first, then API, then frontend.
```

2. Deploy to ASF Graphics CLAUDE.md first (most sub-agent usage)
3. Run 1 week of sessions, measure sub-agent first-try success rate
4. If improved, propagate to Courtside Pro
5. Skip Claudious global — too broad

## Judgment Call
- Pairs with `Agent Specialization via .claude/agents/` pattern already in `patterns.md`
- Pairs with `split-and-merge worktree` proposal
- Risk is low, but token cost per message is permanent — must earn its slot

## Where to Document
- `learnings/patterns.md` — new PATTERN entry after validation
- Project-level CLAUDE.md files (not global)

## Action Required
Logan: approve ASF Graphics as first deployment target, or nominate another project.
