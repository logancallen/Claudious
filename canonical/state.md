# Claudious — State

**Last updated:** 2026-04-26

Current state of the Claude ecosystem Logan operates in. Three sections:
1. Claude Models & API
2. Claude Code
3. Toolchain — MCPs, Skills, Plugins

---

## 1. Claude Models & API

**Status:** Opus 4.7 is the current flagship (launched April 16, 2026). Opus 4.6 retains specific use cases (cloud Ultraplan).

**Key benchmarks (Opus 4.7 at launch):** SWE-Bench Verified 87.6%, SWE-Bench Pro 64.3%, CursorBench 70% (+12 pts from 4.6). Effective recall on 1M context ~600–700K tokens; plan accordingly for long-context work.

### Current Models

| Model | Model ID | Context | Input / Output ($/MTok) | Role |
|---|---|---|---|---|
| **Opus 4.7** | `claude-opus-4-7` | 1M tokens | $5 / $25 | Flagship. Default for Claude Code and Claude.ai. |
| Sonnet 4.6 | `claude-sonnet-4-6` | 1M tokens | $3 / $15 | Subagent workhorse. `CLAUDE_CODE_SUBAGENT_MODEL`. |
| Haiku 4.5 | `claude-haiku-4-5-20251001` | 200K tokens | $1 / $5 | Fast, cheap routine work. |
| Haiku 4 | `claude-haiku-4` | 200K tokens | lower | Smallest; legacy/cost-optimized paths. |

Pricing on Opus 4.7 is unchanged from 4.6. Context windows on Opus/Sonnet 4.6 and 4.7 are both 1M.

### Logan's Plan

- **Claude Max ($200/mo)** — 1M context for Opus 4.7 + Sonnet 4.6 in Claude Code and Claude.ai.
- **Routines quota:** 15 cloud routine runs / day (shared with interactive subscription token budget).
- **Cowork:** context dropped silently from 1M → 200K after Claude Desktop v1.1.7714 (confirmed Apr 17 intake). Issue filed, rollback in progress.
- **Peak-hour throttling:** weekdays 8am–2pm ET / 5am–11am PT burn session limits faster. Schedule long cloud runs off-peak.

### Opus 4.7 Breaking Changes from 4.6

Treat these as **literal 400-error hazards**, not warnings:

- **Sampling params are rejected** — `temperature`, `top_p`, `top_k` now return a 400 error on Opus 4.7. Remove them from every prompt, SDK call, and CI config.
- **`thinking.budget_tokens` removed** — thinking is adaptive only, off by default. To request extended reasoning, use `/effort high` or `/effort xhigh` in Claude Code or the equivalent API control.
- **Thinking content stripped by default** — set `display:"summarized"` if you need visible thinking summaries.
- **Tokenizer changes** — input tokens inflate 1.0x–1.35x vs 4.6 on the same text. Budget accordingly; measure before relying on historical token counts.
- **Literal instruction interpretation** — 4.7 stopped silently repairing ambiguous prompts. If a prompt was kind-of-working on 4.6 via inferred intent, 4.7 will execute the literal text and the result may regress.

### Opus 4.7 New Capabilities

- **`xhigh` effort level** — above `high`. Use for ULTRAPLAN passes, adversarial review, hard proofs, multi-file architecture reasoning.
- **Task Budgets beta** — `task-budgets-2026-03-13` beta header, minimum 20k. Preferred over raw `max_tokens` for production agentic loops — caps spend per task rather than per response.
- **2576px vision resolution** — 3x the prior resolution cap. Better for screenshots, floor plans, design diffs.
- **File-system memory for multi-session work** — persistent memory across sessions (separate from `MEMORY.md` mechanism).

### Deprecation Schedule

- **April 19, 2026** — `claude-3-haiku-20240307` retired. Any pinned caller returns an error — switch to Haiku 4.5.
- **April 30, 2026** — 1M-token context window **beta** on Sonnet 4.5 and Sonnet 4 retires. After this date, those models drop back to their base context window. Audit any pinned Sonnet 4.5/4 callers relying on 1M context.
- **June 15, 2026** — `claude-sonnet-4-20250514` and `claude-opus-4-20250514` retire. Migrate any pinned versions before then.

