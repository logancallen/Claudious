# Handoff — 2026-04-23 (ASF RM-021 + RM-022 specs archived, RM-022 Phase 1 ready to build)

**Recommended next-chat title:** `2026-04-23 — ASF — RM-022 Phase 1a Build Kickoff`

---

## Current focus

RM-022 Phase 1 is fully specced and CC-prompt-ready. Next session starts the build.

Specs committed to repo:
- `docs/specs/rm-021-design-library-bulk-upload.md` (850 lines)
- `docs/specs/rm-022-universal-feedback-system.md` (941 lines)

Commit: `a15b8b2` on main. Pushed and verified against origin/main.

Three CC prompts drafted and saved to downloads (not yet in repo):
- `cc-prompt-1a-rm022-schema-backend.md` (380 lines) — migrations 058–062 + backend routes
- `cc-prompt-1b-rm022-capture-ui.md` (456 lines) — FeedbackButton + CaptureModal + offline queue
- `cc-prompt-1c-rm022-triage-notifications.md` (541 lines) — Triage + Health dashboard + notifications, closes RM-022 Phase 1

Sequencing locked: RM-022 Phase 1 runs **parallel to pricing engine Prompt 3** (different files, no merge conflicts, must NOT be in same CC session).

---

## Completed this session

- RM-021 spec fully drafted reusing existing infrastructure (presigned upload, PyMuPDF, auto_categorize, batch-confirm, regenerate-preview). Core change: async decoupling via FastAPI BackgroundTasks. Not a greenfield build.
- RM-022 spec fully drafted integrating all 40 gaps from prior chats (Classes A through E). Peer-privacy RLS locked as the ONLY hard block in the platform (documented exception to warn-don't-block).
- Schema: migrations 058–062 with rollback blocks per Gap 27, RLS in-same-migration per Gap 30, CHECK constraint on AI columns per Gap 31, indexes per Gap 28.
- 5 pending questions from prior handoff answered and locked:
  - Q1 upload pattern: bulk absorbs mixed batches, sticky default for common case
  - Q2 preview service: PyMuPDF stays (already in code), async decouple
  - Q3 AI classification: Opus 4.7 in Phase 2
  - Q4 phasing: phased ship (Phase 1 → 2 → 3)
  - Q5 RM-022 slot: parallel to pricing engine Prompt 3
- 6th pending question deferred: S10 tax-exempt status (CPA/legal, non-architectural)
- 2 specs committed to `docs/specs/` via commit `a15b8b2`

## In-flight

Nothing. Design and spec state is complete. Build has not started.

## DesignStudio.jsx incident

During spec archival, CC surfaced a pre-existing dirty working tree:
- `src/pages/DesignStudio.jsx` was deleted locally, uncommitted
- Forensics confirmed: file intact on origin/main (2,341 lines, blob `271449d`, last touched in commit `699bba2` 2026-04-20 — a normal bugfix)
- No commit on any branch deleted or renamed it
- Restored via `git checkout HEAD -- src/pages/DesignStudio.jsx`, NOT committed (restoration is a clean revert, not a code change)

Root cause: local-only deletion from an editor/script/Finder — classic machine-drift pattern from User Preferences. File is recovered. Remaining dirty state is only `.DS_Store` noise.

## Pending (carryover to next chat)

**RM-022 Phase 1a build** (fresh CC session, paste `cc-prompt-1a-rm022-schema-backend.md`):
- Apply migrations 058–062 via Supabase MCP (not via CC — per learned pattern)
- Build `backend/routes/feedback.py`, `notification_service.py` (email as TODO for 1c), `s3_storage.py` feedback-bucket helpers, `feedback_tasks.py` crons, `models/feedback.py`
- Register router in `main.py`
- Add `R2_FEEDBACK_BUCKET` to env var documentation

**RM-022 Phase 1b** (after 1a committed, fresh CC session):
- Install `html2canvas` + `uuid`
- `FeedbackButton`, `FeedbackCaptureModal`, `PendingSyncBanner`, `FeedbackContext`
- `feedback-offline-queue.js`, `html2canvas-pii-redact.js`
- `useFeedback`, `useFeedbackQueue` hooks
- Mount in `App.jsx`

**RM-022 Phase 1c** (after 1b committed, fresh CC session):
- Migration 063 (notifications + digest queue) if not pre-existing
- `FeedbackTriage`, `FeedbackHealth`, `MyFeedback`, `FeedbackDetail`, `NotificationPreferences` pages
- `NotificationBell` in header
- Wire `notification_service.py` to SMTP (digest queue, 30m flush cron)
- Close RM-022 in `docs/roadmap.md` via commit message

**RM-021 CC prompts** — draft AFTER RM-022 Phase 1 ships. RM-021 benefits from having the feedback surface live (library misclassifications flow into universal feedback).

**Pricing engine Prompts 3–7** (from prior handoff, still authoritative):
- Prompt 3 — `POST /api/quotes/calculate-v2` endpoint + write-guard triggers
- Prompt 4 — Frontend `src/lib/pricing_v2.js` + Vitest harness
- Prompt 5 — Migration 051 backfill
- Prompt 6 — IntakeFormV3 + ComponentCard + JobDetail components tab + QuoteCalc v2
- Prompt 7 — Migration 053 (drop deprecated scalar cols)

**RM-003 P0** — QBO import sync audit (unchanged from prior).

## Deferred / non-blocking

- PyMuPDF reliability measurement in Phase 1 telemetry → triggers CloudConvert fallback decision at Phase 2.5 if `needs_manual_preview` rate > 15%
- Folder upload (ship file-drop first, folder-drop next sprint)
- Duplicate detection in design library (don't block upload, flag in Phase 2)
- AI 30.0 PDF-compat requirement documentation in onboarding
- S10 tax-exempt status (CPA/legal, non-architectural)

## Decisions made with reasoning

- **Scoped `git add docs/specs/...` over stash-pop** for spec archival commit. Honored "only two new files staged" invariant without touching unrelated dirty state. Clean commit landed.
- **Push-block hook honored** — commit and push executed by Logan's hand via `!` prefix in CC, not bypassed via one-shot permission. Matches global CLAUDE.md rule.
- **DesignStudio.jsx restored via `git checkout HEAD --`**, not committed. Restoration reverts to HEAD state; no new code change to commit.
- **Parallel Prompt 3 + RM-022 Phase 1a sequencing** — confirmed viable because different files/code paths, but MUST be in separate CC sessions to avoid context blowup.
- **FastAPI BackgroundTasks for Phase 1 async work** — deferred Celery/RQ upgrade until measured CPU pressure on Railway.
- **Opus 4.7 locked for Phase 2 vision classification** — cost ceiling $50/mo at ASF volume.
- **Sticky session defaults with 4h expiry + dismissible chip** over per-file modal — explicitly rejected per-file modal as "terrible" from prior chats.

## Files recently changed

- `docs/specs/rm-021-design-library-bulk-upload.md` (new, 850 lines, in `a15b8b2`)
- `docs/specs/rm-022-universal-feedback-system.md` (new, 941 lines, in `a15b8b2`)
- `src/pages/DesignStudio.jsx` — restored from HEAD, working tree now clean minus `.DS_Store` noise. No new commit.

Repo state:
- `asf-graphics-app` main at `a15b8b2`
- Canonical Mac clone: `~/Documents/GitHub/asf-graphics-app`

## Frustration signals

- "It should be in my downloads folder" — I had assumed file downloads were accessible to CC when they aren't. Next chat: when presenting files from Claude.ai chat, immediately clarify that CC cannot read them until they're moved onto disk, and walk through the manual `mv` step explicitly. Don't assume file-download context carries.
- Push-block hook was hit mid-commit. Recovery was clean, but the hook's existence wasn't pre-loaded into this chat's context. Next chat: before giving any CC prompt that ends with `git push`, explicitly call out that push is user-run via `!` prefix.
- DesignStudio.jsx dirty state surfaced unexpectedly. Next chat: always pre-check `git status` before any repo operation, don't assume a "clean tree" state.

## User Preferences changes pending

Queued for next Mastery Lab chat (alongside four items already there):

> **Handoff-artifact surface discipline.** Always label destination surface explicitly: Claude.ai-web, Claude.ai-desktop, Claude Code CLI, or Claude in Chrome. "New chat" is ambiguous across surfaces with different tool availability (conversation_search, project_knowledge_search, MCP connectors, file I/O all vary).

> **File-delivery discipline between Claude.ai and CC.** When presenting artifact files in Claude.ai chat, explicitly state: "CC cannot read Claude.ai artifact downloads. You must manually move the file to disk before CC can access it." Don't assume the download is end-to-end.

> **Pre-check `git status` before every repo operation.** A "clean tree" assumption is a documented failure mode. Every prompt that touches `git add/commit/push` starts with `git fetch && git status` and a stop-if-dirty gate.

> **Push-block hook awareness.** Before generating any CC prompt that ends with `git push`, flag that the push will hit the hook and must be run by Logan via `!` prefix. Never assume CC can push — it cannot, and the hook will block it correctly.

## Environment state

- Canonical Mac clone: `~/Documents/GitHub/asf-graphics-app`
- Claudious clone: `~/Documents/GitHub/Claudious`
- Python 3.9 local (with `__future__` shim); Python 3.11+ on Railway
- Pydantic 2.12.5
- Supabase MCP available for `apply_migration`
- Push to main is hook/permission-blocked — use `!` prefix for user-run push
- `.claude/settings.json` untracked through 2026-04-29 per mastery Day-7 trial

## Next chat first actions

1. Read this handoff.
2. `project_knowledge_search` on `"rm-022 spec"` to confirm `docs/specs/rm-022-universal-feedback-system.md` is visible in project knowledge (may lag a few hours after commit — OK to proceed with repo path if not).
3. Verify Mac clone state before anything else:
   - `cd ~/Documents/GitHub/asf-graphics-app && git fetch && git status`
   - Expect: on main, clean working tree, up to date with `a15b8b2` or newer
   - If dirty: stop and diagnose before continuing
4. Open a fresh CC session (do NOT reuse a session running pricing engine work).
5. Paste `cc-prompt-1a-rm022-schema-backend.md` contents into CC.
6. After CC creates the migration files + backend code, STOP. Do not let CC apply migrations.
7. Apply migrations 058–062 via Supabase MCP from this Claude.ai chat (`apply_migration`), one at a time, verify `rowsecurity=true` after each via `execute_sql`.
8. Once migrations applied, let CC commit the code. Push blocked by hook — Logan runs push via `!` prefix.
9. Smoke test backend: curl `/api/feedback/health` with admin token, verify 200.
10. Queue Prompt 1b for next session.

## Context carryover for memory retrieval

Full spec rationale lives in `docs/specs/rm-022-universal-feedback-system.md` (941 lines). Search queries that surface design context:
- `"universal feedback system gaps library bulk upload"` → rounds 1–4 architectural reasoning
- `"40 gaps RLS rollback abuse lifecycle feedback"` → Class B/C/D/E sweep
- `"peer privacy RLS hard rule workflow gates visibility"` → the one hard-block exception
- `"client_uuid dedup offline queue feedback"` → offline-safe submission pattern
- `"feedback health dashboard three-bucket resolution M&A"` → admin dashboard + export format

Commit SHA for specs: `a15b8b2` (both files in single commit).

---

**End of handoff.**

<!-- PROMOTE TO CLAUDIOUS:
- Handoff-artifact surface discipline: label destination surface (Claude.ai-web, Claude.ai-desktop, Claude Code CLI, Claude in Chrome). "New chat" is ambiguous.
- File-delivery discipline between Claude.ai and CC: Claude.ai artifact downloads are not visible to CC until manually moved to disk.
- Pre-check `git status` before every repo operation — "clean tree" assumption is a documented failure mode.
- Push-block hook awareness: before any CC prompt ending in git push, flag that user must run push via `!` prefix.
- Scoped `git add <path>` over stash-pop when committing into a dirty tree — honors single-invariant commit without touching unrelated state.
- Async spec delivery via download in Claude.ai chat: confirm user has file in downloads BEFORE writing the CC archive prompt; don't assume end-to-end file flow.
- DesignStudio.jsx pattern: when a deletion surfaces with no commit graph evidence, restore via `git checkout HEAD -- <path>` without committing — it's a revert, not a change.
-->
