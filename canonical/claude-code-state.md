# Claude Code — Current State

**Last updated:** 2026-04-22
**Version:** 2.1.116 (released 2026-04-20)
**Default model:** Opus 4.7

---

## Features Shipped 2.1.105 → 2.1.116 (Logan-relevant)

- **PreCompact hooks** — run before auto-compact to preserve or reshape context.
- **Plugin monitors** — background processes surface events via the Monitor tool.
- **Skill description cap raised 250 → 1,536 chars** (v2.1.105). Re-expand all 15+ custom skill descriptions for better trigger accuracy — still pending Logan action (see `open-decisions.md`).
- **`/ultraplan`** — cloud multi-agent planning on Opus 4.6, 3 parallel exploration agents + 1 critique agent.
- **`/less-permission-prompts`** — scans transcripts for common read-only tool calls and writes an allowlist.
- **`/ultrareview`** — adversarial review skill.
- **Auto mode for Max** — risk-classifier-gated permissions (safe → execute, risky → prompt).
- **`xhigh` effort level** — above `high`. Paired with Opus 4.7 for hardest reasoning tasks.
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
- **`/powerup`** (v2.1.89/90, 2026-04-01) — first-party in-terminal interactive learning system; animated feature demos inline instead of doc link-outs.
- **`/tui` slash command + `tui` setting** — `/tui fullscreen` switches to flicker-free rendering mid-conversation.
- **`defer` value for `permissionDecision`** (PreToolUse hooks) — headless `-p` sessions pause at a tool call, exit with a `deferred_tool_use` payload for an SDK/custom UI to surface, then resume via `--resume`. Enables inter-agent dependencies and staged automated workflows.
- **`/cost` per-model breakdown** — session spend split by model; useful when mixing Opus 4.7 main + Sonnet 4.6 subagents.
- **Plugin dep auto-install** — `/reload-plugins` and background plugin auto-update now auto-install missing plugin dependencies from marketplaces.
- **Faster MCP stdio startup** (2.1.116) — parallelized connection to multiple stdio MCP servers; relevant to Logan's 12-MCP setup.
- **`/doctor` during-response** (2.1.116) — open `/doctor` without waiting for the current turn to finish.
- **2.1.116 security fix** — closes a sandbox `rm` bypass. Upgrading from 2.1.113 or earlier is recommended.
- **`/resume` 67% faster** (2.1.116) — large-session resume (40MB+) and dead-fork handling optimized.

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
