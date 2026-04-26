# Claude Code — Current State

**Last updated:** 2026-04-26
**Version:** 2.1.119 (released 2026-04-23)
**Default model:** Opus 4.7

---

## Features Shipped 2.1.114 → 2.1.119 (Logan-relevant)

- **Settings persistence** (2.1.119) — `/config` settings (theme, editor mode, verbose, etc.) now persist to `~/.claude/settings.json` and participate in project/local/policy override precedence.
- **`--print` mode honors agent frontmatter** (2.1.119) — `--print` mode honors agent `tools:` and `disallowedTools:` frontmatter, matching interactive-mode behavior.
- **`--agent` honors built-in `permissionMode`** (2.1.119) — `--agent <name>` now honors the agent definition's `permissionMode` for built-in agents.
- **Hook duration tracking** (2.1.119) — `PostToolUse` and `PostToolUseFailure` hook inputs include `duration_ms` (excludes permission prompts and PreToolUse hooks).
- **Parallel MCP reconfig** (2.1.119) — subagent and SDK MCP server reconfiguration connects servers in parallel instead of serially.
- **Headless status line additions** (2.1.119) — stdin JSON now includes `effort.level` and `thinking.enabled` (relevant to Claudious scheduled routines).
- **OpenTelemetry richer events** (2.1.119) — `tool_result` and `tool_decision` events include `tool_use_id`; `tool_result` also includes `tool_input_size_bytes`.
- **Agent `mcpServers` for main thread** (2.1.117) — agent frontmatter `mcpServers` are now loaded for main-thread agent sessions via `--agent`.
- **Model selection persists across restarts** (2.1.117) — selections persist even when project pins a different model.
- **Concurrent MCP connect default** (2.1.117) — faster startup when both local and claude.ai MCP servers configured.
- **Plugin install fills missing dependencies** (2.1.117) — `plugin install` on already-installed plugin now installs missing dependencies instead of stopping.
- **Managed-settings marketplace enforcement** (2.1.117) — `blockedMarketplaces` and `strictKnownMarketplaces` enforced on plugin install, update, refresh, and autoupdate. Pair with MCP RCE supply-chain audit.
- **`/resume` 67% faster on 40MB+ sessions** (2.1.116) — handles many dead-fork entries efficiently.
- **MCP startup optimization** (2.1.116) — `resources/templates/list` deferred to first `@`-mention; faster startup with multiple stdio servers.
- **Thinking spinner inline progress** (2.1.116) — replaces separate hint row with inline "still thinking" → "almost done thinking".
- **`/doctor` opens mid-response** (2.1.116) — no longer waits for current turn.
- **Vim visual mode** (2.1.118) — `v` enters character-wise visual mode, `V` enters visual-line mode, with selection, operators, and visual feedback.
- **`/usage` merge** (2.1.118) — `/cost` and `/stats` combined into a single `/usage` command.
- **Custom named themes via `/theme`** (2.1.118) — create and switch between user-defined themes.
- **Hooks can invoke MCP tools directly** (2.1.118) — no shell-out intermediary needed. Cleaner path for Claudious preflight/heartbeat hooks.
- **`DISABLE_UPDATES` env var** (2.1.118) — opt out of background update checks.
- **WSL managed settings inheritance** (2.1.118) — WSL-on-Windows now inherits Windows-side managed settings.
- **Stdio MCP non-JSON stdout no longer disconnects** (2.1.118) — servers that print stray non-JSON lines to stdout are no longer dropped.
- **Headless/SDK session auto-title requests fixed** (2.1.118) — directly relevant to Claudious scheduled routines.
- **Piped-output memory bug fixed** (2.1.118) — excessive memory allocation on piped output resolved.
- **`/powerup`** (2.1.90, 2026-04-01) — first-party in-terminal interactive learning system with animated demonstrations of features. Available all tiers.
- **`/buddy`** (2.1.89, 2026-04-01) — terminal Tamagotchi (18 species, 5 rarity tiers, deterministic per-user). Pro+ subscription. Easter-egg / morale feature.
- **Minor fixes** — `/skills` menu scrolling; Remote Control session bugs; Homebrew install update-prompt loop; ctrl+e in multiline prompts; fullscreen scrolling; Write tool diff compute speed on large files; permission dialog crash with agent teams teammate (2.1.114).

## Features Shipped 2.1.105 → 2.1.113 (Logan-relevant)

