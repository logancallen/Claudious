# Handoff — Active Session State

**Updated:** 2026-04-25 PM
**From chat:** Claude Mastery Lab — DISTILL 4-engine DR sweep, AI platform updates Jan–Apr 2026
**Recommended next-chat title:** `2026-04-26 — MASTERY — DR-sweep implementation kickoff`
**Status:** DISTILL synthesis complete. All decisions deferred to next chat per Logan.

---

## Current Focus

Implement findings from completed 4-engine DR sweep (Claude DR, ChatGPT GPT-5.5 Pro DR, Grok DR, Perplexity Model Council). Synthesis identified 27 NEW + 14 UPGRADE + 14 REDUNDANT items across Anthropic, OpenAI, Perplexity, xAI, and cross-cutting tooling.

Three time-sensitive deadlines drive sequencing:
1. **5-DAY HARD DEADLINE — April 30, 2026:** Sonnet 4.5 / Sonnet 4 1M-context beta header becomes a no-op. Any pinned model ID handling >200K context will silently error.
2. **11-DAY DEADLINE — May 5, 2026:** Pro/Max `/ultrareview` 3-free-runs trial closes.
3. **36-DAY DEADLINE — May 31, 2026:** ChatGPT Pro 10× Codex usage promo closes.

---

## Decisions Deferred to Next Chat

Logan explicitly chose to defer all decisions to the next chat with fresh context. Next chat must decide:

1. **Routing table approval or override** — Phase 7 of the DISTILL output proposed 9 canonical updates, 11 new proposals, 2 graduations to queue, 3 alerts.md HIGH entries, 1 memory_user_edits, 1 calendar reminder. Full table is in chat transcript. Next chat reviews and approves or overrides per item.
2. **Chat structure** — single implementation chat vs three-chat split (MASTERY canonical/userPrefs → CLAUDIOUS proposals → MASTERY architectural decisions). Recommend three-chat split; deferred.
3. **Architectural decisions** — Managed Agents vs Claudious; Perplexity Agent API vs current FastAPI/multi-vendor SDK stack; Plugin Marketplace audit scope. All require Logan judgment.
4. **Sequencing within Chat 1** — proposed order is alerts.md → Sonnet audit → CC v2.1.119 update → canonical batch → proposals batch. Re-evaluate after fresh-context review.

---

## Top 5 Items by Implementation Priority

1. **DR-CC-101: Update Claude Code v2.1.113 → v2.1.119** on Mac Studio + Windows PC. Restores 3% coding quality lost to Apr 16 verbosity-prompt regression (fixed v2.1.116). Anthropic reset usage limits Apr 23. Highest ROI/effort ratio in entire sweep. Effort: TRIVIAL (`claude update`). Confidence: 99%.

2. **DR-CC-113: Audit pinned Sonnet 4.5 / Sonnet 4 model IDs before April 30.** Run `grep -rn "claude-sonnet-4-2025\|claude-sonnet-4-5-2025\|claude-opus-4-2025" .` across active projects. Migrate any hits to `claude-sonnet-4-6` or `claude-opus-4-7`. Effort: LOW (~30 min). Confidence: 99%.

3. **DR-CC-102: Wire `type:"mcp_tool"` hooks** into one highest-frequency MCP flow (likely Supabase migration safety or Netlify deploy verifier). 4-engine OFFICIAL consensus on Anthropic CHANGELOG. v2.1.118 added it. Effort: MEDIUM (~2 hr first migration). Confidence: 95%.

4. **DR-CC-107: Replace `--dangerously-skip-permissions`** with Auto Mode (Max + Opus 4.7 default) in Claudious daily routines. Direct risk-surface reduction. Effort: TRIVIAL. Confidence: 95%.

5. **DR-PPX-101: Add Perplexity-as-MCP-server** to Claude Code. Bidirectional research↔build bridge. Effort: LOW (~20 min). Confidence: 88%.

---

## Stale State Identified (must fix in next chat)

**🔴 Hard contradictions with current reality:**
- `userMemories` says: "Auto Mode (CC-009) is not available on the Max plan — Team/Enterprise/API only" → False as of Apr 16, 2026. Auto Mode is now Max + Opus 4.7 default. Fix via `memory_user_edits`.
- `Mastery Lab project instructions` say: "Claude Code: v2.1.113" → 6 versions stale; current is v2.1.119.
- `Mastery Lab project instructions` say: "Custom Claude.ai skills (8): logan-os, operating-system, ..." → 4 skills (logan-os, operating-system, financial-modeler, legal-scanner) are Claude desktop-app skills only, not visible to Claude Code CLI per superpowers-trial-log.md. CLI surface is 4 skills, not 8.
- `canonical/toolchain.md` "MCP Servers Connected (12)" → URLs likely stale on at least 3 of 12: Linear (OAuth 2.1 / SSE→HTTP migration required), Cloudflare (Code Mode swap available at mcp.cloudflare.com), Stripe (v0.3.x at mcp.stripe.com).
- `mastery-lab/logan-current-setup-v4.md` — alerts.md flagged stale 2026-04-22 on 6 dimensions; v5 not yet shipped.

