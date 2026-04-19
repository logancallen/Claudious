# Antipatterns — Token Waste and Output-Degrading Patterns
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Antipatterns

### 2026-04-17 — ANTIPATTERN — Parallel vocabularies for same domain concept

**Severity:** HIGH
**Context:** ASF Graphics product_type stored in 5 vocabularies across frontend/backend/DB. Filter predicates written in one vocabulary silently no-op against data stored in another. Two latent bugs found in live code (phases.js:72, backend/routes/emails.py:536-573) that never fired because data normalization was missing at the predicate site.
**Learning:** Multiple representations of the same domain concept is an antipattern that generates silent-failure bugs. One canonical internal key (snake_case), labels for display only, and a normalization shim at every ingress boundary (LLM output, free-text fields, legacy data, API boundaries). DB-level CHECK constraints or enums catch drift at write time.
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
