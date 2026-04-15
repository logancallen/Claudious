# PROPOSAL: Run `/powerup` for Feature Discovery

**Finding-ID:** 2026-04-14-powerup-lessons
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Classification:** PROPOSAL (SAFE, requires manual CLI session)
**Risk:** SAFE — read-only interactive tutorial

## Why Proposed
Requires Logan to open Claude Code and run a slash command. Cannot be automated by Claudious.

## Why It Matters
Logan's current setup (v4) is dense: 5 env vars, 14 MCP servers across Claude.ai + Claude Code, 20+ skills, 6 agents, 5 plugins, 8 scheduled tasks. There is almost certainly a Claude Code feature Logan has not touched. `/powerup` launches interactive animated demos of hooks, skills, subagents, plan mode, etc. — a high-signal way to surface missed capabilities without reading docs.

## Proposed Action
1. Update Claude Code to latest
2. In any Claude Code session, run `/powerup`
3. Browse all lessons, note any feature not already in `logan-current-setup-v4.md`
4. For each novel capability: log as a `digest/` entry or open a new proposal

## Expected ROI
Even one surfaced feature that replaces a manual workflow is worth the 30 minutes. Given Logan's tooling depth, probability of finding 1+ useful feature is HIGH.

## Confidence: HIGH (85%)
Source confirms the command exists in recent Claude Code releases. The only uncertainty is whether Logan's v2.1.104 has it — if not, a CLI update brings it in.

**Strongest reason this could be wrong:** `/powerup` content may overlap heavily with what Logan's already using. Worst case: 30 min burned, one confirmation that the current stack is comprehensive.

## Applies To
Claude Code on PC (or Mac when at office). One-off action, not recurring.
