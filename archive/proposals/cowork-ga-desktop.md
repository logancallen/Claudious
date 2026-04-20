# cowork-ga-desktop
**Source:** archive/intake/2026-04-20.md section B-4
**Impact:** MEDIUM | **Effort:** TRIVIAL | **Risk:** SAFE
**Type:** NEWS / STATE
**Target (proposed):** learnings/platforms/claude.md or canonical/claude-state.md

## Finding
Claude Cowork is now GA on macOS + Windows in Claude Desktop. Adds expanded analytics, OpenTelemetry support, and RBAC for Enterprise. Does NOT resolve the 1M → 200K Cowork regression tracked in 04-17 findings. Source: https://claude.com/product/cowork

## Current state
`learnings/platforms/claude.md` already has three Cowork-related entries (Computer Use in Cowork, Persistent Agent Thread, Cowork sandbox multi-repo gotcha). No explicit "Cowork GA" entry.

## Decision needed
Add a short GA-status note to `learnings/platforms/claude.md` for session-start orientation? Or defer to next canonical state refresh. Recommended: small append to platforms/claude.md noting GA + unresolved 1M regression.

## Why not auto-queue
MEDIUM impact (NEWS, no immediate action). Logan already uses Cowork daily; GA does not change workflow.
