---
proposal_date: 2026-04-22
source: monthly retrospective 2026-04
type: user-preferences-update
citation_count: 2 (independent)
citations:
  - learnings/behavioral.md § 2026-04-11 Context-Before-Question Yields 30% Better Results (DreamHost empirical testing, Claude 4.x)
  - learnings/techniques.md § 2026-04-11 GitHub Closed-Loop Knowledge Sync (architecture research — cites same context-weighting behavior as rationale for docs/ placement)
status: awaiting-logan-review-in-mastery-lab
note: Per User Preferences (§ Claude Mastery Lab role), ALL User Preferences edits route through a Mastery Lab session.
---

# USER PREFERENCES UPDATE CANDIDATE — Context-Before-Question placement rule

## Finding

On long-context prompts (>5K tokens — large docs, code, research bundles), placing all reference material BEFORE the question yields ~30% better results than the inverse. Claude weights the end of context most heavily; the question at end gets maximum attention. For prompts under 5K tokens the effect is negligible.

Empirically validated:
- DreamHost empirical testing on Claude 4.x
- Confirmed by deep architecture research (referenced in learnings/techniques.md 2026-04-11 cluster)

Behavior has held across the Claude 4.x family through Opus 4.7 — no contradicting evidence in the corpus.

## Why this should be in User Preferences, not just learnings

This is a prompting rule Logan applies when passing content downstream to Claude Code, other AIs, or external systems. The existing User Preferences § Downstream content rule covers completeness vs. iteration, but does NOT specify structural ordering. Encoding "context first, question last" as a default for downstream prompts >5K tokens costs ~one line and prevents silent quality loss on every research-heavy handoff.

## Proposed addition to User Preferences

**Section:** Downstream content rule (existing section — append)

**New text to append:**

> For downstream prompts >5K tokens, place all reference material BEFORE the question. Claude weights end of context most heavily; structure as `[all context] → [question last]` for maximum attention on the ask. Under 5K tokens the effect is negligible and ordering can be ergonomic.

## Alternative placement

Could also live under the new Opus 4.7 behavioral calibration section — but that section is model-specific and this behavior pre-dates Opus 4.7. Downstream content rule is the better home because it governs prompts Logan passes to other agents.

## Risks and edge cases

- Does not apply inside multi-turn iterative chats (each turn is short).
- Does not apply to CLAUDE.md content (that's system-prompt territory, different budget).
- Does apply to Claude Code slash-command prompts that bundle large context, to ChatGPT/Grok/Perplexity handoffs, and to Cowork scheduled-task prompts.

## Open question for Logan

Is the 5K-token threshold accurate for Opus 4.7 with its 1M context? The DreamHost testing was pre-Opus-4.7. The effect may kick in later (e.g. 20K tokens) with larger contexts. Lower-risk to keep the 5K threshold — false positives only cost structure, not correctness. Flag for re-verification if downstream output quality drops after adopting the rule.