- **PreCompact hooks** — run before auto-compact to preserve or reshape context.
- **Plugin monitors** — background processes surface events via the Monitor tool.
- **Skill description cap raised 250 → 1,536 chars** (v2.1.105). Re-expand all 15+ custom skill descriptions for better trigger accuracy — still pending Logan action (see `open-decisions.md`).
- **`/ultraplan`** — cloud multi-agent planning on Opus 4.6, 3 parallel exploration agents + 1 critique agent.
- **`/less-permission-prompts`** — scans transcripts for common read-only tool calls and writes an allowlist.
- **`/ultrareview`** — multi-agent adversarial review pass; shipped with Opus 4.7 on April 16, 2026. 3 free reviews offered at launch on Pro/Max plans.
- **Auto mode for Max** — risk-classifier-gated permissions (safe → execute, risky → prompt).
- **`xhigh` effort level** — superset of prior `high`. Recommended for coding/agentic work on Opus 4.7 (hardest reasoning tasks, multi-file architecture, adversarial review).
- **Windows PowerShell tool** — native PowerShell execution without going through bash.
- **Claude Code desktop redesign** — new UI; keybindings changed (see below).
- **Routines research preview** — cloud scheduled tasks (claude.ai/code/routines).
- **Bash permission bypass patched** (v2.1.98) — backslash-escaped flags could bypass safety checks; update is mandatory if running older versions.
- **Skill `disable-model-invocation: true` fix** (v2.1.110) — now correctly allows manual `/<skill>` invocation while blocking auto-trigger.
- **MCP 500K tool-result cap** — per-tool result limit raised to 500,000 characters via `_meta["anthropic/maxResultSizeChars"]`. Relevant for Logan's 5+ MCP setup when large payloads previously truncated.
- **`disableSkillShellExecution` setting** (Week 14) — blocks inline shell execution inside skills and slash commands; security hardening when running third-party skills.
- **Edit tool works on cat/sed-viewed files** (Week 14) — Edit no longer requires a dedicated Read when the file content was shown via `cat` or `sed`.
- **Push notification tool** — Claude can send mobile push notifications when Remote Control and "Push when Claude decides" are enabled in config. Candidate for long-running Routine/Ultraplan completion alerts.
- **`/doctor` MCP multi-scope warning** — warns when an MCP server is defined in multiple config scopes with different endpoints.
- **`/team-onboarding`** — generates a personalized ramp-up guide for a new teammate from local usage patterns, commands, and MCP usage.
- **`/autofix-pr`** — terminal-side PR auto-fix against a GitHub PR.
- **Computer Use in CLI (research preview)** — Claude opens native apps, clicks through UI, and verifies changes from the terminal.

## Active Environment Variables (Logan's PowerShell `$PROFILE`)

| Env Var | Value | Purpose |
|---|---|---|
| `CLAUDE_CODE_SUBAGENT_MODEL` | `claude-sonnet-4-6` | 50–70% cost savings on delegated work |
| `CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING` | `1` | Streaming tool output granularity |
| `MCP_SERVER_CONNECTION_BATCH_SIZE` | `6` | Parallel MCP server connection batch |
| `MCP_CONNECTION_NONBLOCKING` | `1` | Don't block session start on slow MCP |
| `ENABLE_PROMPT_CACHING_1H` | `1` | 1-hour prompt cache TTL (vs default 5m) |

Revisit `ENABLE_PROMPT_CACHING_1H` if burn rate increases — 1h cache writes cost 100% over base input tokens (vs 25% for 5m). Appropriate for Logan's typical long-form sessions.

## Keybinding Changes to Remember

- **Ctrl+O** — now only toggles verbose transcript. Focus moved to `/focus`.
- **Ctrl+U** — clears the entire input buffer. **Ctrl+Y** restores it.

## Routines (Cloud Scheduled Tasks)

- **URL:** claude.ai/code/routines (or `/schedule` in CLI).
- **Triggers:** Scheduled (cron, min 1h interval), API (HTTPS + bearer), GitHub webhook.
- **Cap on Max:** 15 runs / day, shared with interactive token budget.
- **Branch policy:** auto-pushes to `claude/*` branches by default. GitHub connector required.
- **GitHub webhook variant** requires separate Claude GitHub App install — `/web-setup` does NOT install it.

## Planning Workflows

- **Complex (3+ files, architectural):** `/ultraplan <task>` — offloads to cloud Opus 4.6 with multi-agent exploration.
- **Simple:** local plan mode (default).
- **Spec-first:** write `specs/<feature>.md` with Scope / Constraints / Acceptance Criteria / Do-Not-Do. Review plan against spec before exiting plan mode. (See `prompting-rules.md` → "Spec-First Plan Mode".)

## Auto Mode

Classifier per tool call. Safe reads + non-destructive edits auto-execute; destructive actions (rm, delete, drop table) prompt. Max plan includes Auto mode.

## Git Integration

- `core.hooksPath` must be set per repo on PC — verify each session with `git config core.hooksPath`. Empty = re-run `git config core.hooksPath .claude/hooks`.
- `auto-merge-claude.yml` GitHub Action auto-merges `claude/*` branches on successful CI.
- Post-commit hook dispatcher pattern: `post-commit` calls every `post-commit-*.sh` in hooks dir. Used for `post-commit-docs.sh` (knowledge sync) and `post-commit-roadmap.sh` (RM-XXX closure).

## Known Platform Hazards (Windows-specific)

- **Never store repos in OneDrive** — `.git` index corruption + sticky `index.lock`.
- **GitHub Desktop holds repo locks** — close it before CLI git on Claudious.
- **Bash doesn't read `git config --global`** reliably — use per-repo `git config user.email`.
- **CRLF conversion breaks bash hooks** — `git config core.autocrlf false` on any repo with `.sh` hooks.

## Subscription Surface

Interactive sessions + Routines share the Max subscription token budget. Don't schedule heavy routines alongside heavy interactive work; stagger across peak/off-peak windows.

## Opus 4.7 API Behavior (Claude Code config hazards)

- `temperature`, `top_p`, and `top_k` return HTTP 400 on Opus 4.7 — **do not set these parameters in Claude Code config, SDK calls, or CI scripts**. Remove any carry-over settings from Opus 4.6 configs.
- `thinking.budget_tokens` removed — use `/effort high` or `/effort xhigh` to control reasoning depth.
- Thinking content stripped by default — set `display:"summarized"` in the thinking parameter to surface reasoning traces.
- New tokenizer inflates 1.0×–1.35× vs Opus 4.6 on the same text — account for this when budgeting long contexts.
