# PROPOSAL — Document max_tokens 300K on Message Batches API

**Finding-ID:** 2026-04-17-max-tokens-300k-batch-api
**Impact:** M | **Effort:** T | **Risk:** SAFE
**Source:** Section B-1 — official Claude API release notes

## Finding
max_tokens raised to 300K on Message Batches API for Opus 4.6 + Sonnet 4.6 via `output-300k-2026-03-24` beta header. Enables very large single-request batch outputs.

## Proposed Action
Add a TECHNIQUE entry to `learnings/techniques.md` or `learnings/platforms/claude.md`:

**Learning:** Add `anthropic-beta: output-300k-2026-03-24` header to Message Batches API requests to unlock 300K max_tokens (vs default 8K) on Opus 4.6 and Sonnet 4.6. Use for bulk document processing, large code generation, or export tasks where a single massive output is preferable to chunking.

## Why Proposal (not Auto-Queue)
Medium impact — relevant only to API-heavy workflows, not everyday Claude Code use. Needs Logan's judgment on placement.
