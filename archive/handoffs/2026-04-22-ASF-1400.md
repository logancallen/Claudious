# Handoff — 2026-04-22 (ASF RM-021 + RM-022 design complete, 40 gaps closed)

**Recommended next-chat title:** `2026-04-22 — ASF — RM-021 + RM-022 Spec Drafting + CC Prompts`

---

## Current focus

Design complete for two linked features:
- **RM-021** — Design Library bulk upload (frictionless drop + async classification + inline client create)
- **RM-022** — Universal feedback/flagging system (platform-wide, any surface, any user)

Both fully specced through **40 gap-closure passes** (up from the 24 in the first-pass handoff). The additional 16 gaps surfaced in Class B/C/D/E sweeps (execution risk, production rollout, adversarial/abuse, lifecycle) and materially change the schema, RLS model, and sequencing.

**IMPORTANT:** This handoff contains the updated gap list but NOT the full architectural reasoning. Next chat should use `conversation_search` on the prior design chat AND the April 22 gap-closure chat to pull full context.

Search queries that will match:
- `universal feedback system gaps library bulk upload`
- `24 gaps universal feedback triage keyboard explain and close`
- `40 gaps RLS rollback abuse lifecycle feedback`

---

## Gaps closed (40 total — delta from prior handoff)

**Gaps 1–24** (prior handoff, still authoritative):
1. Explain-and-close resolution path for false positives
2. MyFeedback personal history
3. PII redaction (client-side pattern mask)
4. Data-vs-code resolution scope rubric
5. Resolution log with rollback
6. Subject-deleted handling (now reworked via Gap 26)
7. (merged into Gap 6)
8. Aging cron — weekly sweep of stale reports
9. Role-based inline-fix permission matrix
10. Offline queue (localStorage)
11. AI model version tracking
12. Dedup + correlation detection (similarity clustering)
13. Feedback type selector (bug/ai_error/data_error/ux/feature_request/idea/question)
14. (merged into Gap 13)
15. Threaded comments for clarification
16. Reporter edit/delete own open reports
17. Follow-up attachments
18. Court Designer canvas-state capture (not DOM)
19. Iframe surface capture (Grimco, QBO cross-origin)
20. Happened-at vs reported-at timestamps
21. Per-user notification preferences
22. Free-form labels beyond AI classification
23. Full-text search + filters
24. Export for M&A due diligence

**Gaps 25–40** (this session, new):

25. **Dropped `report_count` denorm column** — aggregate from `feedback_reporters` on read. Prevents drift.
26. **Dropped `subject_status` from feedback table** — replaced with `subject_exists` computed at read time via JOIN. Subject state belongs on subject table, not frozen snapshot on feedback.
27. **Rollback scripts required for each migration** — inverse DROP block in comment or split 058-apply + 058-verify.
28. **Missing indexes added** — `(status, created_at DESC)`, `(reported_by)`, `(subject_table, subject_id)`, `labels USING gin`.
29. **Phase 1 splits into 3 CC prompts** — (1a) schema+backend, (1b) capture UI, (1c) triage UI+notifications. Single-prompt Phase 1 guarantees partial execution.
30. **RLS mandatory in same migration as table creation** — post-apply verification must confirm `rowsecurity=true` on every new table.
31. **AI columns get CHECK constraint** — `ai_source NOT NULL` implies `ai_model_version` and `ai_confidence` NOT NULL. Phase 2 can't half-populate.
32. **Screenshot storage specified** — R2 `asf-feedback` bucket, presigned upload, 90-day TTL on resolved-item screenshots. PII redaction client-side before upload.
33. **Feedback button visibility tuned down** — bottom-right, 32px, 40% opacity → 100% on hover. No pulse, no badge, no CTA copy.
34. **Resolution notifications batched** — 30-minute digest window for email, individual for in-app. Prevents notification firehose.
35. **Offline queue dedup** — client-side `client_uuid` on every offline report; `ON CONFLICT (client_uuid) DO NOTHING` on insert. Retry-safe.
36. **Deploy ordering explicit** — migrations (MCP) → backend (Railway) → frontend (Netlify). Each step gated on prior.
37. **Peer-privacy RLS hard rule** — Brady and Chanté cannot SELECT each other's feedback. Only `owner`/`admin` sees cross-user. Hard rule, not warn-don't-block.
38. **Export endpoint owner-only** — Logan-only; every export logged to audit_log with user/timestamp/row-count/filters. M&A exports filtered by Logan.
39. **Feedback Health dashboard in Phase 1** — Admin page section with median time-to-resolution (rolling 30d), reports by status, reporter engagement, oldest open. Not deferred.
40. **Three-bucket resolution status for M&A** — `legitimate_open` / `duplicates_of` / `false_positive_documented`. Due diligence exports filter to the clean set. Buyer narrative preserved.

