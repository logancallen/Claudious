# Queue Item — mcp-500k-result-storage

**Source:** intake/2026-04-19.md — Section B, Search 1
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/techniques.md

## Change block

```
### 2026-04-19 — TECHNIQUE — MCP 500K Result Storage in Claude Code
**Severity:** HIGH
**Context:** Claude Code Week 16 April 2026 update increased MCP result storage limit.
**Learning:** Claude Code now stores up to 500,000 characters per MCP tool result (previously much lower). For Logan's 5+ MCP server setup, this means large query results, GitHub API payloads, and database responses no longer need truncation workarounds. If an MCP result is silently cut off, the new limit is 500K chars — check server-side response size if truncation still occurs.
**Applies to:** All Claude Code sessions using MCP tools — GitHub MCP, Supabase MCP, Perplexity MCP
```

## Verification grep

`grep -c "500,000 characters" learnings/techniques.md`
