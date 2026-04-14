# PROPOSED: CLAUDE_AUTOCOMPACT_PCT_OVERRIDE — Earlier Compaction Trigger
**Finding-ID:** 2026-04-13-autocompact-pct-override
**Source:** https://www.turboai.dev/blog/claude-code-environment-variables-complete-list
**Classification:** PROPOSED
**Risk:** TEST-FIRST | **Impact:** MEDIUM | **Effort:** LOW (single env var, but needs validation)

## What It Does
Undocumented env var controlling auto-compaction trigger point (0-100 float). Default ~92%. Setting lower (e.g., 85) triggers compaction earlier to preserve response headroom for long outputs.

## Why Not Queued
- Source marks TEST-FIRST (undocumented, silently capped behavior)
- Interacts with existing `CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000` in Logan's env — unclear which takes precedence
- Lower threshold = more frequent compactions = more cache warming overhead

## Implementation Plan
1. Set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=85` on one machine only (recommend Mac)
2. Run 3-5 normal sessions and monitor `/cost` output for compaction timing
3. If it triggers before `CLAUDE_CODE_AUTO_COMPACT_WINDOW` (400k tokens), note which wins
4. If it improves headroom on long code-gen sessions, propagate to PC and document

## Judgment Call
- Pairs with `/compact` warm cache timing technique — if Logan calls `/compact` manually within 5 min, this var matters less
- Skip if current workflow has no headroom problems
- Skip until Logan hits a hard compaction-at-wrong-time problem

## Where to Document
`learnings/techniques.md` under Env Var Layer, with explicit interaction note vs. AUTO_COMPACT_WINDOW.
