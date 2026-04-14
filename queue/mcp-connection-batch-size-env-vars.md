# QUEUED: Add MCP_SERVER_CONNECTION_BATCH_SIZE + MCP_CONNECTION_NONBLOCKING
**Finding-ID:** 2026-04-13-mcp-connection-batch-size
**Source:** https://www.turboai.dev/blog/claude-code-environment-variables-complete-list
**Classification:** QUEUED (SAFE + HIGH + TRIVIAL)
**Risk:** SAFE

## What It Does
- `MCP_SERVER_CONNECTION_BATCH_SIZE` — concurrent MCP startup connections (default 3). Doubling speeds up initialization.
- `MCP_CONNECTION_NONBLOCKING=1` — prevents a stalled MCP server from blocking others.

## Why Queued
- SAFE: no breaking changes, both vars are additive tuning
- HIGH impact: Logan runs 5+ MCP servers — startup cost is real and stalled servers currently block init
- TRIVIAL: two env vars, no config conflicts

## Implementation Steps
1. Add to shell profile on Mac and PC:
   - `MCP_SERVER_CONNECTION_BATCH_SIZE=6`
   - `MCP_CONNECTION_NONBLOCKING=1`
2. Append new entry (or extend existing) in `learnings/techniques.md`

## Proposed learnings/techniques.md Edit
Add new active technique block:

```
### 2026-04-13 — TECHNIQUE — Faster MCP Startup via Batch + Nonblocking
**Severity:** HIGH
**Context:** Logan runs 5+ MCP servers; default batch size 3 causes slow inits and one stalled server blocks the rest.
**Learning:** Set MCP_SERVER_CONNECTION_BATCH_SIZE=6 (double default) and MCP_CONNECTION_NONBLOCKING=1 in shell profile. Speeds startup and prevents any single stalled server from blocking the session. Pairs with Env Var Layer technique.
**Applies to:** All Claude Code sessions on Mac and PC with 5+ MCP servers
```

## Verification
- Time Claude Code startup with `/mcp` command before and after
- Temporarily stall one MCP to confirm others still connect

## Applies To
All Claude Code sessions globally — shell profile on Mac and PC.
