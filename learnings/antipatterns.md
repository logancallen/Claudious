# Antipatterns — Token Waste and Output-Degrading Patterns
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Antipatterns

### 2026-04-17 — ANTIPATTERN — Parallel vocabularies for same domain concept (14 in one codebase; initial count of 5 was under-counted 3x)

**Severity:** HIGH
**Context:** ASF Graphics product_type stored in **14 parallel vocabularies** across frontend/backend/DB. Initial audit (3b3d4cc) under-counted at 5; amendment audit against post-035b codebase enumerated the full set: DB CHECK canonical (12 title-case), intake snake_case keys (19), intake display labels (19), intake category taxonomy (3), lead pre-fill map, JobMaterials VEHICLE_PRODUCT_TYPES (9 snake_case), DesignStudio PRODUCT_TYPES (19 snake_case), QuickAddModal PRODUCT_TYPES (8 title-case, 4 violate CHECK), QuoteCalc hybrid defensive shim, frontend + backend SURFACE_WRAP_PRODUCTS, material_advisor maps (16 em-dash), material_advisor signage hybrid, emails.py snake_case compares. Four sites silently no-op; three more work only by substring-match luck. Two latent bugs (phases.js:72, emails.py:536-573) never fired because normalization was missing at the predicate site.
**Learning:** Multiple representations of the same domain concept is a silent-failure generator. One canonical internal key (snake_case or title-case — pick one), labels for display only, normalization shim at every ingress boundary (LLM output, free-text fields, legacy data, API boundaries). DB-level CHECK constraints or enums catch drift at write time. **Hybrid snake_case+title-case "defensive" sets are a tell, not a fix** — they mean someone already hit the drift and papered over it instead of consolidating. **Under-counting the drift is itself a failure mode**: a "5 vocabularies" finding leads to a code-only Phase 1 proposal; a "14 vocabularies" finding forces the correct atomic-migration framing. Always audit vocabulary count against a post-migration tree, not a stale local tree — and if a CHECK constraint exists, the consolidation migration must drop/replace it atomically with the frontend fix (same deploy), not normalize around it.
**Applies to:** Any domain enum (product_type, status, role, category) across any stack. Particularly acute when LLM output or user free-text feeds into a typed column.

### 2026-04-11 — ANTIPATTERN — Bloated CLAUDE.md with Domain Knowledge
**Severity:** HIGH
**Context:** April 7 optimization sprint.
**Learning:** CLAUDE.md is loaded on every single message — not per session, every prompt. Domain knowledge in CLAUDE.md costs tokens on every message regardless of relevance. Move domain knowledge to .claude/skills/ (on-demand) or docs/knowledge/ (reference). Only rules that must fire on every message belong in CLAUDE.md. Target: under 150 lines.
**Applies to:** All Claude Code projects

### 2026-04-11 — ANTIPATTERN — ALL CAPS Emphasis in Claude 4.x
**Severity:** HIGH
**Context:** DreamHost empirical testing.
**Learning:** ALL CAPS emphasis is ignored in Claude 4.x in favor of logic and context. Intensity modifiers like "L99:" have no effect. Replace with conditional phrasing: "If X is available, do Y, else do Z." Never use all-caps for emphasis in any instruction.
**Applies to:** All prompts, CLAUDE.md files, User Preferences

### 2026-04-11 — ANTIPATTERN — Connecting Unused MCP Servers
**Severity:** HIGH
**Context:** April 7 MCP audit — each server costs significant tokens per message.
**Learning:** Every connected MCP server loads full tool definitions into context on every message. One server alone = ~8,400 tokens per message wasted if unused. Disconnect all MCP servers not needed for current task. Reconnect on demand. Audit at start of every Claude Code session via /mcp.
**Applies to:** Claude.ai and Claude Code MCP management

### 2026-04-16 — ANTIPATTERN — CLAUDE.md Without `.claudeignore` and Size Ceiling
**Severity:** HIGH
**Context:** Source: buildtolaunch.substack token-optimization writeup. Sharpens the existing Bloated CLAUDE.md antipattern with a concrete structural target.
**Learning:** Structural target for CLAUDE.md: "five rules and three file pointers," under ~500 tokens (closer to 200 is better). Each line must answer "would removing this cause a mistake?" — yes = keep, no = cut. Pair with a `.claudeignore` file (gitignore syntax) at project root that strips `node_modules`, `.next`, `dist`, `build`, `*.lock`, `.env*`, and `coverage/` from Claude's visibility entirely. Audit length with `wc -w CLAUDE.md` × ~1.3 = token estimate. If over 500 tokens, move details to `docs/` files referenced by filename, not inlined. Re-measure after Arize prompt-learning iteration to catch bloat regression.
**Applies to:** All Claude Code projects — ASF Graphics, Courtside Pro, Claudious, Claude Mastery Lab

## Archive