---

## In-flight

None. Design state is complete + hardened.

## Pending confirmations needed from Logan

- **Sticky default upload pattern** — confirm with Chanté: one-client-per-session is her actual rhythm?
- **Phase 1 server-side rasterization of .ai/.psd** — defer to Phase 2? (Recommended: yes)
- **Phase 2 classification: Claude vision API?** (Recommended: yes)
- **Phase 1 deploy as 3 CC prompts vs 1?** (Recommended: 3 — Gap 29)
- **Sequencing — RM-022 before/during/after Prompts 3–7?** (Recommended: **Option 3**, after Prompt 6; pricing engine ships first)
- **Open from prior session** — S10 tax-exempt booster-club-funded jobs (CPA/legal)

## Pending from prior session (still authoritative)

- **Prompt 3** — `POST /api/quotes/calculate-v2` + write-guard triggers (`app.engine_context` GUC)
- **Prompt 4** — Frontend `src/lib/pricing_v2.js` + Vitest harness
- **Prompt 5** — Migration 051 backfill (10 platform-native jobs)
- **Prompt 6** — IntakeFormV3 + ComponentCard + JobDetail components tab + QuoteCalc v2
- **Prompt 7** — Migration 053 (drop deprecated scalar cols) + pricing constants extraction
- **RM-003 P0** — QBO import sync audit

## Decisions made this session

- **Class B/C/D/E gap hunting found 16 material additions** — prior "asymptotic" framing was wrong. The right question was which *class* of gap hadn't been hunted yet, not whether more gaps existed on the same axes.
- **Single-prompt Phase 1 is a known failure mode** — split into 3 sequenced prompts to guard against partial execution.
- **Privacy-between-peers is a hard rule, not warn-don't-block** — the warn-don't-block doctrine applies to workflow gates, not to reading other users' flagged issues about each other. Different category.
- **Denormalized counters and frozen subject snapshots cause silent bit-rot** — schema changed to compute on read.
- **Screenshot TTL (90 days post-resolution)** — storage discipline at scale; prevents silent cost creep.

## Files recently changed

None. Design-only session. Last code commit unchanged:
- `asf-graphics-app` main at `2c9cb03` (Prompt 2 session-close)
- Canonical clone: `~/Documents/GitHub/asf-graphics-app`

## Frustration signals

- "Ensure no more gaps" bar triggered the Class B/C/D/E sweep. Next chat: if Logan asks for gap hunting, go straight to the full 5-class taxonomy, don't stop at plan-integrity gaps.
- Per-file modal workflow explicitly rejected as "terrible."
- Any claim that a plan is complete without explicit class-coverage justification is a regression.

## User Preferences changes pending

None.

## Environment state

- Canonical Mac clone: `~/Documents/GitHub/asf-graphics-app`
- Claudious clone: `~/Documents/GitHub/Claudious`
- Python 3.9 local (with `__future__` shim); Python 3.11+ on Railway
- Pydantic 2.12.5
- No active CC session-scoped allowlists
- `.claude/settings.json` deliberately untracked through 2026-04-29 per mastery Day-7 trial — do not gitignore until verdict.

## Next chat first actions

1. Read this handoff.
2. `conversation_search` on "universal feedback system gaps library bulk upload" for rounds 1–4 architectural reasoning.
3. `conversation_search` on "40 gaps RLS rollback abuse lifecycle feedback" for rounds 5 context (Class B/C/D/E).
4. Confirm the 6 pending questions with Logan before spec drafting.
5. Add RM-021 and RM-022 to `docs/roadmap.md` under P1 FEATURE.
6. Draft formal specs integrating all 40 gaps:
   - `docs/specs/rm-021-design-library-bulk-upload.md`
   - `docs/specs/rm-022-universal-feedback-system.md`
7. Draft 3 sequenced Phase 1 CC prompts (1a schema+backend, 1b capture UI, 1c triage+notifications+Feedback-Health dashboard). Each prompt:
   - Assumption-free read-codebase-first instruction
   - grep verification requirements on every claimed fix
   - "main branch only, no branches"
   - Explicit file-change summary mapping to every item
   - `<!-- PROMOTE TO CLAUDIOUS: ... -->` block for cross-project learnings
   - Roadmap close directive on final commit

## Context carryover for memory retrieval

Full design rationale and rejected alternatives live in the April 22 design chat + the April 22 gap-closure chat. Do not re-derive — search. Key phrases: "universal feedback," "design library bulk upload," "40 gaps," "Class B execution risk," "peer privacy RLS," "feedback health dashboard," "screenshot TTL," "client_uuid dedup," "three-bucket resolution."