### Managed Agents (Public Beta)

Claude Managed Agents is in public beta behind the `managed-agents-2026-04-01` beta header. Anthropic-hosted agent runtime — alternative to self-hosted Routines and SDK loops. Evaluate before committing to a hosting model.

### Claude.ai Features Logan Uses

Projects, Artifacts, Memory (MEMORY.md auto-load), Web Search, Deep Research, Code Execution, Skills, MCP Integrations, Routines (15/day Max cap), Claude Design (research preview), Claude for Word.

### Frontier Models Not Available to Logan

- **Claude Mythos Preview** — scored 93.9% SWE-Bench Verified in Anthropic's April 16 launch; restricted to Project Glasswing cybersecurity partners; not on Claude Max. Monitor for access expansion.

---

## 2. Claude Code

**Version:** 2.1.118 (released 2026-04-23)
**Default model:** Opus 4.7

### Features Shipped 2.1.114 → 2.1.118 (Logan-relevant)

- **Vim visual mode** — `v` enters character-wise visual mode, `V` enters visual-line mode, with selection, operators, and visual feedback.
- **`/usage` merge** — `/cost` and `/stats` combined into a single `/usage` command.
- **Custom named themes via `/theme`** — create and switch between user-defined themes.
- **Hooks can invoke MCP tools directly** — no shell-out intermediary needed.
- **`DISABLE_UPDATES` env var** — opt out of background update checks.
- **WSL managed settings inheritance** — WSL-on-Windows now inherits Windows-side managed settings.
- **Stdio MCP non-JSON stdout no longer disconnects** — servers that print stray non-JSON lines to stdout are no longer dropped.
- **Headless/SDK session auto-title requests fixed.**
- **Piped-output memory bug fixed** — excessive memory allocation on piped output resolved.
- **Minor fixes** — `/skills` menu scrolling; Remote Control session bugs; Homebrew install update-prompt loop; ctrl+e in multiline prompts; fullscreen scrolling; Write tool diff compute speed on large files.

### Features Shipped 2.1.105 → 2.1.113 (Logan-relevant)

- **PreCompact hooks** — run before auto-compact to preserve or reshape context.
- **Plugin monitors** — background processes surface events via the Monitor tool.
- **Skill description cap raised 250 → 1,536 chars** (v2.1.105). Re-expand custom skill descriptions for better trigger accuracy.
- **`/ultraplan`** — cloud multi-agent planning on Opus 4.6, 3 parallel exploration agents + 1 critique agent.
- **`/less-permission-prompts`** — scans transcripts for common read-only tool calls and writes an allowlist.
- **`/ultrareview`** — multi-agent adversarial review pass; shipped with Opus 4.7 on April 16, 2026. 3 free reviews offered at launch on Pro/Max plans.
- **Auto mode for Max** — risk-classifier-gated permissions (safe → execute, risky → prompt).
- **`xhigh` effort level** — superset of prior `high`. Recommended for coding/agentic work on Opus 4.7.
- **Windows PowerShell tool** — native PowerShell execution without going through bash.
- **Claude Code desktop redesign** — new UI; keybindings changed (see below).
- **Routines research preview** — cloud scheduled tasks (claude.ai/code/routines).
- **Bash permission bypass patched** (v2.1.98) — backslash-escaped flags could bypass safety checks; update is mandatory if running older versions.
- **Skill `disable-model-invocation: true` fix** (v2.1.110) — now correctly allows manual `/<skill>` invocation while blocking auto-trigger.
- **MCP 500K tool-result cap** — per-tool result limit raised to 500,000 characters via `_meta["anthropic/maxResultSizeChars"]`.
- **`disableSkillShellExecution` setting** (Week 14) — blocks inline shell execution inside skills and slash commands.
- **Edit tool works on cat/sed-viewed files** (Week 14) — Edit no longer requires a dedicated Read when the file content was shown via `cat` or `sed`.
- **Push notification tool** — Claude can send mobile push notifications when Remote Control and "Push when Claude decides" are enabled in config.
- **`/doctor` MCP multi-scope warning** — warns when an MCP server is defined in multiple config scopes with different endpoints.
- **`/team-onboarding`** — generates a personalized ramp-up guide for a new teammate from local usage patterns, commands, and MCP usage.
- **`/autofix-pr`** — terminal-side PR auto-fix against a GitHub PR.
- **Computer Use in CLI (research preview)** — Claude opens native apps, clicks through UI, and verifies changes from the terminal.

