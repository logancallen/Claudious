# Active Alerts
<!-- Written by automated systems. Checked at every session start. -->
<!-- Format: [DATE] [SEVERITY: CRITICAL/HIGH/LOW] [SYSTEM] [Message] -->
<!-- Clear an alert by deleting its line after addressing it. -->

## Current Alerts
2026-04-13 HIGH SCOUT Bash tool permission bypass patched in v2.1.98 — backslash-escaped flags could bypass safety checks. Update immediately if below v2.1.98.
2026-04-13 HIGH SCOUT Skill description limit raised from 250→1,536 chars in v2.1.105 — re-expand all 15+ custom skill descriptions for better trigger accuracy. Also: PreCompact hook blocking, stalled stream auto-abort, MCP buffer leak fix.

2026-04-14 HIGH SCOUT Arize prompt-learning methodology yields +5-10% SWE Bench gain via structured CLAUDE.md iteration (diff failing output → extract corrective instruction → test removal too). SAFE, methodology only. Also: CLAUDE_CODE_MCP_ALLOWLIST_ENV to restrict env inheritance to MCP servers (security hardening for Logan's 5+ MCP setup).

2026-04-14 CRITICAL ASF-GRAPHICS Migrations 026-028 broke employee permissions. Root cause unidentified. Do NOT run new migrations until resolved. Dedicated audit session required.