**🟡 Framing stale, content not yet wrong:**
- `canonical/toolchain.md` "Cowork… research preview" → Cowork GA on Mac + Windows since April 9, 2026.
- `mastery-lab/claude-mastery-playbook-v2.md` CC-007 `/ultraplan` description → "30-min cloud planning via Opus 4.6 on CCR" framing pre-GA; now auto-creates cloud env, supports remote/local execution.
- `canonical/active-findings.md` `ant-cli-launch` MEDIUM "evaluation candidate" → Managed Agents public beta elevates to architectural-decision tier.
- `canonical/prompting-rules.md` missing entries: `/ultrareview`, `/ultraplan`, `/loop`, `/team-onboarding`, `/recap`, `/undo`. None currently documented.
- `archive/proposals/compile-time-feature-flags-radar.md` — KAIROS/BRIDGE_MODE/CHICAGO_MCP have moved closer to or into GA via Remote Control + Dispatch + `--channels` (Claude DR CC-21) and Computer Use (Claude DR CL-002 / CC-105). Watchlist needs update.

**🟡 Reconciliation pending:**
- MCP count inconsistency (5+ / 7 / 12) — open proposal `reconcile-mcp-count-inconsistency.md`. Claude DR adds Cowork-side surface (~30+ connectors) as distinct from Claude Code MCPs, strengthens the surface-split solution.
- Three "routine" features conflated: Claude Code Routines vs `/loop` vs Cowork Scheduled Tasks. Logan's "3 daily cloud routines" are most likely Claude Code Routines specifically — needs explicit confirmation.
- ASF Migrations 026-028 employee-permissions break — alerts.md flagged 2026-04-22; still uncleared 8+ days. Drift report and Pioneer report both flagged it; no asf-graphics-app session held.
- Proposals backlog: 40 items as of 2026-04-22, at least 6 over 8 days old. Mid-month report warned ≥30 = bulge; 45-min graduate-or-archive batch overdue.

---

## Critical Alerts to Land in alerts.md

Recommend dropping these into alerts.md immediately on next chat open, before any other work:

1. 🔴 5-DAY DEADLINE: Sonnet 4.5/4 1M context retires April 30, 2026. Audit pinned model IDs.
2. 🟡 11-DAY DEADLINE: `/ultrareview` Pro/Max 3-free-runs trial closes May 5, 2026.
3. 🟡 36-DAY DEADLINE: ChatGPT Pro 10× Codex promo closes May 31, 2026.
4. 🔴 BREAKING: Linear MCP SSE→HTTP migration required (final SSE removal date TBD by Linear; verify next session).
5. 🟡 SECURITY WATCHLIST: Cowork/Comet prompt-injection vulnerabilities flagged by Zenity Labs, LayerX, Guardio (March 2026). Defensive posture for sensitive accounts (banking, tax, Stripe production keys).

---

## Findings Inventory (full DISTILL output is in chat transcript)

**27 NEW techniques identified. Highlights:**
- Claude Code v2.1.119 release bundle (settings persistence, parallel MCP for subagents, agent permissionMode, multi-platform PR, prUrlTemplate)
- Hooks invoke MCP tools directly (`type:"mcp_tool"`)
- Auto Mode GA (Max + Opus 4.7 default)
- Claude Code Routines (HTTP/GitHub triggers, `experimental-cc-routine-2026-04-01` header)
- Advisor tool (`advisor-tool-2026-03-01` header — executor + advisor pair)
- Managed Agents public beta + `ant` CLI + memory beta (`managed-agents-2026-04-01`)
- Claude Code on the web (`--remote` / `--teleport`)
- Compaction API beta + adaptive thinking GA
- Cowork plugins ecosystem (11 first-party + 13 connectors)
- `/team-onboarding` 30-day session self-audit
- Remote Control + Dispatch + `--channels`
- Anthropic Plugin Marketplaces (101 plugins; 33 Anthropic + 68 partner)
- GPT-5.5 / GPT-5.5 Pro launch (1M API context, $5/$30 and $30/$180)
- ChatGPT Pro $100 tier (additive to $200, 5x Plus usage, 10x Codex promo)
- GPT-5.3-Codex-Spark (Pro-tier-only, 1000+ TPS research preview)
- Codex pay-as-you-go + Codex-only seats
- ChatGPT Projects upgrades (project-only memory)
- Agents SDK native sandbox + Manifest abstraction
- OpenAI Deep Research overhaul on GPT-5.2-base + MCP integration
- Responses API + Conversations API (Assistants sunset Aug 26, 2026)
- Perplexity custom MCP connectors
- Perplexity Computer as orchestration layer (~20 routed models, 400+ apps)
- Perplexity Personal Computer Mac GA (Apr 16, Mac-only)
- Perplexity Agent API + Embeddings API + Sandbox API
- Perplexity Spaces with scheduled tasks + Computer-in-Spaces
- Perplexity Model Council documented in canonical
- Linear Agent + MCP OAuth 2.1 (BREAKING SSE migration)
- Cloudflare Code Mode MCP at mcp.cloudflare.com (~2500 endpoints in ~1k tokens)
- VS Code Copilot 1.110–1.115 Agent Plugins + Hooks + Autopilot
- MCP Apps framework SEP-1865 (interactive UI)
- Stripe MCP v0.3.x at mcp.stripe.com (OAuth remote, 25 tools)
- Hugging Face official remote MCP at huggingface.co/mcp
- Cursor 3.0 Agents Window + /multitask + Design Mode
- claude-code-router proxy (cost lever, COMMUNITY)
- Sonnet 4.5/4 1M context retire Apr 30, 2026 (HARD DEADLINE)
- Cowork/Comet prompt-injection vulnerabilities (3rd-party security)

