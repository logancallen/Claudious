# Claude Model Ecosystem — Current State

**Last updated:** 2026-04-25
**Status:** Opus 4.7 is the current flagship (launched April 16, 2026). Opus 4.6 retains specific use cases (cloud Ultraplan).

**Key benchmarks (Opus 4.7 at launch):** SWE-Bench Verified 87.6%, SWE-Bench Pro 64.3%, CursorBench 70% (+12 pts from 4.6). Effective recall on 1M context ~600–700K tokens; plan accordingly for long-context work.

---

## Current Models

| Model | Model ID | Context | Input / Output ($/MTok) | Role |
|---|---|---|---|---|
| **Opus 4.7** | `claude-opus-4-7` | 1M tokens | $5 / $25 | Flagship. Default for Claude Code and Claude.ai. |
| Sonnet 4.6 | `claude-sonnet-4-6` | 1M tokens | $3 / $15 | Subagent workhorse. `CLAUDE_CODE_SUBAGENT_MODEL`. |
| Haiku 4.5 | `claude-haiku-4-5-20251001` | 200K tokens | $1 / $5 | Fast, cheap routine work. |
| Haiku 4 | `claude-haiku-4` | 200K tokens | lower | Smallest; legacy/cost-optimized paths. |

Pricing on Opus 4.7 is unchanged from 4.6. Context windows on Opus/Sonnet 4.6 and 4.7 are both 1M.

## Logan's Plan

- **Claude Max ($200/mo)** — 1M context for Opus 4.7 + Sonnet 4.6 in Claude Code and Claude.ai.
- **Routines quota:** 15 cloud routine runs / day (shared with interactive subscription token budget).
- **Cowork:** context dropped silently from 1M → 200K after Claude Desktop v1.1.7714 (confirmed Apr 17 intake). Issue filed, rollback in progress.
- **Peak-hour throttling:** weekdays 8am–2pm ET / 5am–11am PT burn session limits faster. Schedule long cloud runs off-peak.

## Opus 4.7 Breaking Changes from 4.6

Treat these as **literal 400-error hazards**, not warnings:

- **Sampling params are rejected** — `temperature`, `top_p`, `top_k` now return a 400 error on Opus 4.7. Remove them from every prompt, SDK call, and CI config.
- **`thinking.budget_tokens` removed** — thinking is adaptive only, off by default. To request extended reasoning, use `/effort high` or `/effort xhigh` in Claude Code or the equivalent API control.
- **Thinking content stripped by default** — set `display:"summarized"` if you need visible thinking summaries.
- **Tokenizer changes** — input tokens inflate 1.0x–1.35x vs 4.6 on the same text. Budget accordingly; measure before relying on historical token counts.
- **Literal instruction interpretation** — 4.7 stopped silently repairing ambiguous prompts. If a prompt was kind-of-working on 4.6 via inferred intent, 4.7 will execute the literal text and the result may regress.

## Opus 4.7 New Capabilities

- **`xhigh` effort level** — above `high`. Use for ULTRAPLAN passes, adversarial review, hard proofs, multi-file architecture reasoning.
- **Task Budgets beta** — `task-budgets-2026-03-13` beta header, minimum 20k. Preferred over raw `max_tokens` for production agentic loops — caps spend per task rather than per response.
- **2576px vision resolution** — 3x the prior resolution cap. Better for screenshots, floor plans, design diffs.
- **File-system memory for multi-session work** — persistent memory across sessions (separate from `MEMORY.md` mechanism).

## Deprecation Schedule

- **April 19, 2026** — `claude-3-haiku-20240307` retired. Any pinned caller returns an error — switch to Haiku 4.5.
- **April 30, 2026** — 1M-token context window **beta** on Sonnet 4.5 and Sonnet 4 retires. After this date, those models drop back to their base context window. Audit any pinned Sonnet 4.5/4 callers relying on 1M context.
- **June 15, 2026** — `claude-sonnet-4-20250514` and `claude-opus-4-20250514` retire. Migrate any pinned versions before then.

## Managed Agents (Public Beta)

Claude Managed Agents is in public beta behind the `managed-agents-2026-04-01` beta header. Anthropic-hosted agent runtime — alternative to self-hosted Routines and SDK loops. Evaluate before committing to a hosting model.

**Memory** for Managed Agents added to public beta on 2026-04-23 under the same `managed-agents-2026-04-01` header — cross-session state persistence inside the managed agent runtime.

## Advisor Tool (Public Beta)

Launched 2026-04-09. Beta header `advisor-tool-2026-03-01`. Pair a faster executor model with a higher-intelligence advisor model that provides strategic guidance mid-generation, so long-horizon agentic workloads get close to advisor-solo quality while the bulk of token generation runs at executor-model rates.

## Rate Limits API

Released 2026-04-24. Admins can programmatically query rate limits configured for their organization and workspaces. Useful if Claudious starts gating routines on burn-rate forecasts.

## Claude.ai Features Logan Uses

Projects, Artifacts, Memory (MEMORY.md auto-load), Web Search, Deep Research, Code Execution, Skills (14 custom), MCP Integrations (12 servers — see `toolchain.md`), Routines (15/day Max cap), Claude Design (research preview), Claude for Word.

## Migration Status

Opus 4.7 is the default on this machine as of 2026-04-19. Pre-migration checklist (`mastery-lab/opus-47-migration-checklist.md`) passed 3 of 4 gates; remaining item is Agent Teams multi-agent regression test — open until next coordinator-worker run.

## Frontier Models Not Available to Logan

- **Claude Mythos Preview** — scored 93.9% SWE-Bench Verified in Anthropic's April 16 launch; restricted to Project Glasswing cybersecurity partners; not on Claude Max. Monitor for access expansion.
