# PROPOSAL: MCP Circuit Breaker — 50%/30s Reliability Pattern

**Finding-ID:** 2026-04-14-mcp-circuit-breaker
**Source:** https://dextralabs.com/blog/claude-code-mcp-enterprise-ai-integrations/
**Classification:** PROPOSAL (TEST-FIRST, requires wrapper around MCP client calls)

## Summary
Wrap MCP tool invocations in retry-with-jitter + circuit breaker. Config: 50% failure rate over 10s sliding window opens the breaker; 30s cooldown → half-open test. Exponential backoff with full jitter, 3-5 retries max.

## Rationale
Logan runs 5+ MCP servers. When Supabase MCP flaps (has happened), current behavior is to burn tokens on dead connections until the user kills the session. Circuit breaker prevents this silent token drain.

## Required Action (Logan review)
1. Identify wrapper insertion point. Options:
   - `.claude/hooks/pre-tool-use` hook with state file tracking failure windows (simplest, per-repo).
   - Global wrapper in shell profile (harder — no hook point exists).
   - Patch Claude Code MCP client (not supportable — not our code).
2. Prototype hook: JSONL failure log under `.claude/state/mcp-circuit/{server}.log`. On invocation, read last 10s of events; if >50% failed, return error instead of dispatching.
3. Half-open logic: after 30s with no attempts, let one call through; success resets, failure reopens.
4. Test against deliberately-misconfigured MCP server first.

## Risks
- Hook-based solution has race conditions under parallel tool calls (may double-dispatch).
- False opens from transient network blips — tune threshold if triggering too often.
- Adds latency on every MCP call (state file read).
- May not be worth implementing if Supabase MCP stability improves independently.

## Confidence
MEDIUM on value, LOW on clean implementation via hooks.

**Confidence:** MED — revisit after next Supabase MCP flap event; instrument first, decide on wrapper second.
