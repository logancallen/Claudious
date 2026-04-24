# Handoff — 2026-04-24 PM (ASF Prompt 6a SHIPPED, 6b ready)

**Recommended next-chat title:** `2026-04-24 — ASF — Prompt 6b — Save path + JobDetail components tab`

## Current focus

Prompt 6a shipped commit `88458cc`. IntakeFormV3 shell + ComponentCard + live-preview wired against backend `POST /api/quotes/calculate-v2`. Save button renders disabled. Next session: 6b — save path wrapped in `public.set_engine_context('true')` GUC transaction + JobDetail components tab (read view).

## What shipped 2026-04-24 PM (Prompt 6a)

- `88458cc` — feat(intake): IntakeFormV3 shell + ComponentCard + live-preview (6a)
  - `src/components/intake/ComponentCard.jsx` (new) — props contract locked at top of file as JSDoc block; binding for 6b/6c/6d
  - `src/pages/IntakeFormV3.jsx` (new) at `/intake/v3` — additive, IntakeFormV2 untouched
  - `src/App.jsx` — route registration at L12 + L534
  - `src/lib/pricing_v2_constants.js` (new) — canonical enum exports: COMPONENT_TYPE_VALUES, DESIGN_SOURCE_VALUES, INSTALL_TYPE_VALUES, PRICING_TIER_VALUES, MATERIAL_ROLE_VALUES (scope expansion accepted — spec required single canonical export, none existed)
  - `docs/codebase-state.md` + `docs/learnings.md` — synchronized
  - Prior commit: `3195451` (docs session-close from Prompt 5)

## Verification — all gates green

- Grep C1: 4/4 + 0-hit save-path guard ✅
- Vitest: 163 pass, 5 pre-existing GeometryEngine fails unchanged
- Build: 273ms clean, no new warnings from 6a files
- Working tree clean, ahead of origin by 1 (Logan pushes)

## Engine-authoritative pattern held

Backend `POST /api/quotes/calculate-v2` = source of truth on save. Frontend `pricing_v2.js` = read-side live-preview only. Debounced 300ms + AbortController + runToken guard. No frontend compute-and-display-as-total.

## Deviations from 6a spec (all accepted)

