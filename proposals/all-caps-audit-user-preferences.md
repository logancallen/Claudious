# PROPOSED: Remove ALL CAPS Emphasis from User Preferences
**Finding-ID:** 2026-04-12-all-caps-audit
**Classification:** PROPOSED
**Risk:** REVIEW-REQUIRED | **Impact:** MEDIUM | **Effort:** LOW

## The Problem
`learnings/antipatterns.md` documents a HIGH-severity finding:
> ALL CAPS emphasis is ignored in Claude 4.x in favor of logic and context. Intensity modifiers like "L99:" have no effect. Replace with conditional phrasing.

Logan's User Preferences use ALL CAPS in several places for emphasis (e.g., section headers like "HIGHEST-PRIORITY RULES", "RESPONSE MODE", "BEHAVIORAL RULES", "CODE & BUILD"). While headers are less problematic than inline emphasis, any ALL CAPS inline emphasis (e.g., "ALWAYS", "NEVER") should be replaced with conditional phrasing per the finding.

## Why Not Queued
User Preferences changes are explicitly excluded from auto-queue.

## Recommended Changes
- Replace ALL CAPS inline emphasis with bold or conditional phrasing
- Section headers in ALL CAPS can remain (structural, not emphasis)
- Example: "ALWAYS state confidence" → "State confidence level on every recommendation"

## Action Required
1. Logan reviews and approves specific replacements
2. Test for 1 week
