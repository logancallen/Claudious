# PROPOSED: Audit and Rewrite Negative Instructions in User Preferences
**Finding-ID:** 2026-04-12-user-prefs-negative-audit
**Classification:** PROPOSED
**Risk:** REVIEW-REQUIRED | **Impact:** HIGH | **Effort:** MEDIUM

## The Problem
`learnings/behavioral.md` documents a CRITICAL finding:
> Claude 4.x paradoxically increases attention on things you tell it NOT to do. "Don't write a fluffy intro" → Claude focuses on fluff. Fix: reframe ALL negative instructions as positive direction.

Logan's User Preferences contain multiple negative instruction patterns:
- "Long-form prose only when explicitly requested" (implicit negative)
- Various "never" and "don't" patterns throughout

These are actively degrading Claude's adherence to the preferences because Claude fixates on the negated behavior.

## Why Not Queued
User Preferences are explicitly excluded from auto-queue. Changes here require Logan's direct review and approval.

## Recommended Rewrite Examples
| Current (Negative) | Proposed (Positive) |
|---|---|
| "Long-form prose only when explicitly requested" | "Default to bullets and headers. Switch to prose when Logan requests it." |

A full audit would identify all negative patterns and propose positive rewrites.

## Action Required
1. Logan reviews full User Preferences for negative patterns
2. Each rewrite approved individually
3. Test over 1 week and compare output quality
