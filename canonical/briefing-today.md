# Briefing — 2026-04-20

## System Health
- Intake: COMPLETE (04:10) · Process: COMPLETE (04:24) · Curate: COMPLETE (this run)
- Week: bootstrapping (4 / 7 ledger days present) · Grade: deferred until ≥7 days

## Action Required
- `skill-description-1536-chars-audit` — rewrite 15+ custom skill descriptions to 1,536-char limit (~45 min).
- `context-mode-mcp-plugin` — 1-session test vs your 12-MCP setup; claimed 50–90% token reduction.
- `user-preferences-adaptive-thinking-bypass` — paste `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1` into User Preferences.
- `mcp-allowlist-env-security-hardening` — define `CLAUDE_CODE_MCP_ALLOWLIST_ENV` for 12 MCP servers.
- `bash-permission-bypass-patch` — confirm `claude --version` ≥ 2.1.98 (canonical reports 2.1.113; likely auto-resolvable).
- Full list: `canonical/open-decisions.md` (28 proposals awaiting judgment).

## Shipped Overnight
- `disable-skill-shell-execution` — technique appended to `learnings/techniques.md` (WORKING, grep-verified).
- `sonnet-1m-context-retirement-warning` — 2026-04-30 retirement note appended to `learnings/platforms/claude.md` (WORKING, grep-verified).
- Canonical refresh: `claude-state.md` (deprecation schedule + managed-agents beta) and `claude-code-state.md` (MCP 500K, disableSkillShellExecution, push-notification tool, /team-onboarding, /autofix-pr, /doctor MCP scope warning, computer-use CLI preview, edit-on-cat/sed).

## Alerts
- **CRITICAL** ASF-GRAPHICS migrations 026–028 broke employee permissions — do NOT run new migrations until audit session (active since 2026-04-14).
- **HIGH** Bash permission bypass patched in v2.1.98 — verify current version.
- **HIGH** Skill description limit 250→1,536 — 15+ custom descriptions pending rewrite.
- **HIGH** `context-mode` MCP plugin pending test; GrowthBook tengu_* remote kill-switches; `CLAUDE_CODE_MCP_ALLOWLIST_ENV` hardening.

## Findings Worth Surfacing
- **Sonnet 4.5 / 4 1M context retires 2026-04-30** — 10 days out; audit any workflow still pinned to legacy Sonnet 1M beta.
- **MCP 500K result storage** (Week 15-16) — raises payload ceiling; can change what's worth sending through MCP vs inline.
- **/doctor now warns on MCP scope drift** — use before triaging MCP-break bugs.
