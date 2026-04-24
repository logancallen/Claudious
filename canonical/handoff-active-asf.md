# Handoff — 2026-04-23 PM (ASF RM-022 Phase 1a shipped + 062 migration split applied)

**Recommended next-chat title:** `2026-04-24 — ASF — RM-022 Phase 1b Capture UI Build`

---

## Current state

RM-022 Phase 1a (schema + backend) is built and committed on main. Migrations 058–062 have been applied to Supabase via Claude.ai MCP. The 062 file was split into 062a + 062b in a follow-up commit to match project convention on ALTER TYPE transactional constraints.

- Working tree: `/Users/loganallen/Documents/GitHub/asf-graphics-app/` (Mac canonical)
- Branch: `main`
- Local HEAD: `4c7bed8` — fix(RM-022): split migration 062 into 062a enum + 062b table
- Prior commit: `6f24bc8` — feat(RM-022): universal feedback system schema + backend (Phase 1a)
- origin/main: still at `6f24bc8`. **Local is 1 commit ahead — push pending Logan's next Mac session.**

## Database state (Supabase via Claude.ai MCP)

All five tables live with RLS active and expected policies:

- `feedback` — rls=true, 4 policies (SELECT/INSERT/UPDATE/DELETE)
- `feedback_reporters` — rls=true, 3 policies. Feedback SELECT upgraded with co-reporter clause; verified in compiled `pg_policies.qual`.
- `feedback_resolutions_log` — rls=true, 3 policies (SELECT inherits parent, INSERT/UPDATE admin-only)
- `feedback_comments` — rls=true, 4 policies (SELECT parent, INSERT self+parent, UPDATE/DELETE author-or-admin)
- `user_notification_prefs` — rls=true, 3 policies, 4/4 existing users backfilled, auto-provision trigger on `auth.users` active

`notification_type` enum: 13 values total. 5 new `feedback_*` values confirmed.

## What shipped in the 4c7bed8 split commit

- `supabase/migrations/062a_notification_type_feedback_values.sql` — 5 ALTER TYPE lines, NO BEGIN/COMMIT wrapper. ROLLBACK note documents that Postgres does not support DROP VALUE; full reversal requires restore-from-backup.
- `supabase/migrations/062b_user_notification_prefs.sql` — table + RLS + triggers + backfill, BEGIN/COMMIT wrapped. Git-renamed from the original 062 (preserves history).
- `docs/schema-state.md` — updated to reference 062a + 062b, explains the split.
- `docs/learnings.md` — new GOTCHA entry + PROMOTE TO CLAUDIOUS block: "ALTER TYPE ADD VALUE migration split pattern."

## Convention lesson locked into learnings

The spec's inline claim that `ALTER TYPE ... ADD VALUE IF NOT EXISTS` is "transactional-safe since Postgres 12" is misleading. The ALTER itself is legal inside BEGIN/COMMIT, but the newly-added value **cannot be referenced by any other statement in the same transaction**. Supabase MCP wraps every file in BEGIN/COMMIT, so bundling enum extensions with dependent work (triggers, CHECKs, backfills that reference the new value) forces a split. Mirrors the prior 035a/035b taxonomy split pattern.

Rule going forward: any migration touching ALTER TYPE ADD VALUE must be split. `NNNa_{enum}_values.sql` (no transaction) + `NNNb_{dependent_work}.sql` (wrapped, runs after).

## In-flight

- `git push origin main` pending. Logan pushes from home or next Mac session via `!git push origin main`. The push will land commit `4c7bed8` onto origin and unblock Netlify / Railway redeploys.
- Working tree is clean except `.DS_Store` noise (always-ignorable).

## Next steps

1. **Push `4c7bed8` to origin/main** (Logan's next Mac session). Railway auto-redeploys the backend; Netlify rebuilds the frontend (no frontend changes in this Phase, so the Netlify cycle is a no-op but harmless).
2. **Smoke test `/api/feedback/health`** with an admin JWT against `https://asf-graphics-app-production.up.railway.app/api/feedback/health` after the Railway redeploy completes. Expected response: a JSON blob with `median_time_to_resolution_hours: null`, `counts_by_status: {}`, `distinct_reporters: 0`, etc. (zero feedback rows yet.) A 500 or missing-route 404 means the router didn't register — check Railway logs.
3. **Kick off Phase 1b** (capture UI) using `cc-prompt-1b-rm022-capture-ui.md` from `~/Downloads/asf\ 0423/`. Fresh CC session. Do NOT run in the same session as pricing engine work or as 1c. Phase 1b installs `html2canvas`, builds `FeedbackButton`, `FeedbackCaptureModal`, `PendingSyncBanner`, `feedback-offline-queue.js`, `html2canvas-pii-redact.js`, `useFeedback`, `useFeedbackQueue`, and mounts in `App.jsx`.

## Prompt 1a follow-ups NOT in scope for 1b

These belong to Phase 1c and should NOT be tackled in 1b:
- External cron scheduler configuration (cron-job.org / Railway Scheduler) pointing at `/api/feedback/cron/{age-feedback,expire-screenshots,flush-digests}` with `X-Cron-Secret` header.
- Email digest delivery path. Notification service has `TODO(RM-022 1c)` markers at every email enqueue point.
- `NotificationPreferences` settings page.
- `FeedbackTriage` admin page (keyboard-driven queue review).
- `FeedbackHealth` admin dashboard page.
- `MyFeedback` user page.

## Other ASF work on deck (unchanged from prior handoff)

**Pricing engine Prompts 3–7** (parallel track; must NOT share a CC session with RM-022):
- Prompt 3 — `POST /api/quotes/calculate-v2` endpoint + write-guard triggers
- Prompt 4 — Frontend `src/lib/pricing_v2.js` + Vitest harness

**RM-021** (Design Library bulk upload) — draft CC prompts after RM-022 Phase 1 fully ships. RM-021 benefits from the feedback surface being live so library misclassifications flow into the universal feedback system.

## Files to glance at on next chat start

- `docs/specs/rm-022-universal-feedback-system.md` §6 — frontend component contracts (1b inputs)
- `backend/routes/feedback.py` — the endpoints 1b will call
- `backend/models/feedback.py` — Pydantic request shapes the frontend must match
- `~/Downloads/asf 0423/cc-prompt-1b-rm022-capture-ui.md` — the next prompt to paste

## Not blocking but worth noting

- `.DS_Store` noise persists in tracked form on `.DS_Store` and as an untracked file at `src/pages/.DS_Store`. Pre-existing; not from this session. Consider a one-line gitignore cleanup at a quiet moment.
- Remote `origin/main` will be 1 commit behind until Logan pushes. No branches were created; all work is on main per project rule.
