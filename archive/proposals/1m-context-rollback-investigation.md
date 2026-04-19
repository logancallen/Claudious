# Proposal — 1m-context-rollback-investigation

**Source:** intake/2026-04-19.md — Section B, Search 4 (COMMUNITY credibility)
**Impact:** H
**Effort:** L
**Risk:** SAFE
**Routing reason:** COMMUNITY source needs verification; EFFORT=L (not TRIVIAL) → PROPOSE

## Description
Community reports (GitHub issue #36760) indicate Max users lost 1M context access after a feature flag rollback. Anthropic investigating opt-in toggle. Logan is on Max plan — this could affect large-codebase sessions.

## Proposed action
Logan to verify in next Claude Code session: check if 1M context is available by sending a large document. If rollback confirmed:
1. Add GOTCHA to learnings/gotchas.md about 1M context availability being toggle-controlled
2. Watch Anthropic status page / changelog for opt-in toggle announcement

## Note
Do not add to learnings until confirmed — COMMUNITY source, could be user error or resolved already.