1. Field names use engine wire shape: `width_inches`, `height_inches`, `component_type`, `label` (NOT spec's `width_in`, `height_in`, `product_type`, `zone_count`). Engine wins. Lock in 6b props audit.
2. `masonry_upcharge` rendered inside Install collapse per ComponentInstall wire shape, not on component root.
3. Lift fields (rental, delivery, markup) NOT on ComponentCard — belong on JobPricingContext per engine. Surface in 6b or 6c.
4. Inline hex → Tailwind classes (`bg-[#1D1D1F]`, `bg-yellow-100`, etc.) per `.claude/rules/frontend.md` Tailwind-only mandate.
5. Save-button feedback uses native `alert()` — no toast primitive in repo. Replace with toast in 6c when QuoteCalc v2 rewrite happens.
6. asf-ux-design evaluation engine NOT invoked — skill not loaded in 6a session. Load explicitly at 6b start.

## Row 1 UUID locked for smoke + 6b dev fixture

`cdba13e5-5def-44f2-97c5-3c949d20fe9d` — `[TEST] WFHS Press Box Wraps` — 3 components, quote phase, mixed design_sources (library_reuse + new_composition + library_modify), district_po + po_required.

## Manual smoke checklist (post-push, pending Logan)

1. `/intake/v3?clone=cdba13e5-5def-44f2-97c5-3c949d20fe9d`
2. Confirm 3 ComponentCards render
3. Confirm preview panel shows total (backend round-trip)
4. Edit quantity on Component 1 — preview updates ~300ms
5. Save button disabled + tooltip on hover
6. No console errors
7. No blue anywhere

## Pending items

- **Push `88458cc` to origin/main on asf-graphics-app.**
- **Run smoke checklist 1-7** on Logan's side.
- **Prompt 6b** — save path + JobDetail components tab (read view). Wraps DB writes in `public.set_engine_context('true')` GUC transaction to pass migration 063 write-guard triggers. Consumes locked ComponentCard props contract.
- **Prompt 6c** — QuoteCalc v2 rewrite against `pricing_v2.js`. Replace native `alert()` with toast primitive (added to scope).
- **Prompt 6d** — Row 1 smoke: clone → edit → save → read back → engine total matches stored total.
- **Prompt 7** — Migration 053 (drop deprecated scalar cols on `jobs` — `total_cost` removed from scope, never existed per Prompt 5) + jobs-table write-guard triggers + `edit_requests.py` retirement + retire legacy `src/lib/pricing.js` + retire v1 Vitest harness.
- **Prompt 5.5 (proposed, not scheduled)** — `jobs.is_test_data` column + filter audit across all non-admin views + admin toggle. Clears 11 `[TEST]` jobs from Brady/Chanté work queue before first real-job intake. Ship order: before Brady/Chanté real-job use of IntakeFormV3 production path. Filed as RM-XXX pending roadmap-additions commit (staged CC prompt exists — see separate artifact).
- **RM-022 Phase 1b** — feedback capture UI (separate CC session, parallel track).
- **RM-003 P0** — QBO import sync audit (unchanged).

## Living-system discipline change applied 2026-04-24 PM

Session-start protocol for ASF chats must `project_knowledge_search` `docs/roadmap.md` + `docs/codebase-state.md` + `handoff-active-asf.md` BEFORE any inventory/status response. `userMemories` is biographical/preference only — never cited as roadmap authority. `docs/roadmap.md` wins on state conflicts. Pending integration into userPreferences via Mastery Lab session.

Proposed sync mechanisms (not yet built):
1. `scripts/sync-user-memories.sh` — CC reads `docs/roadmap.md` CLOSED, emits `memory_user_edits` batch for stale-memory prune.
2. `scripts/drift-detect.sh` — weekly diff of roadmap vs live schema vs file existence.
3. Sunday Mastery Lab standing agenda — userMemories reconciliation against living docs.

## Environment

- Canonical Mac clone: `~/Documents/GitHub/asf-graphics-app`
- HEAD after push: will be `88458cc`
- Current origin/main before push: `3195451` (Prompt 5 docs close)
- Python 3.9 local, 3.11+ Railway
- Supabase project `spvtwxqbnjdmipbvoyjk`
- 11 `[TEST]`-prefixed jobs live in production DB (no `is_test_data` schema flag yet)
- Push-block hook on main active; Logan pushes manually

## Frustration signals (for next chat)

- Stale-source revolving door: next chat must NOT cite userMemories for roadmap state. Hit `project_knowledge_search` first. This chat surfaced shipped RM-010 and RM-011 as "open" — user flagged it hard.
- Cross-chat paste confusion occurred twice: next chat should self-identify if a paste looks like it belongs to a different project/session and halt before acting.
- CC prompt format directive locked: single fenced block, no surrounding scaffolding. Paste-and-go.

## Known capability gaps flagged (unanswered)

- "Design is live" specifics — ChatGPT Canvas? Figma MCP? Canva MCP? Sora 2?
- GPT-5.5 routing intent — adversarial review? Alt planning? Specific domain?
- Concrete recent example of mis-routing.

Answers pending. Routing matrix incomplete until resolved.

## Next chat first actions

1. Read this handoff.
2. Confirm asf-graphics-app origin/main at `88458cc` via `git ls-remote` or Logan's paste.
3. Confirm smoke checklist pass/fail — if fail, triage before 6b.
4. Load asf-ux-design skill explicitly at session start.
5. Draft Prompt 6b CC prompt against locked ComponentCard props contract. Single fenced block. Paste-and-go format.
6. Do NOT cite userMemories for state. `docs/roadmap.md` + `docs/codebase-state.md` + `docs/learnings.md` + this handoff are authority.
