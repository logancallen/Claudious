# Handoff — 2026-04-20 (PM session 3, Research Synthesis Complete)

**Recommended next-chat title:** `2026-04-21 — ASF — Components Model Implementation Prompt 1 (Migrations 047-052)`

---

## Current focus

All three research workstreams (W1 industry ERP data models, W2 field-worker UX patterns, W3 pricing engine audit) completed and synthesized into a single architectural spec: `docs/architecture/components-model-synthesis-2026-04-20.md`. Synthesis locked in 7 architectural decisions from Logan and carries 3 Claude-recommended positions awaiting explicit confirmation. Next step is auditing the CC commit prompt, then kicking off Prompt 1 (migration suite 047-050, 052) when Logan is ready.

The component-model architectural pivot remains the target. Path A (research first, components model builds directly, interim stencil/design-library fixes folded in) confirmed. Volume discount deferred entirely from Phase 1 per Logan's decision — no bracket set. Design fee logic pivoted mid-chat from client-type-driven to design_source-driven-with-operator-question after Logan correctly identified that library presence doesn't imply library reuse.

## Completed this session

- **W2 research results received, read in full, integrated.** Field-worker UX patterns document. Key findings: hybrid template-seed + edit-after is the dominant pattern, field order Client → Location → Job Type → Components → Notes, progressive disclosure by job type (not mode toggle), ≤8-10 templates max, 56×56dp touch targets, interruption tolerance via auto-save, notes field last-not-first.
- **W3 research results received (Claude Code audit, 1058 lines, commit `8a744cc`).** 20 primary pricing rules catalogued, ASCII flow diagram, 18 product types analyzed (0 per-product engine branches, 5 UI-level gates), 17 frontend/backend duplication reconciliation risks, 22 single-product-locked rules with per-component adjustments, 20 broken/suspicious items for review. Notable findings: install cost mismatch between frontend (`sqft * 1.5`) and backend (`sqft * rate`), $75-minimum order-of-ops divergence between single and multi engines, single-engine skips `validate_material_selection`, Friends & Family has no backend engine, sync endpoint only copies design_fees not full rate card.
- **Synthesis document drafted (579 lines).** 6 sections + 4 appendices. Covers data model (jobs + job_components + component_materials + component_install + job_type_templates + surfaces + clients.default_deposit_mode), pricing engine refactor with rule-by-rule disposition, intake form spec (4 steps, 8 templates, conditional fields, Design Source UI, interruption tolerance), surface as first-class entity Phase 1 scope, migration strategy, build sequencing with 10-prompt CC sequence.
- **7 architectural decisions locked this session with Logan:**
  1. Install minimum: hybrid (mount per-component, wrap/flat per-job $150 combined).
  2. Volume discount: DEFERRED entirely from Phase 1. No bracket set. Engine computes without volume discount layer; can add later as one function wrapping material totals.
  3. Design fee: driven by `design_source` (what work is being done), not client type.
  4. Design source: 5-option radio with smart default (library check → pre-select `library_reuse`, operator must tap-confirm). Options: library_reuse, library_modify, new_composition, new_logo, client_supplied. Each maps to derived design_fee_tier with operator override capability.
  5. Deposit mode: NEW `deposit_mode` field on `jobs` (po_required / design_fee_as_deposit / none_internal). Separate from design fee. `clients.default_deposit_mode` seeds new jobs; operator-overridable at intake.
  6. Autofill Phase 1: deterministic only. Library check + client type + template + PVO lookup + last-job-match pattern autofill. No ML/learning layer.
  7. Autofill Phase 2: learning inference deferred 6+ months pending training data accumulation (current 10 jobs + legacy QBO insufficient).
- **3 Claude recommendations pending Logan confirmation:**
  - Surface as first-class entity, Phase 1 scope (Claude 75% confidence).
  - 325 QBO legacy jobs not migrated, flagged `is_legacy=true` (Claude 85% confidence).
  - Commit #2 stencil+design-library fixes folded into components commit rather than shipping interim (Claude 70% confidence).
- **Memory maintenance issue logged as systemic concern.** Handoffs carry forward items that have shipped. Root cause: no pruning step in handoff generation. Fix: every handoff includes "What's no longer true" section + actual `memory_user_edits` calls before end of chat. This chat's handoff executes that discipline.

## In-flight items

### Item 1 — CC prompt audit BEFORE Prompt 1 executes

**Next chat opens by auditing the CC synthesis commit prompt** (`/mnt/user-data/outputs/cc-prompt-commit-synthesis.md`). Specifically, verify:

