# PROPOSAL — "Caveman Mode" for 75% Output Token Reduction

**Finding-ID:** 2026-04-17-caveman-mode-technique
**Impact:** M | **Effort:** T | **Risk:** SAFE
**Source:** Section B-6 — Reddit r/ClaudeAI (10K+ upvotes), Decrypt article

## Finding
"Caveman mode": constrain Claude to stripped-down sentences — tool first, result first, no explanation. Community reports 75% output token reduction. Format: "Tool used: X. Result: Y." — no preamble, no summary, no apology.

## Proposed Action
Add a TECHNIQUE entry to `learnings/techniques.md`:

**Learning:** Caveman mode for token reduction: add to CLAUDE.md or User Preferences — "Respond tool-first, result-first. No preamble, no explanation, no summary. One-sentence max per output unless asked." Community reports 75% output token reduction on r/ClaudeAI. Best for high-frequency tool-use sessions (file edits, searches). Disable for architecture/planning work where reasoning traces are valuable.

## Why Proposal (not Auto-Queue)
Medium impact — significant token savings but may conflict with Logan's preference for detailed reasoning in complex sessions. Needs Logan's judgment on scope (all sessions vs. targeted).
