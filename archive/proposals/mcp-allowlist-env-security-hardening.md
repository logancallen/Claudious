# PROPOSAL: CLAUDE_CODE_MCP_ALLOWLIST_ENV — MCP Env Inheritance Hardening

**Finding-ID:** 2026-04-14-mcp-allowlist-env
**Source:** https://www.turboai.dev/blog/claude-code-environment-variables-complete-list
**Classification:** PROPOSAL (SECURITY + HIGH + TEST-FIRST, requires shell-profile edit + MCP audit)
**Risk:** TEST-FIRST — may break MCP servers that rely on inherited env vars

## Why Proposed (not queued)
Requires shell-profile edit on Mac + PC and a pre-flight audit of MCP server env needs. Violates the "md-only" queue rule. Also needs per-server validation because the wrong allowlist breaks downstream tools silently.

## Problem It Solves
Current setup inherits the full parent-process environment into every MCP server. Logan runs 5+ MCP servers (Playwright, TranscriptAPI, GitHub + Supabase/Stripe/Netlify from Claude.ai). Any secret in env (API keys, OAuth tokens, Supabase service-role keys) is visible to every third-party MCP process.

## Proposed Change
Add to shell profile on Mac + PC:
```
CLAUDE_CODE_MCP_ALLOWLIST_ENV="PATH,HOME,NODE_PATH,MCP_SERVER_*,SUPABASE_URL,SUPABASE_ANON_KEY"
```

Tune the allowlist after auditing what each MCP server actually reads.

## Pre-Flight Audit (Required Before Rollout)
1. List current MCP servers: `claude mcp list`
2. For each, check the package docs or source for required env vars
3. Confirm none of Logan's third-party servers read secrets they shouldn't
4. Only then enable the allowlist

## Rollback
Unset the env var. Full inheritance resumes immediately.

## Why This Matters to Logan
- 5+ MCP servers × unbounded env = broad attack surface if any MCP package is compromised
- BuyBoard / procurement work involves sensitive client data — reducing secret leak vectors is asymmetric upside
- Pairs with the existing "Connecting Unused MCP Servers" antipattern (both about MCP surface area reduction)

## Confidence: MEDIUM-HIGH (75%)
Source is a single blog cataloging undocumented env vars. The mechanism (env inheritance scoping) is a standard OS-level pattern and the feature flag follows Claude Code's naming convention, but the blog is the only citation. Rollout behind TEST-FIRST gating is appropriate.

**Strongest reason this could be wrong:** The env var may not exist or may have different semantics in Logan's v2.1.104 build. Validate by running `env | grep CLAUDE_CODE` after setting, then `claude mcp list` and confirming all servers still connect.

## Applies To
Claude Code on Mac + PC. Does not affect Claude.ai MCP integrations (those run in Anthropic's environment).
