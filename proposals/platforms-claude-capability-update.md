# PROPOSAL — Update learnings/platforms/claude.md: Fix 1M Context and AutoDream Status

**Finding-ID:** 2026-04-17-platforms-claude-capability-update
**Impact:** H | **Effort:** T | **Risk:** SAFE
**Source:** Section B-4 (Cowork context drop) + Section D (stale platform entry)

## Problem
`learnings/platforms/claude.md` has two stale entries:
1. Line 8 states Claude Max includes "1M token context" — Cowork dropped to 200K after Claude Desktop v1.1.7714 (mid-March 2026). Confirmed via TechRadar + GitHub issue #36760.
2. Line 8 states "AutoDream: server-side rollout, not yet on all accounts" — AutoDream moved to proposals on 2026-04-12 (enable-autodream.md MOVED-TO-PROPOSALS).

## Why Critical
Stale capability entry will cause Logan to plan Cowork tasks around 1M context that no longer exists, leading to task failures mid-run.

## Proposed Change
Update `learnings/platforms/claude.md` line 8 (Claude Max capabilities):
- Change "1M token context" → "200K token context (Cowork; dropped from 1M after v1.1.7714 March 2026)"
- Change "AutoDream: server-side rollout..." → "AutoDream: moved to proposals, not yet available (check enable-autodream.md proposal)"

## Why Proposal (not Auto-Queue)
Editing an existing learnings entry (not pure append) — requires review to avoid breaking existing context in the file.

## Verification
`grep -c "200K" learnings/platforms/claude.md` ≥1
