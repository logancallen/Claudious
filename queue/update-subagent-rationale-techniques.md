# QUEUED: Update Subagent Model Rationale in techniques.md
**Finding-ID:** 2026-04-12-update-subagent-rationale
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
The env var entry in `learnings/techniques.md` currently says:
> `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (pins sub-agents to 1M context vs Opus 200k cap)`

This is factually incorrect as of March 2026 — Opus 4.6 now has 1M context at no premium. The real reason to keep Sonnet sub-agents is **cost savings (50-70%)**, not context size.

## Implementation
1. In `learnings/techniques.md`, find the Env Var Layer entry
2. Change the SUBAGENT_MODEL comment from `(pins sub-agents to 1M context vs Opus 200k cap)` to `(50-70% cost savings on delegated work; Opus 1M now available if quality needed)`
3. In the same entry, update compaction guidance: with 1M on Opus, 25-30 turns before `/compact` instead of 10-15

## Verification
- Read the updated entry and confirm the rationale is accurate