**14 UPGRADE techniques** apply to existing canonical entries — full Phase 4 detail in chat transcript.

**Disagreement resolution log (Phase 2):** all 11 disagreements resolved or appropriately deferred. Two notable corrections: (a) ChatGPT Pro $100 was *added* alongside existing $200, not a replacement — Logan should confirm which tier in ChatGPT settings; (b) Auto Mode availability — userMemory was wrong, Auto Mode IS on Max + Opus 4.7.

---

## Proposed Routing Table (for next-chat approval)

Next chat reviews Phase 7 in transcript. High-level summary:

- 9 canonical updates: claude-code-state.md (state changes for v2.1.119, Routines, Auto Mode, /ultrareview, /ultraplan, Computer Use, /team-onboarding, third surface), toolchain.md (Cowork GA, Cowork plugins, MCP swaps for Linear/Cloudflare/Stripe/HF, Perplexity Personal Computer Mac, Perplexity-as-MCP, Perplexity Computer, Perplexity Model Council, Plugin marketplaces), prompting-rules.md (Diagnostic Commands section), claude-state.md (deprecation schedule update for Sonnet 4.5/4)
- 11 new proposals: hooks-mcp-tool-direct-trial, advisor-tool-cost-quality-trial, managed-agents-vs-claudious-decision, claude-code-setup-plugin-evaluation, openai-responses-migration-audit, exa-mcp-evaluation, portable-vault-mcp-decision (SKIP recommendation), cloudflare-enterprise-mcp-watchlist, linear-mcp-oauth-2-1-migration, perplexity-api-as-fastapi-backend-decision, plugin-marketplace-audit
- 2 graduations to queue: skill-description-1536-chars-audit (third citation reached); session-checkpointing-before-autonomous-runs (also third citation)
- 3 alerts.md HIGH: Sonnet retirement, /ultrareview trial close, Linear SSE migration
- 1 memory_user_edits: fix Auto Mode availability statement
- 1 calendar reminder: May 24, 2026 — re-evaluate ChatGPT Pro $100 vs $200

---

## Files Recently Changed This Session

None — DISTILL session was synthesis only. No file writes.

---

## Frustration Signals (do not repeat)

- Claude Deep Research froze twice during the parallel sweep. For implementation chats, do NOT depend on long-running multi-engine reasoning chains. Sequence work in batches small enough to survive a frozen response without losing state.
- Logan pushed back on long DISTILL explanations. Brief findings + system-staleness sweep was the format he wanted. Next chat: lead with action items, not synthesis. Implementation work, not re-explanation.
- "Just briefly tell me what the findings are" — keep responses scoped to what's being decided right now, not full justification.

---

## User Preferences Changes Pending

None pending User Preferences edits this session. The only preference-adjacent change is the userMemory fix (Auto Mode availability), routed via memory_user_edits not userPreferences. No reproduction of the full preferences document needed this handoff.

---

## Unresolved Questions

1. Routing table approval — pending fresh-context review
2. Chat structure — single chat vs three-chat split — deferred
3. Architectural decision proposals (Managed Agents, Perplexity Agent API, Plugin Marketplace audit) — write proposals first or after time-sensitive items ship?
4. Linear SSE final removal date — Linear hasn't announced; verify before scheduling migration

---

## First Action for Next Chat

1. Read this handoff (auto via SessionStart hook).
2. Drop the 5 critical alerts into canonical/alerts.md before anything else (5-day Sonnet deadline is the controlling constraint).
3. Decide: single chat or three-chat split. Recommend three-chat split.
4. If single chat: sequence is alerts → Sonnet audit → CC update → canonical batch → proposals batch. If three-chat split: this chat handles alerts + Sonnet audit + CC update + canonical batch only; spawn fresh chat for proposals batch and another for architectural decisions.
5. Approve or override Phase 7 routing table per item.
