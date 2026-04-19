# PROPOSAL: MCP Gateway — Tool Visibility + Auth Enforcement

**Finding-ID:** 2026-04-14-mcp-gateway-pattern
**Source:** https://dextralabs.com/blog/claude-code-mcp-enterprise-ai-integrations/
**Classification:** PROPOSAL (REVIEW-REQUIRED, introduces new infra component)

## Summary
Production enterprise pattern: insert a lightweight proxy between Claude Code and MCP servers that enforces per-identity tool visibility, auth, rate limits, and structured logging. Buildable in ~200 LOC.

## Rationale
Not needed today — Logan's Claude Code setup is single-user with fully trusted MCP servers (Supabase, Netlify, etc.). Value emerges if:
- ASF Graphics or Courtside Pro adds multi-user Claude-powered workflows
- Team-level access to scoped MCP surfaces becomes necessary
- Audit/compliance demands structured tool-call logs

## Required Action (Logan review)
1. Decide whether team access to Claude-powered workflows is on the 6-12 month roadmap. If NO → archive; if YES → proceed below.
2. Spec the gateway: identity model (JWT vs API key), per-identity toolmap shape, logging sink (JSONL vs CloudWatch vs Supabase).
3. Prototype in Node or Go; speak MCP on both sides. ~200 LOC target.
4. Smoke test against Supabase MCP first (lowest blast radius).
5. If successful, front all MCP traffic through gateway and retire direct `claude --mcp-server` wiring.

## Risks
- Over-engineering for a single-user workflow (likely cost > benefit today).
- Adds a failure domain in front of every MCP call (must be highly available).
- Proxy becomes a secrets concentrator — needs its own hardening.

## Confidence
LOW on near-term value. HIGH on pattern correctness if multi-user arrives.

**Confidence:** LOW-MED — archive unless multi-user roadmap confirmed.