### Active Environment Variables (Logan's PowerShell `$PROFILE`)

| Env Var | Value | Purpose |
|---|---|---|
| `CLAUDE_CODE_SUBAGENT_MODEL` | `claude-sonnet-4-6` | 50–70% cost savings on delegated work |
| `CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING` | `1` | Streaming tool output granularity |
| `MCP_SERVER_CONNECTION_BATCH_SIZE` | `6` | Parallel MCP server connection batch |
| `MCP_CONNECTION_NONBLOCKING` | `1` | Don't block session start on slow MCP |
| `ENABLE_PROMPT_CACHING_1H` | `1` | 1-hour prompt cache TTL (vs default 5m) |

Revisit `ENABLE_PROMPT_CACHING_1H` if burn rate increases — 1h cache writes cost 100% over base input tokens (vs 25% for 5m). Appropriate for long-form sessions.

### Keybinding Changes to Remember

- **Ctrl+O** — now only toggles verbose transcript. Focus moved to `/focus`.
- **Ctrl+U** — clears the entire input buffer. **Ctrl+Y** restores it.

### Routines (Cloud Scheduled Tasks)

- **URL:** claude.ai/code/routines (or `/schedule` in CLI).
- **Triggers:** Scheduled (cron, min 1h interval), API (HTTPS + bearer), GitHub webhook.
- **Cap on Max:** 15 runs / day, shared with interactive token budget.
- **Branch policy:** auto-pushes to `claude/*` branches by default. GitHub connector required.
- **GitHub webhook variant** requires separate Claude GitHub App install — `/web-setup` does NOT install it.

### Planning Workflows

- **Complex (3+ files, architectural):** `/ultraplan <task>` — offloads to cloud Opus 4.6 with multi-agent exploration.
- **Simple:** local plan mode (default).
- **Spec-first:** write `specs/<feature>.md` with Scope / Constraints / Acceptance Criteria / Do-Not-Do. Review plan against spec before exiting plan mode.

### Auto Mode

Classifier per tool call. Safe reads + non-destructive edits auto-execute; destructive actions (rm, delete, drop table) prompt. Max plan includes Auto mode.

### Git Integration

- `core.hooksPath` must be set per repo on PC — verify each session with `git config core.hooksPath`. Empty = re-run `git config core.hooksPath .claude/hooks`.
- Post-commit hook dispatcher pattern: `post-commit` calls every `post-commit-*.sh` in hooks dir.

### Known Platform Hazards (Windows-specific)

- **Never store repos in OneDrive** — `.git` index corruption + sticky `index.lock`.
- **GitHub Desktop holds repo locks** — close it before CLI git on Claudious.
- **Bash doesn't read `git config --global`** reliably — use per-repo `git config user.email`.
- **CRLF conversion breaks bash hooks** — `git config core.autocrlf false` on any repo with `.sh` hooks.

### Subscription Surface

Interactive sessions + Routines share the Max subscription token budget. Don't schedule heavy routines alongside heavy interactive work; stagger across peak/off-peak windows.

### Opus 4.7 API Behavior (Claude Code config hazards)

- `temperature`, `top_p`, and `top_k` return HTTP 400 on Opus 4.7 — **do not set these parameters in Claude Code config, SDK calls, or CI scripts**.
- `thinking.budget_tokens` removed — use `/effort high` or `/effort xhigh` to control reasoning depth.
- Thinking content stripped by default — set `display:"summarized"` to surface reasoning traces.
- New tokenizer inflates 1.0×–1.35× vs Opus 4.6 — account for this when budgeting long contexts.

