# PROPOSAL — Document Monitor Tool and /autofix-pr Command (Week 15 Additions)

**Finding-ID:** 2026-04-17-monitor-autofix-pr-tools
**Impact:** H | **Effort:** T | **Risk:** SAFE
**Source:** Section B-1 — official Claude Code release notes (Week 15, Apr 6–10)

## Finding
Two new tools from Week 15 not yet covered in learnings or proposals:
1. **Monitor tool** — streams background process events into Claude context. Enables real-time monitoring of background tasks without polling.
2. **/autofix-pr** — auto-fixes PR issues from the terminal. Takes a PR URL, analyzes CI failures and review comments, applies fixes and pushes.

Note: `/team-onboarding` and `/loop` (now `/proactive`) are already tracked in `proposals/v2-1-x-command-awareness.md`.

## Proposed Action
Add a TECHNIQUE entry to `learnings/techniques.md`:

**Learning — Monitor tool:** Use the Monitor tool to stream background process events (test runners, build pipelines, servers) into the Claude session. Eliminates the poll-and-check loop — Claude receives events as notifications and can respond immediately. Wire with run_in_background for non-blocking parallel work.

**Learning — /autofix-pr:** `/autofix-pr <PR-URL>` analyzes CI failures and review comments, applies fixes locally, and pushes. Use after any PR creation as a first-pass auto-fix before manual review. Especially useful for lint, type-check, and test failures.

## Why Proposal (not Auto-Queue)
Editing existing techniques entry vs pure append — and should be reviewed alongside v2-1-x-command-awareness.md proposal for consistency before adding to learnings.
