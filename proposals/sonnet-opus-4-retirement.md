# PROPOSAL — Log Claude Sonnet 4 / Opus 4 Retirement (June 15, 2026)

**Finding-ID:** 2026-04-17-sonnet-opus-4-retirement
**Impact:** M | **Effort:** T | **Risk:** SAFE
**Source:** Section B-1 — official Claude API release notes

## Finding
Claude Sonnet 4 (`claude-sonnet-4-20250514`) and Opus 4 (`claude-opus-4-20250514`) announced for deprecation — retirement June 15, 2026. These are distinct from the currently active Sonnet 4.6 and Opus 4.6 (claude-sonnet-4-6, claude-opus-4-7).

## Proposed Action
Add a GOTCHA entry to `learnings/gotchas.md`:

**Learning:** Sonnet 4 (`claude-sonnet-4-20250514`) and Opus 4 (`claude-opus-4-20250514`) retire June 15, 2026. Any hardcoded model IDs using the `20250514` suffix will break. Audit all project configs, API calls, and skill model overrides now. Migrate to `claude-sonnet-4-6` and `claude-opus-4-7` (or `claude-opus-4-6` for cost-sensitive runs).

## Why Proposal (not Auto-Queue)
Requires Logan to audit model IDs across ASF Graphics and Courtside Pro configs — action item, not just a knowledge append.
