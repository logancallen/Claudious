# Claude Platform — Specific Findings

## Active Findings

### 2026-04-11 — TECHNIQUE — Claude Max Plan Capabilities (April 2026)
**Severity:** HIGH
**Context:** Setup audit confirmation.
**Learning:** Claude Max ($100/month) includes: Opus 4.6, Sonnet 4.6, Haiku 4.5, 1M token context, Projects, Skills, MCP integrations, Cowork, Web Search, Deep Research, Code Execution, Artifacts. NOT included: Auto mode permissions (Team/Enterprise/API only). AutoDream: server-side rollout, not yet on all accounts — check /memory for toggle. Ultraplan: available, no setup needed, use /ultraplan on next complex task.
**Applies to:** All Claude sessions — plan capability awareness

### 2026-04-11 — TECHNIQUE — Ultraplan for Complex Planning
**Severity:** HIGH
**Context:** Available on Max plan, not yet used on a real task.
**Learning:** /ultraplan offloads complex planning to cloud Anthropic infrastructure running Opus 4.6 with multi-agent exploration. Terminal stays free during planning. Use for any task touching 3+ files or requiring architectural decisions. Don't use for pre-planned execution sprints — it's for cloud planning, not execution.
**Applies to:** Claude Code — complex feature planning

## Archive