1. Path is correct (`docs/architecture/components-model-synthesis-2026-04-20.md`).
2. Preflight instructions match known-acceptable state (docs/codebase-state.md modified is expected).
3. Verification grep counts are achievable with the as-written synthesis.
4. Commit message is accurate.
5. Constraints are complete (no branches, no hook bypass, no cascading edits).
6. Self-report suppression instruction is present.

If audit passes → Logan runs the CC prompt in Windows CC. Commit SHA returned.

If audit flags issues → fix before running. Do not let a minor prompt defect create another failed-run situation.

### Item 2 — Three pending confirmations (blocks Prompt 1 ship)

Logan to confirm or reverse the three Claude-recommended positions:

- Surface as first-class entity, Phase 1 — ship or defer to Phase 2?
- QBO legacy jobs not migrated — correct or migrate mechanically?
- Commit #2 fold-in — fold into components commit or ship 9 non-catalog fixes interim?

If all three confirm as-recommended → Prompt 1 ships as designed.

If any reverses → synthesis document needs a minor revision before Prompt 1 writes migrations (e.g., no surface reverse means migration 047 is dropped).

### Item 3 — Prompt 1 (migration suite 047-050, 052) not yet drafted

Logan to approve that Prompt 1 should be drafted in the next chat as the first implementation step after synthesis is committed.

Prompt 1 will:
- Create `surfaces` reference table (12-15 seeds per §4.2).
- Create `job_components`, `component_materials`, `component_install` tables (per §1.1).
- Create `job_type_templates` + seed 8 templates (per §3.2).
- Add `clients.default_deposit_mode` column + backfill from existing data.
- Flag 325 QBO jobs `is_legacy=true`.
- No code changes. Migration files only.

Subsequent prompts (2-10) draft as each predecessor ships cleanly.

## Pending items (queued, not blocking current work)

- **Salvaged flooring docs still need to be committed.** The 3 files (`docs/flooring-schema.md`, `docs/flooring-scope.md`, `prompt-4.7a-job-centric-foundation.md`) remain in the OneDrive clone at `C:\Users\logan\OneDrive\Documents\GitHub\asf-graphics-app`. Salvage script preserved in prior handoff. Run after confirming flooring migration state (`Get-ChildItem supabase\migrations -Filter "*flooring*"`).
- **OneDrive clone + Projects clone cleanup** — after flooring salvage. Nuke both after verifying nothing unique.
- **Prompt A (QBO imported jobs missing prices) — queued post-components-ship.**
- **Prompt B (Quick Estimate tool for Brady) — queued post-Prompt A.**
- **Phase 1 Step 3 — Service worker + install prompt + update prompt — queued.**
- **2FA manual verification — pending Logan.**
- **Learnings capture** (should be written to `docs/learnings.md` in asf-graphics-app at some point):
  - Library presence ≠ reuse decision — operator question required, not inference (HIGH, design pattern learning).
  - Design fee logic is work-driven, not client-type-driven (HIGH, ASF-specific).
  - Deposit and design fee are separable concerns; client type governs deposit mode, work type governs design fee (HIGH, ASF-specific).
  - Deterministic autofill gets 80% of value vs learning autofill; ship Phase 1 deterministic before Phase 2 learning (MEDIUM, cross-project).
  - Hybrid install minimum (mount per-component, wrap/flat per-job) keeps math invisible to operator (MEDIUM, ASF-specific).
  - Components-model engine rewrite should preserve JSON fixture harness pattern from substrate work (MEDIUM, cross-project).
  - Handoff staleness compounds: items marked "pending" resurface after completion because no pruning step exists (HIGH, cross-project).
- **Backend normalization shim removal** (jobs.py:545, emails.py:539, auto_categorizer.py:24, material_advisor.py:226-227, import_qbo.py) — dissolves in components refactor.

## Frustration signals (avoid in next chat)

