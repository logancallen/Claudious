# Preflight Hook Refactor — use direct MCP invocation (CC 2.1.118)

**Source:** archive/intake/2026-04-24.md § B — 2026-04-24-hooks-invoke-mcp-directly
**Credibility:** OFFICIAL
**Impact:** MEDIUM | **Effort:** MEDIUM | **Risk:** REVIEW-REQUIRED

## Summary
Claude Code 2.1.118 lets hooks invoke MCP tools directly, removing the shell-out intermediary. Claudious's SessionStart preflight currently shells out to `scripts/update-heartbeat.sh` (or `.ps1`). A direct-MCP path would collapse that to an MCP tool call, simplify cross-platform (no bash/Git Bash/PowerShell fork), and reduce process-spawn latency on hot CC sessions.

## Why proposal (not auto-deploy)
Touches production hook infrastructure across 3 tracked repos (Claudious, asf-graphics-app, courtside-pro). Requires:
- A new MCP tool exposing `update-heartbeat(repo)` equivalent, ideally hosted in Claudious.
- Validation that the fail-open `[WARN] preflight-degraded` behavior is preserved when MCP is unreachable.
- Rollback plan if the direct-MCP path halts a CC session on infra error.
This is not a markdown append; it's an architecture change. REVIEW-REQUIRED.

## Logan action
1. Decide whether to invest in this refactor or leave the bash/ps1 wrapper as-is (it works and is fail-open).
2. If yes: spec the MCP tool, pilot in Claudious, then roll to asf-graphics-app + courtside-pro.
3. If no: close this proposal with rationale "bash wrapper is stable; MCP path adds Claudious-availability dependency to session start."

## Notes
- Current preflight logic is in `scripts/update-heartbeat.sh` with a sibling `.ps1`.
- `.claude/settings.json` `SessionStart` hook fires the wrapper today; swap would be a one-line settings change plus the MCP tool build.
- Keep `[WARN] preflight-degraded` semantics: any MCP failure must exit 0, not halt CC.
