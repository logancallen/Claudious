# mcp-spec-oauth-2-1
**Source:** archive/intake/2026-04-20.md section B-3
**Impact:** MEDIUM | **Effort:** LOW | **Risk:** TEST-FIRST
**Type:** TOOL / PROTOCOL
**Target (proposed):** learnings/techniques.md or canonical/toolchain.md note

## Finding
The MCP specification now incorporates OAuth 2.1 with incremental scope consent (April 2026). Source: https://use-apify.com/blog/mcp-server-handbook-2026 (VERIFIED community summary of spec update).

## Current state
Logan runs 5+ MCP servers (GitHub, Supabase, Perplexity, etc). Authentication currently via env-var-injected tokens, gated by `CLAUDE_CODE_MCP_ALLOWLIST_ENV` (added 2026-04-14).

## Decision needed
1. Do any of Logan's self-hosted MCP servers need OAuth 2.1 migration? (Hosted services — GitHub MCP — handle auth upstream; self-hosted custom servers may need updates.)
2. Add a note to `canonical/toolchain.md` tracking OAuth 2.1 migration status per server.

## Why not auto-queue
TEST-FIRST risk: OAuth changes touch auth paths; not a documentation-only edit. Requires manual review of each MCP server.
