# Proposal — User Preferences: Adaptive Thinking Bypass

**Status:** DRAFT — User Preferences candidate from monthly retrospective
**Created:** 2026-04-15
**Source entries:** behavioral.md (Adaptive Thinking Nerf — April 2026), techniques.md (Env Var Layer for Claude Code Tuning)
**Independent confirmations:** 2 (community-wide discovery + source-leak env var documentation)

---

## Finding
Anthropic shipped an adaptive thinking throttle in early April 2026 that reduces reasoning depth on tasks the model classifies as routine. The Claude Code fix is the env var `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1`. That env var does not apply to Claude.ai or Cowork sessions, leaving those surfaces still throttled.

## Current State of User Preferences
No directive currently addresses reasoning effort. Logan's preferences emphasize execution speed but do not request maximum reasoning effort by default.

## Proposed Change
Add to User Preferences (in the BEHAVIORAL RULES or REINFORCED RULES section):

> Use maximum reasoning effort by default. Explicitly engage extended thinking for: architectural decisions, multi-file changes, decisions involving more than $10K, irreversible decisions, and any task flagged as needing the response structure (Classify → Best Answer → Risks → Plan → Tracking → Next 3 Actions).

This covers Claude.ai and Cowork surfaces where the env var is not honored.

## Why now
The Claude Code env var fix has been in techniques.md since April 11. The Claude.ai/Cowork side has no equivalent and was flagged in the prior retrospective. The longer the adaptive throttle remains in default position, the more strategic decisions get answered with shallow reasoning.

## Implementation
Logan adds the directive to User Preferences. Test on next strategic decision — confirm reasoning quality improves or holds. If output verbosity grows past useful, tighten the trigger conditions in the directive.

## Risks
- LOW: Maximum reasoning increases latency on simple tasks. Mitigated by the explicit "engage extended thinking for [list]" — routine tasks stay fast.
- LOW: Anthropic may patch the throttle, making the directive redundant. No harm — directive stays inert if no longer needed.

## Next action
Logan adds the directive, runs one strategic-decision task as A/B (with vs. without directive in a parallel session), and locks it in if quality holds.
