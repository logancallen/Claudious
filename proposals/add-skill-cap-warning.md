# PROPOSED: Add Skill Count Cap Warning to Global CLAUDE.md or Skills Index
**Finding-ID:** 2026-04-12-skill-cap-warning
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** MEDIUM | **Effort:** TRIVIAL

## The Problem
Two learnings entries (behavioral.md and gotchas.md) document that Claude truncates the `available_skills` block at ~34-36 skills, causing skills to stop matching. This is a critical constraint for Logan's setup — he has skills across global, ASF Graphics, Courtside Pro, and Cowork plugins.

Current Cowork session shows **42+ skills** in the available_skills block (counting all plugin skills). If Logan is near or past the cap in Claude Code sessions, some skills are silently not triggering.

No CLAUDE.md or config file currently warns about this limit or provides a count.

## Why Not Queued
Requires determining where the warning belongs (global CLAUDE.md vs. skills/index.md) and current skill count audit across all contexts.

## Recommended Implementation
1. Count total skills across all projects and global config
2. Add to `skills/index.md`: "**Current count: [N] / 34 max.** Skills beyond ~34 may not auto-trigger."
3. If count exceeds 34: audit for consolidation or deprecation candidates
4. Add to Pioneer's analysis checklist: "Check total skill count against 34 cap"

## Action Required
1. Logan confirms which Claude Code contexts have the most skills loaded
2. Decide whether to prune or accept the risk of truncation
