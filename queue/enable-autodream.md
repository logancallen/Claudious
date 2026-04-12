# Enable AutoDream on All Projects

**Date:** 2026-04-12
**Priority:** CRITICAL
**Status:** Action Required

## Background
AutoDream began phased rollout late March 2026. It automatically consolidates Claude Code memory files — pruning stale entries, merging duplicates, resolving contradictions, and converting relative dates to absolute timestamps.

## Trigger Conditions
- 24 hours since last memory organization
- At least 5 new conversation records accumulated
- Runs as background sub-agent (non-blocking)

## Action: Enable on All 7 Projects
1. Open each Claude Code project
2. Run `/memory` to check current AutoDream status
3. If not enabled, toggle AutoDream on in memory settings
4. Verify by checking for auto-dream entries in CLAUDE.md after next session

## Projects to Check
- All 7 active Claude projects (reference logan-os for full project index)

## Notes
- Feature was found via source code leak before official announcement
- Phased rollout — may not be available on all accounts yet
- If not visible in `/memory`, check again in 1 week
