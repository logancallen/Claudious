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

### 2026-04-19 — TECHNIQUE — Opus 4.7 GA: Most Capable Model + xhigh Effort
**Severity:** HIGH
**Context:** Opus 4.7 became generally available for Max subscribers in April 2026.
**Learning:** Opus 4.7 is the most capable Claude model as of April 2026. Adds `xhigh` effort level (above `high`) for maximum reasoning depth. Auto mode (automatic model selection per task) is available for Max subscribers on Opus 4.7 only. Use `--model claude-opus-4-7` in Claude Code or set in ~/.claude/settings.json. For planning heavy tasks, Opus 4.7 + effort:xhigh is now the ceiling.
**Applies to:** All Claude Code sessions — model routing in techniques.md subagent patterns

### 2026-04-19 — TECHNIQUE — Computer Use in Cowork (Max Plan, No Setup)
**Severity:** HIGH
**Context:** Anthropic released Computer Use via Cowork to Pro and Max plan subscribers in April 2026.
**Learning:** Computer Use is now available in Cowork for Max plan (Logan eligible). Claude can open files, run dev tools, point/click/navigate the screen inside the sandbox. No setup required — it activates in Cowork automatically. Best use: UI validation tasks, running test suites, file operations that benefit from visual confirmation. Constraint: Cowork sandbox still cannot access multiple repos simultaneously (see gotchas.md).
**Applies to:** All Cowork sessions on Max plan

### 2026-04-19 — TECHNIQUE — Persistent Agent Thread for Mobile+Desktop Cowork
**Severity:** HIGH
**Context:** Anthropic released Persistent Agent Thread for Cowork task management in April 2026 (Max first, then Pro).
**Learning:** Persistent Agent Thread lets Logan manage Cowork tasks from mobile (iOS/Android) and desktop (Claude Desktop) simultaneously. Tasks started in Cowork are accessible via the app — no need to stay at the computer while a long Cowork session runs. Max plan rollout is complete; Pro plan following. Use for: long-running Claudious process runs, overnight research tasks, build sessions that can be monitored from mobile.
**Applies to:** All Cowork sessions on Max plan — Claudious process, ASF build sessions

### 2026-04-20 — TECHNIQUE — Sonnet 4.5 / Sonnet 4 1M Context Beta Retires 2026-04-30
**Severity:** HIGH
**Context:** Anthropic official deprecation: the 1M-token context window beta on `claude-sonnet-4-5` and `claude-sonnet-4` retires 2026-04-30. After that date, those model IDs silently drop back to the base 200K window.
**Learning:** Before 2026-04-30, audit any Sonnet 4.5 / Sonnet 4 pinned callers (Claude Code subagents with `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6` are unaffected because they target 4.6, but any caller pinned to `claude-sonnet-4-5` or `claude-sonnet-4` that relies on the 1M beta header will degrade). Migration path: switch long-context workloads to Opus 4.7 (native 1M not guaranteed — check current state) or re-chunk to 200K. Grep for `claude-sonnet-4-5`, `claude-sonnet-4-20250514`, and any `beta.*context-1m` header in project configs.
**Applies to:** Any Claude API / Claude Code caller pinned to Sonnet 4.5 or Sonnet 4 with long-context usage — audit window closes 2026-04-30

## Archive
