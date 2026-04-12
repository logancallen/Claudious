# QUEUED: Clean Stale/Duplicate Alerts from alerts.md
**Finding-ID:** 2026-04-12-clean-stale-alerts
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
`alerts.md` contains 3 SCOUT alerts and 1 CRITICAL AUTODREAM alert. The SCOUT alerts for subagent model and 1M context GA are already covered by proposals (`1m-context-ga-conflict.md`) and queue items. Keeping them in alerts adds noise — alerts should only hold unaddressed items.

## Implementation
1. Remove these two lines from alerts.md (already covered in proposals/queue):
   - `2026-04-12 HIGH SCOUT CLAUDE_CODE_SUBAGENT_MODEL env var...`
   - `2026-04-12 HIGH SCOUT 1M context window GA...`
2. Keep the Agent Teams alert (not yet addressed in queue/proposals)
3. Keep the AUTODREAM alert (actionable — check `/memory` settings)

## Verification
- Confirm alerts.md only contains unaddressed items
