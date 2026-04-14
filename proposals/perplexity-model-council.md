# PROPOSED: Evaluate Perplexity Model Council
**Finding-ID:** 2026-04-13-perplexity-model-council
**Source:** https://blog.mean.ceo/perplexity-news-april-2026/
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** LOW-MEDIUM | **Effort:** LOW (subscription check + trial)

## What It Does
Perplexity Pro/Max feature that runs a single prompt against multiple AI models (GPT, Claude, DeepSeek R1, etc.) and shows outputs side-by-side. Evaluation tool, not replacement.

## Why Not Queued
- Requires Perplexity Pro/Max subscription (cost check)
- Value depends on whether Logan's current model-selection process is a bottleneck
- Past proposal `2026-04-12-perplexity-computer-agent` was also flagged PROPOSED for cost review — keep pattern consistent

## Implementation Plan
1. Check current Perplexity subscription tier (Pro, Max, or none)
2. If already subscribed, test Model Council on 3 real Logan prompts:
   - A financial modeling question (ops domain)
   - A code-generation question (dev domain)
   - A strategic framing question (OS domain)
3. Compare outputs — does cross-model variance change the routing decision vs. User Preferences current guidance (Claude = default, ChatGPT/Grok/Perplexity called out by situation)?
4. If yes, document a decision rule in `operating-system` skill
5. If no, note in processed.log and move on

## Judgment Call
- Logan already has routing rules in User Preferences ("Route tasks to ChatGPT, Grok, or Perplexity when they're the better tool")
- Model Council would sharpen that routing with empirical evidence
- ROI = marginal unless Logan hits a task type where model choice feels coin-flip

## Where to Document
- `operating-system` skill (routing rules) — only if kept
- `learnings/techniques.md` if a reusable pattern emerges

## Action Required
Logan: confirm Perplexity subscription tier. If Pro/Max, spend 15 min testing.
