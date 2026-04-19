# PROPOSAL — Compile-Time Feature Flag Radar (Anthropic Roadmap Intelligence)

**Finding-ID:** 2026-04-16-compile-time-feature-flags-inventory
**Disposition:** INTELLIGENCE — not directly actionable; adopt as watchlist
**Category:** PATTERN
**Source:** https://theplanettools.ai/blog/claude-code-330-env-variables-32-feature-flags

## Rationale
32 compile-time feature flags embedded in the Claude Code binary. Most are dead-code-eliminated today but indicate Anthropic's roadmap. Worth converting into a watchlist so Logan catches adoption windows early.

**Key flags to watch:**
- **KAIROS** — persistent always-on assistant w/ push notifications (150+ source refs; highest internal investment)
- **COORDINATOR_MODE** — multi-agent orchestrator (formalizes the operator/subagent pattern Logan already uses)
- **ULTRAPLAN** — 30-min cloud planning via Opus 4.6 on CCR (direct pair with Logan's plan-first behavioral rule)
- **CHICAGO_MCP** — Computer Use via MCP (could subsume Cowork's computer-use MCP)
- **BRIDGE_MODE** — remote control via claude.ai
- **VOICE_MODE** — `/voice` push-to-talk
- **DAEMON / BG_SESSIONS** — background workers
- **BUDDY** — Easter-egg tamagotchi (not relevant)

## Risks
None — intelligence-only. No config to apply, no token cost.

## Required Actions (for Logan's review)
1. **Add the 4 priority flags (KAIROS, COORDINATOR_MODE, ULTRAPLAN, CHICAGO_MCP) to `alerts.md`** as a watchlist section.
2. **Monitor Claude Code release notes** for any of these moving from dead-code to GA.
3. **Pre-plan adoption:**
   - KAIROS + BRIDGE_MODE = persistent-assistant mode; retrofit current workflows before launch hits.
   - ULTRAPLAN slot-in replaces manual plan-mode iteration — worth early adoption when shipped.
   - CHICAGO_MCP vs Cowork computer-use: plan migration path once public.
4. **Retrospective trigger:** when any flag goes GA, run a `scout` and `evaluator` pass specifically on its implications.

## Rollback Plan
N/A — informational only.

**Recommend:** light-touch watchlist addition. Do not invest execution time until a flag moves GA.
