# Toolchain — Active Stack

**Last updated:** 2026-04-23
**Scope:** Tools, skills, plugins, and MCP servers Logan actively uses. If something is listed here, it's connected and in rotation.

---

## MCP Servers Connected (12)

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

**Hardening note:** `CLAUDE_CODE_MCP_ALLOWLIST_ENV` (in proposals) would restrict env inheritance to MCP servers — useful security hardening given 12 active servers. Not yet deployed.

**OAuth 2.1 note (April 2026):** MCP spec now incorporates OAuth 2.1 with incremental scope consent. All 12 current MCP integrations are hosted/managed — no Logan-side migration required. Revisit if self-hosted MCP added.

## Custom Claude.ai Skills (8+)

Skills trigger on name + description only — semantic match. 14-skill surface total across global + project; cap ~34–36 before descriptions truncate.

| Skill | Role |
|---|---|
| `logan-os` | Core operating principles for Logan |
| `operating-system` | Strategic mental models |
| `financial-modeler` | ASF / Courtside financial modeling |
| `legal-scanner` | Contract / compliance review |
| `negotiation-playbook` | Counterparty profiling, deal structuring, BuyBoard |
| `health-optimizer` | Training, recovery, nutrition advisor |
| `macro-intelligence` | Investment analysis, portfolio allocation |
| `harvest` | Session knowledge extraction into learnings.md |

## Anthropic Ecosystem Tools (Cowork Stack)

Single highest-ROI category for the Max subscription — the moat is shared-context across apps eliminating copy-paste version drift.

| Tool | Usage note |
|---|---|
| **Cowork** | Cross-app shared context spanning Excel + PowerPoint + Gmail + Drive. Route all multi-app knowledge-work output here. |
| **Claude for Excel** | Paid Mac/Windows add-in, live since March 11, 2026. Spreadsheet creation, formula generation, data analysis inline. |
| **Claude for PowerPoint** | Paid. Deck generation with Cowork context — preserves source chain from research to slide. |
| **Claude for Chrome** | Beta, paid. Browser agent — see `antipatterns.md` → Browser Agent Permission Hygiene before granting account access. |
| **Claude Design** | Launched April 17, 2026. Design generation and iteration (research preview → GA). |
| **Claude Code v2.1.113+** | CLI/desktop coding agent with `/ultrareview` multi-agent adversarial review (shipped with Opus 4.7, 3 free reviews at launch). See `canonical/claude-code-state.md`. |

## Claude Code Plugins

- **typescript-lsp** — TS language server for ASF Graphics / Courtside Pro.
- **pyright-lsp** — Python language server for FastAPI backend.
- **security-guidance** — prompts-time security review.
- **Context7** — local library doc fetch (matches Claude.ai MCP).
- **Codex** — adversarial review via GPT-5.4 (`/codex:review`). Free ChatGPT account. Different model = different bug classes caught. Zero Claude token cost.

## Research Stack

- **Claude Deep Research** — default for synthesis, architecture decisions.
- **Grok Deep Research (SuperGrok)** — X / Twitter signal, community tips.
- **Perplexity Max** — cross-source research with citations.
- **ChatGPT Pro Deep Research** — alternate synthesis, second-model sanity check.

## Git Automation

- **`.github/workflows/auto-merge-claude.yml`** — auto-merges `claude/*` branches on successful CI. Covers cloud Routine output.
- **Post-commit hook dispatcher** — `post-commit` runs every executable `post-commit-*.sh` in `.claude/hooks/`. Active hooks:
  - `post-commit-docs.sh` — knowledge file sync.
  - `post-commit-roadmap.sh` — `roadmap: close RM-XXX` directive handler.

## Scheduled Tasks (Claudious Routines)

Runs on Anthropic cloud or locally. Current slate:
- `intake.md` — daily novelty check, scout sweep, drift check, config analysis.
- `process.md` — daily triage → deploy → verify.
- `curate.md` — daily digest, Sunday retrospective + graduation.
- `scout-additions.md` — named watchlist (KAIROS, Chyros, Opus 4.7 updates, AutoDream).

See `canonical/claude-code-state.md` for routine quota (15/day Max, shared with interactive subscription).

## Research & Mastery Files

- `mastery-lab/claude-mastery-playbook-v2.md` — 33+ techniques, CC-001 → CC-042.
- `mastery-lab/opus-47-migration-checklist.md` — 4.6 → 4.7 gate tests.
- `mastery-lab/logan-current-setup-v4.md` — machine-level setup reference.
- `mastery-lab/master-intelligence-file-2026-04-11.md` — long-running intelligence summary.
- `mastery-lab/task-routing-table.md` — which tool for which task type.

## Planned / Under Evaluation

See `canonical/open-decisions.md` for active proposals. Notable candidates:
- **`context-mode` MCP plugin** — 50–90% token reduction on MCP-heavy sessions. Pending test.
- **Agent Skills Spec (Codex CLI + ChatGPT adoption)** — cross-platform skill portability.
- **Background monitor plugin manifest** (v2.1.105 feature).

## Competitors (evaluated, not in use)

**Last updated:** 2026-04-19
**Purpose:** Tools Logan has evaluated against Claude Code. Referenced by Grok scan to filter "already evaluated" from "new entrants".

- Cursor
- Windsurf
- Codex CLI (OpenAI)
- Gemini CLI (Google)
- Cline
- Aider

**Update discipline:** When a new competitor is evaluated or a listed one shuts down, same-commit update here.
