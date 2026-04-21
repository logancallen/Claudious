# Handoff — 2026-04-21 (AM, Components Model Prompt 1 ready to ship)

**Recommended next-chat title:** `2026-04-21 — ASF — Components Model Prompt 1 Execution + Prompt 2 Draft`

---

## Current focus

Synthesis landed (`cf5f91a`). Prompt 1 drafted and ready to run in Claude Code. All three pending recommendations from the prior chat's synthesis confirmed. Next chat's first work: Logan runs Prompt 1 in CC, reports findings (especially QBO diagnostic results), and then Claude drafts Prompt 2 (backend pricing engine + parity harness).

Memory has been pruned to reflect shipped state.

## Completed this session (2026-04-21 AM)

- **Caught and fixed architectural defect in synthesis before commit.** Original §2.4 treated funding as binary (ISD-means-PO, business-means-deposit) and wired phase gates as hard blocks. Logan flagged: schools may be funded by booster clubs, PTAs, grants, sponsors, or business-direct, all on the same client record. Also caught that "PO before Quote→Design advance" was worded as a block — violates core operating rule (warn, don't block).
- **Revised synthesis §2.4 end-to-end:** new `funding_source` job-level field with 8 values (`district_po`, `school_direct`, `booster_club`, `grant_or_sponsor`, `business_direct`, `internal`, `split`, `tbd`). Revised `deposit_mode` enum to 4 values (`po_required`, `deposit_required`, `net_terms`, `none`). Added explicit warn-not-block phase-gate behavior table. 5 worked examples including booster-funded school job and split-funding case.
- **Updated synthesis cross-references:** schema (jobs + clients), §1.2 changes table, §1.4 stencil migration, §2.5 autofill, §3.1 intake form Step 1, §3.9 stencil flow, §6.1 migration 050, §6.2 parity fixtures (added booster scenario as required test), §6.3 Brady test job (now 2 scenarios on same client), Appendix A decision log, final success criteria.
- **Synthesis committed as `cf5f91a`** on asf-graphics-app main. 656 lines. All 6 grep verifications passed. No deprecated enum values remain.
- **Handoff committed as `fe0f63d`** on Claudious main. Prior handoff archived to `archive/handoffs/2026-04-20-2200.md`.
- **All 3 pending recommendations confirmed:**
  - Surfaces Phase 1 — SHIP (migration 047 creates table + seeds; FK in 048).
  - QBO legacy flag — SHIP (migration 052 flags 325 jobs; separate diagnostic for QBO amount display issue Logan raised).
  - Commit #2 stencil+design-library fixes — FOLD into components commit.
- **Memory pruned:** #10 updated to reflect synthesis committed state; #17 updated to reflect post-revision decisions; #20 added (funding_source ≠ client identity, warn-not-block principle).
- **Prompt 1 drafted:** 5 migrations (047-050, 052), full SQL, verification queries, commit strategy (5 separate commits), diagnostic for QBO amounts, learnings update block.

## In-flight items

### Item 1 — Logan to execute Prompt 1 in CC

Prompt 1 file: `cc-prompt-1-migrations-047-052.md`. Re-download from prior chat's outputs and run in CC (asf-graphics-app repo, main branch).

Expected CC runtime: 15-30 min.

Prompt covers:
- Migration 047: `surfaces` reference table + 12 seeds.
- Migration 048: `job_components`, `component_materials`, `component_install` + RLS + FK to surfaces.
- Migration 049: `job_type_templates` + 8 seed rows.
- Migration 050: `clients.default_funding_source` + `clients.default_deposit_mode` + backfill from `client_type` + CHECK constraints after backfill.
- Migration 052: `jobs.is_legacy` column, flag 325 QBO jobs, diagnostic queries reporting QBO amount field state — no backfill.

5 separate commits. All pushed to origin/main.

### Item 2 — QBO amounts display issue (Logan raised mid-session)

Logan reported QBO imported jobs don't display their amounts. Chose diagnose-only approach in Prompt 1's migration 052. Three diagnostic queries:
- Count of legacy jobs with `total` null/zero/populated.
- Count of legacy jobs with `subtotal` null/populated.
- Schema inspection: which QBO-amount columns actually exist on `jobs`.

Based on findings, next step is decided (frontend display fix vs data backfill vs both).

### Item 3 — Prompt 2 to be drafted after Prompt 1 ships clean

Per synthesis §6.4 CC prompt sequence. Requires 047-050, 052 applied and verified.

Prompt 2 scope:
- New file: `backend/services/pricing_engine.py` implementing `calculate_job_quote → aggregate(calculate_component_quote per component)`.
- Parity harness: `tests/pricing_parity_v2.json` + pytest runner.
- 13 parity scenarios per synthesis §6.2 (includes booster-club-funded scenario as required test).
- No frontend, no API endpoint changes.

## Pending items (queued, not blocking current work)

- **Salvaged flooring docs need commit** — 3 files in OneDrive clone.
- **OneDrive clone + Projects clone cleanup** after flooring salvage.
- **Prompt A (QBO missing prices)** — becomes concrete after migration 052 diagnostic.
- **Prompt B (Quick Estimate tool for Brady)** — queued post-Prompt A.
- **Phase 1 Step 3 — Service worker + install prompt + update prompt** — queued.
- **2FA manual verification** — pending Logan.
- **Learnings capture** to add to `docs/learnings.md`:
  - Library presence ≠ reuse decision — operator question required (HIGH).
  - Design fee logic is work-driven, not client-type-driven (HIGH).
  - Deposit and design fee are separable concerns (HIGH).
  - Funding source ≠ client identity — track per job, client defaults as seeds (HIGH, new this session).
  - Architectural defects caught pre-commit are cheap; post-commit are expensive — 20-min synthesis revision prevented ~30-hr month-3 rework (HIGH, new this session).
  - Warn-not-block is a real operating rule, not a suggestion (HIGH, new this session).
  - Deterministic autofill gets 80% of value vs learning autofill (MEDIUM).
  - Hybrid install minimum keeps math invisible to operator (MEDIUM).
  - Handoff staleness compounds without active pruning (HIGH, cross-project).

## Frustration signals (avoid in next chat)

- **Don't paste file contents into CC prompts — use file-path references.** File-path pattern worked cleanly in this session.
- **Don't bury execution instructions in long responses.** When the user is executing a sequence, short directive answers beat framework-structured responses.
- **Don't assume userMemories entries are current without checking.** The "always apply migrations manually" memory was stale; current practice is CC-apply standard.
- Don't assume library presence = library reuse.
- Don't assume client type drives design fee or funding source.
- Don't route synthesis work to CC.
- Don't recommend new chat without preparing handoff first.
- Don't pursue in-person Brady/Chanté workflow study.
- Don't propose speculative infrastructure.
- Don't issue CC prompts without ensuring CC can finish in one sitting.
- Don't ask Logan to substitute placeholders — build fill-in-the-blank or file-path scripts.
- Don't accept "already correct" without grep proof.
- Don't over-hedge on recommendations — 70%+ confidence = take a position.
- Don't batch multiple sequential commands.
- Don't respond to tactical questions with Classify/Best/Risks/Execution/Tracking framework.
- Don't apologize over small mistakes.

## User Preferences changes pending

None from this session.

## Decisions made this session

- Synthesis §2.4 revised: `funding_source` (8 values) + `deposit_mode` (4 values) as two decoupled job-level fields.
- All deposit-related phase gates warn, never block.
- Surfaces as first-class Phase 1 confirmed.
- QBO legacy jobs flagged not migrated, diagnostic query included in migration 052.
- Commit #2 stencil+design-library fixes folded into components commit sequence.
- Prompt 1 uses 5 separate commits (not one) for easier revert.
- Prompt 1 applies migrations via Supabase MCP `apply_migration` (CC-apply standard, overrides stale manual-only memory).
- QBO amounts: diagnose-only in migration 052. No data modification beyond legacy flag.

## Files committed this session

- `docs/architecture/components-model-synthesis-2026-04-20.md` (656 lines, commit `cf5f91a` on asf-graphics-app main).
- `canonical/handoff-active.md` + `archive/handoffs/2026-04-20-2200.md` (commit `fe0f63d` on Claudious main).

## Files NOT changed this session

- No migrations applied yet (Prompt 1 does this in next chat).
- No code changes. No backend / frontend / API edits.

## What was NOT discussed / explicitly out-of-scope

- Flooring platform architecture alignment — deferred.
- Courtside Pro integration — on hold, separate Supabase project.
- Learning autofill Phase 2 — deferred 6+ months.
- BuyBoard Proposal 816-26 — unaffected, June 11 deadline.
- PVO `.ai` template subscription — needed before `fleet_wrap_single` PVO pre-populate.
- BuyBoard graphics coverage investigation — not updated.
- QBO production keys — still pending Intuit approval.
- Hudson Digital Graphics competitive tracking — no action.
- Components refactor rollback strategy — not formally designed. Consider before Prompt 3 (engine swap).
- Pre-mortem on components refactor — not run. Should run before feature flag flips for Brady (Prompt 9-ish).

## Context health notes for next chat

- This chat used ~70% context at handoff. Prompt 2 drafting may push close — monitor.
- Prompt 1 output file at `/mnt/user-data/outputs/cc-prompt-1-migrations-047-052.md`. Must be re-downloaded and attached to next chat.
- Synthesis at `docs/architecture/components-model-synthesis-2026-04-20.md` commit `cf5f91a` is source of truth for all remaining prompts.

## Next chat first actions (execute in order)

1. **Read this handoff first.** Do not respond to anything else before reading.
2. **Confirm Prompt 1 file is available.** Logan attaches `cc-prompt-1-migrations-047-052.md` or confirms he has it locally.
3. **Logan runs Prompt 1 in Claude Code** (asf-graphics-app repo, main branch). Expected 15-30 min.
4. **CC reports:** 5 commit SHAs, verification query results, QBO diagnostic findings, any deviations.
5. **Claude reviews CC report.** Verify all 5 migrations applied cleanly, row counts match expected (12 surfaces, 3 component tables, 8 templates, 0 null funding_source/deposit_mode, ~325 legacy jobs). Interpret QBO diagnostic.
6. **Decide QBO follow-up based on diagnostic:**
   - Amounts in `total`/`subtotal` → frontend display fix (small prompt).
   - Amounts in different column (e.g., `qbo_total`) → data backfill prompt.
   - Amounts not present anywhere → re-sync from QBO required.
7. **Draft Prompt 2** (backend pricing engine + parity harness + 13 parity scenarios).
8. **Run memory maintenance** before chat ends.

---

## Research outputs (still available for future reference)

- **W1:** Industry ERP data model analysis. Inline in prior chat, not committed.
- **W2:** Field Worker Intake Form UX patterns. Upload file, not committed.
- **W3:** Pricing engine audit. Committed at `docs/audits/pricing-engine-audit-2026-04-20.md`, commit `8a744cc`.

## END OF HANDOFF
