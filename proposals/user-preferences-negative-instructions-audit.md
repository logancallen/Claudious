# Proposal — User Preferences: Negative Instructions Audit

**Status:** DRAFT — User Preferences candidate from monthly retrospective
**Created:** 2026-04-15
**Source entries:** behavioral.md (Claude 4.x Fixates on Negative Instructions), antipatterns.md (ALL CAPS Emphasis in Claude 4.x)
**Independent confirmations:** 2 (DreamHost empirical testing + deep architecture research)

---

## Finding
Claude 4.x paradoxically increases attention on instructions phrased as negations. "Don't write a fluffy intro" → Claude focuses on fluff. The same attention-mechanism finding underlies the ALL CAPS antipattern.

## Current State of User Preferences
Logan's User Preferences contain multiple negative-form instructions, including:
- "never use words like 'genuinely', 'honestly'"
- "Avoid the use of emotes or actions inside asterisks"
- "Claude doesn't always ask questions"
- Multiple "do NOT" patterns in skill triggers

## Proposed Change
Audit every negative instruction in User Preferences. Rewrite each as positive direction.

Examples:
- "Don't ask multiple questions" → "Ask at most one clarifying question per response."
- "Avoid weak plans" → "Replace weak plans with the strongest alternative."
- "Never use ALL CAPS for emphasis" → "Use conditional phrasing for emphasis: 'If X, do Y.'"
- "Avoid emojis unless asked" → "Use emojis only when the user explicitly requests them."

Carve-outs: hard prohibitions ("never share credentials," "never execute trades") stay as negatives because the emphasized attention is the desired effect — Claude SHOULD fixate on these.

## Why now
This finding has two independent confirmations and was already flagged in the prior retrospective. No action has been taken yet. Every day the negative phrasing remains, every Claude session is degraded by it.

## Implementation
Logan reviews User Preferences, applies positive-form rewrites manually, and tests output quality on 3-5 typical task types over the following week. If quality holds or improves, lock in. If it degrades, revert specific changes.

## Risks
- LOW: Some negative instructions are intentional emphasis. Carve-out list above protects them.
- LOW: Rewrites can be longer than negations. Token cost is on every message — keep rewrites tight.

## Next action
Logan opens User Preferences, finds every "never," "don't," "avoid," "doesn't," "no" pattern, and decides per instance: rewrite positively, keep as a hard prohibition, or delete.
