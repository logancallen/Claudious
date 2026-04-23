# Proposal — Reconcile MCP count inconsistency (5+ / 7 / 12) across docs

**Source:** pioneer-2026-04 re-run; cross-file grep across canonical/, learnings/, mastery-lab/
**Impact:** M (doc-truth; low direct impact but compounds into every MCP-related decision — circuit breaker, allowlist, gateway proposals all cite different counts)
**Effort:** S
**Risk:** SAFE
**Routing reason:** Needs Logan to confirm the authoritative number via `/mcp` on both machines → PROPOSAL

## Description
Three different MCP server counts appear across the Claudious knowledge base as of 2026-04-22:

- "5+ MCPs" — referenced in alerts.md 2026-04-14 (context-mode proposal justification), MCP-allowlist proposal
- "7 MCPs" — referenced elsewhere in mastery-lab research notes
- "12 MCPs hosted/managed" — canonical/toolchain.md per deployed.log 2026-04-20 (mcp-spec-oauth-2-1 closure evidence)

The three proposals downstream of MCP count (`mcp-circuit-breaker-pattern`, `mcp-gateway-pattern`, `mcp-stateless-redis-sessions`, `mcp-allowlist-env-security-hardening`, `context-mode-mcp-plugin`) each cite a different ceiling, which muddies the cost/benefit math for each.

## Proposed action
1. Logan runs `/mcp` in a fresh Claude Code session on both Mac and PC; lists the names of connected servers on each.
2. Cross-reference with Cowork MCPs (from the deferred-tool list in this session, the Cowork environment has substantially more than 12 — Figma, Supabase, Cloudflare, Netlify, Gmail, Hugging Face, QuickBooks, ctx7, Apollo, Common Room, Hex, Atlassian, Canva, Klaviyo, Ahrefs, Google Calendar, Intercom, Notion, Guru, MS365, Supermetrics, Amplitude, Fireflies, Pendo, ClickUp, Monday, Close).
3. Authoritative source: update `canonical/toolchain.md` with exact counts, split by surface — (a) Claude Code MCPs on Mac, (b) Claude Code MCPs on PC, (c) Cowork / desktop MCPs, (d) Claude.ai MCPs. These live in different orchestrators and shouldn't be conflated.
4. Update downstream proposals (`mcp-circuit-breaker-pattern`, etc.) to reference the correct surface-specific count. Proposals currently written against "5+" may have different ROI vs. a verified 12 or 20+.

## Why not queued
Requires running `/mcp` on two machines and possibly reading Claude Desktop's connector list. No way to automate from markdown.

## Rollback
N/A — doc cleanup.
