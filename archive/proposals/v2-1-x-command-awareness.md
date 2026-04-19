# PROPOSAL — v2.1.x Slash Command Awareness Pack

**Finding-IDs bundled:**
- 2026-04-16-tui-fullscreen-command (`/tui fullscreen`, v2.1.110)
- 2026-04-16-focus-command-replaces-ctrl-o (`/focus` replaces Ctrl+O, v2.1.110)
- 2026-04-16-team-onboarding-command (`/team-onboarding`, v2.1.101)
- 2026-04-16-proactive-loop-alias (`/proactive` alias for `/loop`, v2.1.105)

**Disposition:** SAFE but LOW individual impact — bundled to reduce queue noise; awareness level only, no config change
**Category:** COMMAND
**Source:** https://releasebot.io/updates/anthropic/claude-code

## Rationale
Four small slash-command additions / renames from recent Claude Code releases. None warrants a standalone queue entry, but collectively they update Logan's command surface.

- **`/tui fullscreen`** — flicker-free fullscreen mode for long debug sessions. Materially better UX during multi-hour builds.
- **`/focus`** — toggles focus view independently from transcript display. Replaces `Ctrl+O`, which had terminal-multiplexer collisions. Ctrl+O still works but is deprecated.
- **`/team-onboarding`** — generates ramp-up guides from local Claude Code usage patterns (commands invoked, skills used, hooks triggered, common workflows). Useful as a self-audit for solo use — surfaces over-used commands worth aliasing and unused skills worth pruning.
- **`/proactive`** — alias for `/loop`. Signal that `/loop` will be deprecated in a future major. Update muscle memory.

## Risks
None. All additive / deprecation-only; backwards-compatible.

## Required Actions (for Logan's review)
1. **Update Claude Code** on Mac + PC to ≥ v2.1.110.
2. **Run `/team-onboarding` once** (after 2-4 weeks of current-profile use) — use its output as the baseline before the next CLAUDE.md refactor and the skill-description rewrite proposed earlier.
3. **Minor muscle-memory updates:** start using `/focus` and `/proactive`.
4. **Optional:** add `/tui fullscreen` to a default session-start pattern if Logan prefers the mode.
5. **No `learnings/` entries required** — these are commands, not architecture.

## Rollback Plan
N/A.

**Recommend:** one-time update sweep. Takes 5 minutes; no ongoing maintenance.
