# QUEUED: /compact with Warm Cache Timing
**Finding-ID:** 2026-04-12-compact-warm-cache-timing
**Source:** https://www.mindstudio.ai/blog/claude-code-token-management-hacks-3
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
Calling `/compact` within 5 minutes of your last message hits the prompt cache discount, reducing summarization cost. Can shrink 80K-token histories to 12K while preserving critical context.

## Implementation Instructions
1. After every 10-15 turns (or ~25 with 1M context), call `/compact Focus on [what matters]`
2. Call it **immediately** after your last message — within the 5-minute cache window
3. Custom focus string tells Claude what to preserve during summarization
4. Example focus strings:
   - `/compact Focus on code samples, API patterns, and architecture decisions`
   - `/compact Focus on schema changes and migration state`
5. Expected result: 70%+ total token reduction over a multi-hour session

## Where to Document
- Add to `learnings/techniques.md` as a new TECHNIQUE entry
- Reference in any project CLAUDE.md that has session management notes

## Verification
- Compare token usage on next 3 sessions: one without timing, two with timed compaction
- Check that critical context survives compaction by asking about earlier decisions post-compact
