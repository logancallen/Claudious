# CLAUDE.md Prune-Aggressively Rule — promote to prompting-rules.md?

**Source:** archive/intake/2026-04-24.md § B — 2026-04-24-boris-claudemd-pruning-rule
**Credibility:** COMMUNITY (Boris Cherny threads, re-surfaced via code.claude.com best-practices)
**Impact:** MEDIUM | **Effort:** TRIVIAL | **Risk:** SAFE

## Summary
Over-specified `CLAUDE.md` causes Claude to ignore parts of it because important rules get lost in noise. Recommended pattern: ruthlessly prune; delete instructions Claude already follows correctly; convert repeatable rules to hooks. Aligns with existing Claudious prompting discipline but is not yet explicitly captured as a canonical rule.

## Why proposal (not auto-deploy)
- Credibility is COMMUNITY (Boris Cherny is authoritative for CC, but the specific rule wording is community-restated). Auto-queue demands the rule be safe to mirror to `canonical/prompting-rules.md` verbatim — COMMUNITY credibility falls below that bar.
- Intake labeled relevance MEDIUM; auto-queue requires HIGH.
- Existing Claudious CLAUDE.md has already been pruned once (April 2026). The question is whether to codify the pruning heuristic as a universal rule, not whether to act on it now.

## Logan action
Decide:
- Promote as `claudemd-prune-aggressively` under `canonical/prompting-rules.md § Knowledge Architecture`. Suggested wording:
  > Prune CLAUDE.md ruthlessly. Delete any instruction Claude already follows correctly. Convert repeatable rules to hooks when possible. Over-specification causes Claude to ignore parts of CLAUDE.md because important rules get lost in noise.
- Or wait for a second independent OFFICIAL citation before graduating (current Claudious graduation bar: 3 cross-references or OFFICIAL+Logan-confirmation).

## Reference links
- https://code.claude.com/docs/en/best-practices
- Boris Cherny Jan–Feb 2026 Twitter/X threads (re-surfaced April 2026)