---

## 3. Toolchain — MCPs, Skills, Plugins

**Scope:** Tools, skills, plugins, and MCP servers Logan actively uses. If something is listed here, it's connected and in rotation.

### MCP Servers Connected (12)

Claude.ai-connected MCP servers. Every one loads its tool definitions into context on every message — audit `/mcp` at session start and disconnect what you don't need for the current task.

| Server | Primary use |
|---|---|
| Google Drive | Document pull, research artifact storage |
| Gmail | Inbox search, draft creation, labels |
| Supabase | ASF Graphics + Courtside Pro DB ops, RLS audit, migration apply |
| Stripe | Payments data on Courtside Pro |
| Netlify | Deploy state, project/deploy/extension services |
| Figma | Design pulls, Code Connect mappings |
| Linear | Issue/project management |
| Canva | Design asset retrieval |
| QuickBooks | ASF Graphics accounting, benchmarking, P&L |
| Context7 | Library doc fetch — React, Next.js, Prisma, Tailwind, Django, SDKs |
| Cloudflare (Developer Platform) | D1, KV, R2, Workers, Hyperdrive |
| Hugging Face | Hub queries, paper search, doc fetch |

**OAuth 2.1 note (April 2026):** MCP spec now incorporates OAuth 2.1 with incremental scope consent. All 12 current MCP integrations are hosted/managed — no Logan-side migration required.

### Custom Claude.ai Skills

Skills trigger on name + description only — semantic match. Cap ~34–36 across global + project before descriptions truncate.

| Skill | Role |
|---|---|
| `logan-os` | Core operating principles for Logan |
| `operating-system` | Strategic mental models |
| `financial-modeler` | ASF / Courtside financial modeling |
| `legal-scanner` | Contract / compliance review |
| `negotiation-playbook` | Counterparty profiling, deal structuring, BuyBoard |
| `health-optimizer` | Training, recovery, nutrition advisor |
| `macro-intelligence` | Investment analysis, portfolio allocation |
| `harvest` | Session knowledge extraction |

### Anthropic Ecosystem Tools (Cowork Stack)

Single highest-ROI category for the Max subscription — the moat is shared-context across apps eliminating copy-paste version drift.

| Tool | Usage note |
|---|---|
| **Cowork** | Cross-app shared context spanning Excel + PowerPoint + Gmail + Drive. |
| **Claude for Excel** | Paid Mac/Windows add-in, live since March 11, 2026. |
| **Claude for PowerPoint** | Paid. Deck generation with Cowork context. |
| **Claude for Chrome** | Beta, paid. Browser agent — see Browser Agent Permission Hygiene in `playbook.md` before granting account access. |
| **Claude Design** | Launched April 17, 2026. |
| **Claude Code v2.1.113+** | CLI/desktop coding agent with `/ultrareview` multi-agent adversarial review. |

### Claude Code Plugins

- **typescript-lsp** — TS language server for ASF Graphics / Courtside Pro.
- **pyright-lsp** — Python language server for FastAPI backend.
- **security-guidance** — prompts-time security review.
- **Context7** — local library doc fetch.
- **Codex** — adversarial review via GPT-5.4 (`/codex:review`). Free ChatGPT account. Different model = different bug classes caught. Zero Claude token cost.

### Research Stack

- **Claude Deep Research** — default for synthesis, architecture decisions.
- **Grok Deep Research (SuperGrok)** — X / Twitter signal, community tips.
- **Perplexity Max** — cross-source research with citations.
- **ChatGPT Pro Deep Research** — alternate synthesis, second-model sanity check.

### Competitors (evaluated, not in use)

Tools Logan has evaluated against Claude Code:
- Cursor
- Windsurf
- Codex CLI (OpenAI)
- Gemini CLI (Google)
- Cline
- Aider
