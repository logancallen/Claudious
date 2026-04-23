# Proposal — Investigate PostgREST Schema-Cache Bug as Root-Cause Factor for ASF Migrations 026-028

**Filed:** 2026-04-22
**Source:** Weekly Evidence Loop (research/domain-briefs/2026-04-22-asf-stack-brief.md)
**Severity:** HIGH
**System:** ASF-GRAPHICS

## Background

The 2026-04-14 CRITICAL alert (alerts.md line 12) reports that ASF migrations 026-028 broke employee permissions, with root cause unidentified and new migrations blocked pending a dedicated audit session. As of 2026-04-22 the drift detector confirms the blocker is 8 days stale (alerts.md line 17, docs/drift-report.md CRIT-1).

This week's Evidence Loop surfaced **supabase/supabase#42183**, an actively tracked bug in which the PostgREST schema cache does not reliably refresh when new columns are added to existing tables or when new tables are created. The symptom is **PGRST204 errors referencing columns/tables that exist in the database**. Community-documented refresh methods (`NOTIFY pgrst, 'reload schema'`) have been reported ineffective in affected deployments.

## Hypothesis

Migrations 026-028 succeeded at the database level, but PostgREST continues to serve a stale schema cache. What reads as "broken employee permissions" at the application layer may in fact be:

1. RLS policies referencing newly-added columns/tables that PostgREST cannot resolve → PGRST204.
2. New policy conditions evaluating against stale column definitions → false-negative authorization failures that look like permission regressions.

If this hypothesis is correct, no migration code is actually broken — the fix is forcing a schema-cache refresh, not reverting migrations.

## Proposal

Scope the next ASF audit session to include an explicit schema-cache test as Step 1, before any migration rollback or policy rewrite:

1. **Reproduce**: In a staging environment, replay migrations 026-028 against a snapshot of pre-migration state.
2. **Observe**: Tail PostgREST logs for PGRST204 errors. Check whether error messages reference columns added in 026-028.
3. **Force refresh**: Apply the strongest known refresh path — explicit `SELECT pg_notify('pgrst','reload schema');` followed by a project pause/unpause if the notify alone is insufficient. Supabase Dashboard → Project Settings → Restart is the nuclear option.
4. **Re-test**: Verify employee permissions after each refresh step.
5. **Document**: If schema-cache staleness is confirmed as the cause, add the notify-then-restart sequence to the ASF migration runbook as a mandatory post-migration step. If confirmed NOT the cause, document the ruling-out and proceed with the original root-cause audit.

## Out of scope

- This proposal does not recommend rolling back any migration or rewriting any policy until the schema-cache hypothesis is ruled in or out.
- This proposal does not touch Courtside Pro or any other Claude Project.

## Open question for Logan

Do you want the investigation run in the existing asf-graphics-app repo's dedicated audit session, or should a dedicated ~90-min Claude Code session be scheduled with only the schema-cache scope? Recommendation: bolt onto the existing audit session as Step 1, since ruling schema-cache in/out is cheap (≤30 min) and either outcome materially changes the rest of the audit.

## Sources

- [supabase/supabase#42183 — PGRST204 schema cache not updating](https://github.com/supabase/supabase/issues/42183)
- [PostgREST CHANGELOG](https://github.com/PostgREST/postgrest/blob/main/CHANGELOG.md)
- `research/domain-briefs/2026-04-22-asf-stack-brief.md` §3
- `alerts.md` line 12 (2026-04-14 CRITICAL), line 17 (2026-04-22 CRITICAL DRIFT)
