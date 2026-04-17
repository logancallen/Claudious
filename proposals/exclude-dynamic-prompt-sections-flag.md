# PROPOSAL — `--exclude-dynamic-system-prompt-sections` Flag for Print-Mode / CI

**Finding-ID:** 2026-04-16-exclude-dynamic-prompt-sections-flag
**Disposition:** TEST-FIRST — may change behavior in tasks that depend on timestamps / env context
**Category:** CONFIG
**Source:** https://releasebot.io/updates/anthropic/claude-code (v2.1.98)

## Rationale
CLI flag for print mode (`--print` / `-p`) that strips dynamic sections (timestamps, session-specific context, env details) from the system prompt. Dramatically improves cross-run prompt-cache hit rates on scripted invocations. Direct cost savings compound across Logan's scheduled tasks (Scout, Evaluator, Implementer, Harvester, Digest, Autodream, Drift-Check) — all of which are print-mode-eligible.

Strongest pairing: run this flag alongside a warm-cache `/compact` window to maximize prompt-cache reuse.

## Risks
- **Scheduled tasks may rely on today's date being inlined** (several of Logan's tasks use the `currentDate` claudeMd entry). If this flag strips that, behavior changes silently.
- **Non-applicable to interactive sessions** — Claude needs dynamic env context to answer "what time is it" style questions.
- **Fragile verification:** cache-hit gains only show in billing, not in any immediate tool output.

## Required Actions (for Logan's review)
1. **Before rolling out globally:** pick one low-stakes scheduled task (e.g., Evaluator), run it twice — once with the flag, once without — and compare output byte-for-byte for regressions tied to date/env context.
2. **If identical:** roll out to Scout, Evaluator, Implementer, Harvester task definitions.
3. **Measure cache-hit rate** before/after via billing dashboard (rough estimate over 7-day window).
4. **Do not apply** to any task that emits `YYYY-MM-DD` in its output unless the date is passed explicitly via prompt arg rather than read from system prompt.

## Rollback Plan
Remove the flag from scheduled-task command strings; revert commits.

## Open Questions
- Does the flag also strip the `claudeMd` project-instructions block or only the true dynamic stuff?
- Is `currentDate` in `claudeMd` considered dynamic or static?

**Recommend:** one-task pilot this week; full rollout if byte-identical outputs confirmed.
