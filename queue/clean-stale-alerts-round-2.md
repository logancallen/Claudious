# QUEUED: Clean Stale Alerts (Round 2) — AutoDream + Agent Teams

**Classification:** QUEUED (SAFE + HIGH + TRIVIAL, md-only)
**Risk:** SAFE — removing items that are already confirmed live in `mastery-lab/logan-current-setup-v4.md`

## Why Queued
Two alerts in `alerts.md` are already resolved per the current infrastructure snapshot but still occupy the operational alerts list. Leaving them there costs attention budget on every session-start scan.

1. **2026-04-12 CRITICAL AUTODREAM** — `logan-current-setup-v4.md` line 20: "AutoDream: ✅ LIVE — Auto-memory: on, confirmed April 12, 2026." The alert says "Check Claude Code `/memory` settings on all projects to confirm enablement" — that check has been completed.
2. **2026-04-12 HIGH SCOUT Agent Teams** — `logan-current-setup-v4.md` line 113: "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true" is listed under PC env vars. Env var is set; alert is informational residue.

## Implementation Steps
1. In `alerts.md`, delete the block:
   ```
   ### 2026-04-12 — CRITICAL — AUTODREAM
   AutoDream is now available in phased rollout... Check Claude Code `/memory` settings on all projects to confirm enablement.
   ```
2. In `alerts.md`, delete the line:
   ```
   2026-04-12 HIGH SCOUT Agent Teams (shared task list, parallel sessions) — Enable with CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1; strongest pattern for multi-layer feature builds and competing-hypothesis debugging.
   ```
3. Leave the remaining 3 alerts in place (Bash bypass, Skill description 1,536, Arize/MCP_ALLOWLIST) — all have open proposals or are within the 7-day action window.

## Verification
- `alerts.md` should show 3 entries remaining after edit
- No alert references AutoDream or Agent Teams env var

## Applies To
`alerts.md` only — md-only change within Claudious repo.
