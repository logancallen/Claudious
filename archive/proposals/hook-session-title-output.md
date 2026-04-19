# PROPOSAL — UserPromptSubmit Hook: `hookSpecificOutput.sessionTitle`

**Finding-ID:** 2026-04-16-hook-session-title-output
**Disposition:** SAFE — additive hook capability; requires authoring work
**Category:** PATTERN / HOOK
**Source:** https://releasebot.io/updates/anthropic/claude-code (v2.1.94)

## Rationale
UserPromptSubmit hooks can now set the session title programmatically by returning JSON with `hookSpecificOutput.sessionTitle`. Titles propagate to Claude Code's session list and transcript UI, making session-info retrieval searchable.

**Highest-leverage use case for Logan:** auto-tag scheduled-task sessions (Scout, Evaluator, Implementer, Harvester) by detected role so retro review (via `session_info.list_sessions`) is clean. Today they all look the same in the list.

## Risks
- Hook authoring is one-off work. If the hook crashes, the main prompt may or may not still submit cleanly.
- **Title collisions** between sessions with similar intent — not broken, just noisy.

## Required Actions (for Logan's review)
1. Draft a UserPromptSubmit hook that inspects prompt text for keywords:
   - "Scout" / "scout report" → title: `Claudious-Scout YYYY-MM-DD`
   - "Evaluator" / "triage" → title: `Claudious-Evaluator YYYY-MM-DD`
   - "Implementer" / "deploy" → title: `Claudious-Implementer YYYY-MM-DD`
   - ASF / Courtside / Claudious project keywords → tag accordingly
   - Fallback: first 60 chars of prompt
2. Install globally at `~/.claude/hooks/set-session-title` or equivalent, or per-project under `.claude/hooks/`.
3. Verify with a few test prompts; inspect `/sessions` list after.
4. Optional: also add `hookSpecificOutput` for workflow metadata if schema allows.

## Rollback Plan
Remove hook file or comment out; sessions revert to default auto-titled behavior.

## Open Questions
- Max title length?
- Does setting a title mid-session (later prompt) overwrite the earlier one, or is it set-once-at-start?
- Interaction with Cowork's own session naming?

**Recommend:** LOW priority unless Logan's session list has gotten noisy enough that search friction is real. Worth an afternoon if yes.