- **Don't assume library presence = library reuse** — Logan caught this. System must ask operator explicitly.
- **Don't assume client type drives design fee** — Logan caught this. Work type (design_source) drives it.
- **Don't route synthesis work to Claude Code** — CC is for codebase operations, not cross-document architectural reasoning. I do synthesis, CC commits.
- **Don't recommend starting a new chat without preparing handoff first** — rule from prior sessions.
- **Don't pursue in-person Brady/Chanté workflow study** — they get annoyed when Logan tries to interview them.
- **Don't propose speculative infrastructure** — volume discount should NOT have a reserved JSONB column. If not shipping, don't reserve schema.
- **Don't issue Claude Code prompts mid-flow without ensuring CC can finish in one sitting** — warn Logan about expected CC runtime.
- **Don't ask Logan to substitute placeholders in raw URLs or commands** — build fill-in-the-blank scripts.
- **Don't accept "already correct" without grep proof** — persistent CC failure mode.
- **Don't over-hedge on recommendations** — 70%+ confidence = take a position.
- **Don't batch multiple sequential commands** — one step at a time on dependent work.
- **Don't respond to tactical questions with Classify/Best/Risks/Execution/Tracking framework** — reserve that for strategic decisions.
- **Don't apologize over small mistakes** — own it, fix it, move on. No self-abasement.

## User Preferences changes pending

None from this session.

**Candidate (not proposed yet):** Explicit rule about architectural inference — "When user states a business rule, parse it for edge cases before accepting. Example: 'design fee free for schools' → check: what about reused designs for businesses? Don't accept binary rules silently."

## New findings (this session)

- **Current engine is 1-level multi-zone, not components** — reconfirmed via W3 §5. Multi-zone treats job as "one product chopped into material pieces," not "job composed of N distinct components each with full pricing stack." Components refactor is a genuine architectural change, not a scope extension of existing multi-zone.
- **W3 surfaced an engine duplication bug: frontend install cost uses `sqft * 1.5`, backend uses `sqft * rate`** — means margin badge in intake doesn't match backend-computed margin. §6.1 in W3 audit. Gets fixed in components engine rewrite.
- **Design Library is a structurally under-utilized asset** — designed as a passive storage but should drive intake autofill via client+product match. Components model activates it as a decision input for `design_source` default.
- **Deposit ≠ design fee** — Logan's clarification revealed these are separate concerns. ISDs have no deposit (PO gates phase advance); businesses have deposit (design fee collected at Quote phase). New `deposit_mode` field on jobs captures this correctly.
- **Operator tap-confirm on library match** is the discipline that prevents silent inference bugs. Even when system knows the answer, asking the operator forces the decision to be auditable.

## Files committed (this session)

- `docs/architecture/components-model-synthesis-2026-04-20.md` (synthesis, 656 lines, commit `cf5f91a` on 2026-04-20 evening). Revised mid-audit in next chat to add `funding_source` field and warn-not-block deposit gating. Final version is what landed.

## Decisions made

- Target architecture: components model (`job → job_components → [component_materials, component_install]`) with `job_type_templates` seeds + `surfaces` reference table + new `deposit_mode` on jobs + `default_deposit_mode` on clients.
- Install minimum hybrid (mount per-component, wrap/flat combined per-job).
- Volume discount deferred entirely from Phase 1.
- Design fee = function of `design_source` not client type.
- 5-option design_source radio with library-check smart default requiring operator tap-confirm.
- New `deposit_mode` field separates deposit logic from design fee.
- Autofill Phase 1 deterministic only. Phase 2 learning deferred 6+ months.
- Surfaces Phase 1 (Claude recommendation, pending Logan final confirm).
- 325 QBO legacy jobs flagged not migrated (Claude recommendation, pending Logan final confirm).
- Commit #2 fold into components commit (Claude recommendation, pending Logan final confirm).
- Synthesis commits to `docs/architecture/`, not `docs/research/` or `docs/audits/` — this is architectural spec, a new class.
- Memory maintenance issue logged as systemic problem requiring active pruning at every handoff.

## Files NOT changed this session

- No code commits.
- No migrations.
- No edits in any repo clone.
- Synthesis file drafted in `/mnt/user-data/outputs/` awaiting CC commit.

## What was NOT discussed / explicitly out-of-scope

Flagged for future sessions, not blocking current work:

