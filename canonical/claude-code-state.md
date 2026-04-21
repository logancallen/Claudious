# Claude Code — Current State

**Last updated:** 2026-04-21
**Version:** 2.1.116 (latest shipped; 2.1.113 baseline, 2.1.114 bugfix, 2.1.116 perf + safety)
**Default model:** Opus 4.7

---

## Features Shipped 2.1.105 → 2.1.116 (Logan-relevant)

### v2.1.116 additions
- **`/resume` perf on large sessions** — significantly faster on 40MB+ transcripts.
- **MCP startup faster** — deferred `resources/templates/list` at connect time.
- **Thinking-spinner inline progress indicators** — mid-response progress.
- **`/config` search matches option values** — not only keys.
- **`/doctor` accessible mid-response** — can diagnose without interrupting the turn.
- **Plugin auto-update installs missing dependencies** — no manual follow-up after plugin refresh.
- **Dangerous-path safety checks for `rm`/`rmdir`** — protects critical system directories.
- **Bash GitHub API rate-limit hints** — surface-level hint when API limits trigger.
- **Usage tab zero-delay metrics** — immediate visibility instead of polling lag.
- **Agent frontmatter `hooks:` in main-thread mode** — hooks fire on main-thread agents, not only worker agents.

### v2.1.113 (prior baseline, full detail)

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
- **Claude Desktop "Customize" section** — groups skills, plugins, and connectors in one place in Claude Desktop (announced alongside Cowork GA).
- **`sandbox.network.deniedDomains` setting** — domain blocklist for sandboxed network access (v2.1.113).
- **Multiline input logical-line navigation** — `Ctrl+A` / `Ctrl+E` move to logical line boundaries (v2.1.113).
- **Windows `Ctrl+Backspace`** — deletes the previous word (v2.1.113).
- **`/ultrareview` parallelized** — now emits diffstat and animation (v2.1.113).
- **Subagent 10-min timeout surface** — clear timeout message instead of silent hang.
- **`Bash(find:*)` no longer auto-approves `find -exec`** — closes auto-approval gap (v2.1.113).
- **Bash deny-rule wrapper matching** — rules match commands wrapped in `env`/`sudo`/`watch` (v2.1.113).
- **macOS `/private/{etc,var,tmp,home}` dangerous for `rm`** — prompt required before rm against these paths (v2.1.113).

### Anthropic announcement anchor
- **2026-04-14 "Redesigning Claude Code on desktop for parallel agents"** — OFFICIAL dated announcement of the sidebar-based parallel-agent layout already listed above.

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
