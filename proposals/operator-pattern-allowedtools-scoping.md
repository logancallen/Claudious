# PROPOSAL: Operator Pattern with --allowedTools Scoping for Subagents

**Finding-ID:** 2026-04-14-operator-pattern-allowedtools
**Source:** https://www.mindstudio.ai/blog/claude-code-agentic-workflow-patterns
**Classification:** PROPOSAL (TEST-FIRST, requires subagent refactor)
**Risk:** TEST-FIRST — misscoped tools will cause agent failures that may be silent

## Why Proposed
Requires edits to existing `.claude/agents/*.md` files on both ASF Graphics and Courtside Pro repos. Not an md-only edit inside the Claudious repo — it's a cross-project refactor.

## Problem It Solves
Current agents (`builder`, `migrator`, `deployer`, `rls-auditor`, `context-scout`, `migration-validator`) inherit the orchestrator's full tool set. Risk: a frontend agent could accidentally run a migration; a deployer agent could edit source. Deterministic scoping eliminates this class of error.

## Proposed Change
Add `allowedTools` to YAML frontmatter of every agent definition:

- `builder` (ASF): `allowedTools: [Edit, Read, Glob, Grep]` — no Bash
- `migrator` (ASF): `allowedTools: [Bash, Read, Edit]` — no browser, no Task
- `deployer` (ASF): `allowedTools: [Bash, Read]` — read-only on source, shell for verification
- `rls-auditor` (global): `allowedTools: [Read, Grep, Glob]` — read-only
- `context-scout` (global): `allowedTools: [Read, Grep, Glob, WebSearch]` — research scope
- `migration-validator` (global): `allowedTools: [Bash, Read]` — same as deployer

Orchestrator (main session) keeps full scope; only subagents get restricted.

## Pairs With
- `proposals/commit-subagents-to-repo.md` — this proposal refines that one by adding scoping. Consider merging or landing together.
- `learnings/patterns.md` "Agent Specialization via .claude/agents/" — this proposal is the next-level version of that pattern.

## Rollback
Remove `allowedTools` key from each YAML. Agents revert to full scope. No data loss.

## Testing Protocol
1. Start with one agent (`builder`). Add scoping. Run one real task.
2. If successful, cascade to remaining agents one at a time.
3. Watch for "tool not available" errors in session logs. Expand scope only when a legitimate need surfaces.

## Confidence: MEDIUM (70%)
Source is a single pattern blog; the underlying CLI flag (`--allowedTools`) is documented Claude Code behavior. The mechanism works. Uncertainty is in picking the right scope per agent on the first try.

**Strongest reason this could be wrong:** A scoped agent may fail silently on a task that needs a tool it doesn't have, wasting a turn. Mitigation: start with the most obviously bounded agent (builder) and audit logs after first real use.

## Applies To
ASF Graphics `.claude/agents/`, Courtside Pro `.claude/agents/`, global `~/.claude/agents/`.