- **Flooring platform architecture** — whether components model extends to flooring or flooring gets a separate platform. Per Logan's clarification, court designer lives in asf-graphics-app for now; no separate flooring site. The salvaged flooring docs (`flooring-schema.md`, `flooring-scope.md`) remain planning artifacts, not current build plans. Architectural alignment decision deferred to future strategic session.
- **Courtside Pro integration** — separate Supabase project (ID `vcxtnzmavjwzmrataegl`), no touch this refactor. Post-sale venture, on hold.
- **Learning autofill design** — Phase 2 system. Deferred 6+ months. Approach: weighted inference from aggregate history per client + product signature. Not designed yet.
- **BuyBoard Proposal 816-26 deliverables** — unaffected by refactor. Logan-only tasks queued (Gmail sends, ISD reference verification, Assumed Name Certificate filing, electronic submission at buyboard.com/vendor). Deadline June 11, 2026.
- **PVO `.ai` template subscription call** — Logan needs to call 888-843-1325 before purchasing. Negotiate credit/prorate against existing WrapUP subscription. Confirm Chanté's login. Not blocking components work but needed before `fleet_wrap_single` template can pre-populate from PVO data.
- **BuyBoard graphics coverage investigation** — BuyBoard Contract 737-24 covers flooring only. Graphics investigation status not updated this session.
- **QBO production keys** — Still pending Intuit approval. Post-approval: copy Production Client ID + Secret to Railway, add redirect URI, authorize, import customers.
- **Hudson Digital Graphics competitive tracking** — noted from memory as missed competitor with full product overlap. No action this session.
- **2026 showcase year framing for sale valuation** — discussed briefly as context but not a driver of current decisions. Showcase year depends on clean 2025 tax filings (extension, September-October 2026). Components model shipping soon enough to generate 12-18 months of data before showcase matters.
- **Strategic flooring vs graphics integration** — flooring-schema/scope docs propose flooring as same-platform expansion; Logan's memory frames flooring as separate. Incompatible strategies. Deferred to future strategic session.
- **The "what could go wrong" pre-mortem on components refactor** — not run. Should run before Prompt 1 ships.
- **Rollback strategy if components refactor fails mid-build** — not designed. Feature flag pattern mitigates but doesn't replace a real rollback plan.

## Context health notes for next chat

- This chat used ~92% context by end. Continue into new chat; do not iterate further here.
- Synthesis document at `/mnt/user-data/outputs/components-model-synthesis-2026-04-20.md` is the source of truth. CC commits it when prompt runs.
- CC prompt at `/mnt/user-data/outputs/cc-prompt-commit-synthesis.md` awaits audit + run.
- Three research documents used as source: W1 inline in prior chat message, W2 uploaded as file (`Field_Worker_Intake_Form_UX__Multi-Component_Job_Entry_Patterns.md`), W3 committed to repo (`docs/audits/pricing-engine-audit-2026-04-20.md`, commit `8a744cc`). W1 and W2 NOT in the repo. W3 is.

## Next chat first actions (execute in order)

1. **Read this handoff first.** Do not respond to anything else before reading.
2. **Audit the CC synthesis commit prompt.** File at `/mnt/user-data/outputs/cc-prompt-commit-synthesis.md`. Verify path correctness, preflight instructions, grep counts, commit message, constraints, self-report suppression. Report audit findings to Logan.
3. **If audit passes:** Logan runs CC prompt. Confirm synthesis committed (commit SHA in response). Update prior `canonical/handoff-active.md` to reference the committed file.
4. **If audit fails:** fix the prompt, re-verify, then Logan runs it.
5. **Ask Logan to confirm 3 pending recommendations:**
   - Surface as first-class Phase 1 — confirm or reverse?
   - QBO legacy not migrated — confirm or reverse?
   - Commit #2 fold into components commit — confirm or reverse?
6. **If all three confirm:** draft Prompt 1 (migration suite 047-050, 052).
7. **If any reverse:** revise synthesis accordingly, re-commit via CC prompt, then draft Prompt 1.
8. **Draft Prompt 1** — assumption-free, reads codebase state, creates migration files only, commits, pushes, reports.
9. **Execute memory maintenance** — review current `userMemories` for items that have shipped and strike them. Specifically audit for:
   - Handoff references to items this chat has resolved.
   - Old "pending" items that are now closed.
   - Stale references to platform state.
10. **Ask Logan about flooring docs salvage status** — did the OneDrive cleanup happen?

---

## Research outputs to preserve for future reference

All three research documents captured in this session. Should be accessible from next chat:

- **W1:** Industry ERP data model analysis (Cyrious, ShopVox, SignTracker, EstiMate, PrintSmith Vision, CoreBridge). Not committed to repo. Inline in prior chat messages. Logan may save to `docs/research/W1-industry-erp-data-models.md` per original handoff plan.
- **W2:** Field Worker Intake Form UX patterns. Uploaded file: `Field_Worker_Intake_Form_UX__Multi-Component_Job_Entry_Patterns.md`. Not committed to repo. Logan may save to `docs/research/W2-ux-trades-intake-patterns.md` per original handoff plan.
- **W3:** Pricing engine audit. Committed to repo at `docs/audits/pricing-engine-audit-2026-04-20.md`, commit `8a744cc`.

## END OF HANDOFF
