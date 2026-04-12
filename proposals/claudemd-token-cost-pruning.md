# PROPOSED: CLAUDE.md Token Cost Audit and Pruning
**Finding-ID:** 2026-04-12-claudemd-token-cost-pruning
**Source:** https://arize.com/blog/claude-md-best-practices-learned-from-optimizing-claude-code-with-prompt-learning/
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** MEDIUM | **Effort:** MEDIUM (requires auditing all CLAUDE.md files)

## What It Does
CLAUDE.md is loaded at every session start AND every sub-agent invocation. Bloated files waste tokens multiplicatively. Optimized files showed +5-10% improvement on SWE Bench.

## Why Not Queued
Logan already has the 200-line rule in Claudious CLAUDE.md. But this finding goes further — audit for descriptive/aspirational content, measure before/after. Requires reviewing all project CLAUDE.md files, which is not trivial.

## What's New Beyond Current Setup
- **Audit discipline:** Cut anything descriptive or aspirational that doesn't change behavior
- **Progressive disclosure:** Reference external files for deep context instead of inlining
- **Measurement:** Track session token usage before/after pruning over 1 week

## Implementation Plan
1. List all CLAUDE.md files across projects (global, ASF, Courtside Pro, Claudious, etc.)
2. For each: count lines, identify descriptive/aspirational content, flag for removal
3. Move domain knowledge to separate referenced files
4. Measure token usage for 1 week before, then 1 week after
5. Document results in `learnings/techniques.md`

## Judgment Call
- Logan's CLAUDE.md files may already be lean — audit first before assuming waste
- The multiplicative cost on sub-agents is the key insight (N sessions × M sub-agents × CLAUDE.md tokens)
