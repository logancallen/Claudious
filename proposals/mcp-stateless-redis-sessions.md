# PROPOSAL: MCP Stateless Redis Session Design

**Finding-ID:** 2026-04-14-mcp-stateless-redis-sessions
**Source:** https://dextralabs.com/blog/claude-code-mcp-enterprise-ai-integrations/
**Classification:** PROPOSAL (REVIEW-REQUIRED, architecture pattern)

## Summary
Production MCP servers should be stateless with session state in Redis, 10-20 connections per instance, deployed behind NGINX `ip_hash` or ALB sticky sessions. Solves the "MCP server crashes lose all session state" problem and enables horizontal scale.

## Rationale
Informational. Applies only if ASF Graphics or Courtside Pro builds its own public-facing MCP server (not consuming third-party MCPs). Not on current roadmap.

## Required Action (Logan review)
1. Confirm: any ASF/Courtside MCP server build planned in next 6 months?
2. If NO → archive.
3. If YES → spec follows: Redis session store, SSE sticky sessions, 10-20 connections/instance, NGINX `ip_hash` routing.
4. Capacity planning: estimate expected concurrent session count; size Redis and instance count accordingly.

## Risks
- Irrelevant without a self-built MCP server. Pure reference.
- Redis becomes the single point of failure for session state — need HA config if adopted.

## Confidence
HIGH on pattern correctness, LOW on near-term applicability.

**Confidence:** LOW-MED — archive unless self-built MCP server is planned.
