# Antipatterns — Token Waste and Output-Degrading Patterns
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Antipatterns

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

## Archive
