# CONFLICT: 1M Context Window GA — Subagent Model Rationale Outdated
**Finding-ID:** 2026-04-12-1m-context-ga
**Source:** https://code.claude.com/docs/en/costs
**Classification:** CONFLICT

## The Conflict
Logan's `learnings/techniques.md` states:
> `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (pins sub-agents to 1M context vs Opus 200k cap)`

But as of March 2026, **Opus 4.6 also has 1M context at no price premium**. The stated rationale for using Sonnet sub-agents (1M context) is no longer valid.

## Both Sides

### Keep Sonnet Sub-Agents
- **Cost savings still valid:** Sonnet is cheaper per token than Opus — 50-70% savings on delegated work
- **Sub-agent tasks are often simpler:** Don't need Opus-level reasoning for file reads, searches, etc.
- **Working fine as-is:** No quality complaints reported

### Switch Sub-Agents Back to Opus
- **Quality improvement:** Opus is better at complex sub-tasks (architecture analysis, multi-file refactors)
- **1M context on both:** No context penalty for using Opus anymore
- **Simpler config:** Remove the env var entirely, sub-agents use same model as main session

## Recommendation
**Keep Sonnet sub-agents for cost savings, but update the documented rationale.** The 1M context reason is dead — the real reason is cost. Update `learnings/techniques.md` to say:
> `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (50-70% cost savings on delegated work; Opus 1M context now available if quality needed)`

Also update compaction strategy notes: with 1M context on Opus, you can go 25-30 turns before needing `/compact` instead of the old 10-15.

## Action Required
1. Update rationale in `learnings/techniques.md` env var entry
2. Update any compaction timing references that assumed 200K limit
3. Consider testing Opus sub-agents on one complex project to see if quality delta justifies cost
