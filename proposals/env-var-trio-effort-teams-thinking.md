# PROPOSAL — Env Var Trio: EFFORT_LEVEL, MAX_THINKING_TOKENS, EXPERIMENTAL_AGENT_TEAMS

**Finding-ID:** 2026-04-16-env-var-trio-effort-teams-thinking
**Disposition:** TEST-FIRST — material token-cost implications
**Category:** CONFIG
**Source:** https://theplanettools.ai/blog/claude-code-330-env-variables-32-feature-flags

## Rationale
Three high-impact env vars complement Logan's existing env layer (2026-04-11-env-var-layer).
- `CLAUDE_CODE_EFFORT_LEVEL=high` — bumps extended-thinking tier.
- `MAX_THINKING_TOKENS=32000` — explicit reasoning-budget cap (can raise or lower per session via shell override).
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` — force-enables agent teams for accounts not auto-flagged.

Agent Teams is already in Logan's shell profile as `=true` — the `=1` form may or may not be equivalent; source suggests `=1` is the flag-matcher form. Worth verifying one works both ways.

## Risks
- **EFFORT_LEVEL=high increases token cost materially** across every session. Not a "set and forget" — needs benchmarking on a representative workload before persistent export.
- **MAX_THINKING_TOKENS=32000 may underperform vs default** on some reasoning-heavy tasks (default may be uncapped or higher). Need A/B on a hard task.
- **EXPERIMENTAL flag is opt-in to unstable behavior** — if agent teams breaks, revert immediately.

## Required Actions (for Logan's review)
1. Bench current env profile (Mac + PC) against `EFFORT_LEVEL=high` on a consistent prompt (e.g., a financial-modeler session on a fixed scenario). Measure: wall-clock, output quality, token spend.
2. Test `MAX_THINKING_TOKENS=32000` vs default on the same session. Confirm quality ≥ baseline.
3. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` vs the `=true` form currently set — pick one and standardize.
4. Cross-reference with the turboai env-vars list (500+) and mculp gist v2.1.104 — scout finding notes Logan may be missing other high-value vars.
5. If benchmark wins: add to shell profile on both machines and document in `learnings/techniques.md`.

## Rollback Plan
Env vars are ephemeral — `unset VAR_NAME` or comment out in `.zshrc` / PS profile. Keep a dated snapshot of `.zshrc` in `snapshots/` before editing.

## Open Questions
- Does `EFFORT_LEVEL=high` stack with explicit `/think` slash or supersede it?
- Default value of `MAX_THINKING_TOKENS` — setting a ceiling could be a net loss.
- Is the `=1` vs `=true` convention documented anywhere official?

**Recommend:** schedule a 30-min benchmarking session; do not persistently export `EFFORT_LEVEL=high` before that.
