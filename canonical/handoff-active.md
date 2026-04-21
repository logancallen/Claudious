# Handoff — 2026-04-20 (PM session 2, Windows PC transition)

**Recommended next-chat title:** `2026-04-21 — ASF — Research Synthesis + Components Model Design`

---

## Current focus

Three research workstreams in flight to design a bulletproof components-based job model for ASF Graphics. Commit #2 (stencil intake + design library fixes) was paused mid-build on Mac when CC took too long to investigate; abandoned cleanly with no destructive changes. Logan switched to Windows PC and resolved a 3-clone repo situation. Foundational flooring docs salvaged from OneDrive clone before deletion.

The architectural pivot: discovered through this session that the current `product_type` enum field is structurally insufficient — real jobs (especially press box installs) involve multiple materials applied to multiple surfaces. A press box wrap might combine vinyl on tin metal sides + window perf on the front + dimensional letters on Starboard. Single-product-per-job collapses this and silently breaks pricing, material orders, and labor estimation.

Decision made: target architecture is a **components model** (job → 1-N components, each with material + surface + dimensions + install difficulty + ancillary equipment). Logan validated this is bill-of-materials thinking and aligns with how the work actually is. But components model build is 9-10 working days of focused work; Brady needs the platform sooner. Therefore: research first to design it correctly, then ship. During research week, Brady continues using current platform under the broken single-product model. 5-10 jobs of imperfect data are recoverable; building wrong architecture is not.

## Completed this session

- **Architectural decision: components model is target architecture.** Single-product enum is insufficient for multi-material jobs. Documented bill-of-materials reasoning, three implementation paths (Path A = ship single-product fix now then build components in parallel, Path B = ship components in commit #2 with 5-7 day slip, Path C = empty-table-for-future antipattern), recommended Path A with research-first sequencing.
- **Catalog simplification proposal:** drafted 14-entry catalog with 5 categories killing the location-as-product trap (`press_box_wrap`, `wall_wrap`, `bus_wrap`, `trailer_wrap`, `boat_wrap` all collapsed). Logan caught additional issue: even the simplified catalog still treats install context as product. Catalog work fully deferred pending research.
- **Per-row migration mapping for 11 jobs** drafted with Logan's confirmations (J-7 → other, J-13 → gym_stencil, J-21 → building_wrap then revised, all others HIGH-confidence title-driven). Mapping deferred along with the catalog work.
- **Premise break documented:** intake writes display labels (`'Gym Floor Stencil'`) to `jobs.product_type`, not snake_case keys (`'gym_stencil'`). Backend code branching on snake_case has been silently failing for every stencil job ever entered. Material auto-populate, completion email templates, AI categorization — all dead code in production. Brady has never seen those features fire.
- **Three research workstreams designed and prompts drafted:**
  - W1: Industry ERP data model research (Perplexity Deep Research, ~30-60 min)
  - W2: UX patterns for trades-industry intake forms (Perplexity Deep Research, ~30-60 min)
  - W3: Current pricing rules audit (Claude Code, ~1-2 hours)
- **Repo cleanup on Windows PC:**
  - Identified 3 clones: `Documents\GitHub` (canonical, clean, on `6399d39` matching origin/main), `Projects\` (3 days stale, 1 dirty file), `OneDrive\Documents\GitHub\` (OneDrive sync hazard)
  - **CRITICAL save:** OneDrive clone contained 3 uncommitted files that were NOT in canonical clone:
    - `docs/flooring-schema.md` (10KB, foundational schema work for ASF flooring expansion)
    - `docs/flooring-scope.md` (10KB, component specs and routing for flooring division)
    - `prompt-4.7a-job-centric-foundation.md` (23KB, prompt that shipped under different commits — historical reference)
  - Logan's near-miss: initial recommendation was to delete OneDrive clone before realizing these files only existed there. Salvaged before deletion.

## In-flight items

### Item 1 — Three research workstreams (NOT YET KICKED OFF on Windows)

Logan to kick these off in this order on Windows PC:

**W1 (Perplexity Deep Research):** Industry ERP data models for sign/wrap shops. Full prompt preserved below in "Prompt W1" section. Save output to `docs/research/W1-industry-erp-data-models.md`.

**W2 (Perplexity Deep Research, second session):** UX patterns for trades-industry intake forms. Full prompt preserved below in "Prompt W2" section. Save output to `docs/research/W2-ux-trades-intake-patterns.md`.

**W3 (Claude Code session, Windows):** Audit-only pass on current pricing engine. Full prompt preserved below in "Prompt W3" section. Output committed by CC to `docs/audits/pricing-engine-audit-2026-04-20.md`.

All three can run in parallel. Logan can kick off both Perplexity sessions and CC simultaneously, walk away, return to results.

### Item 2 — Salvaged flooring docs need to be committed (NOT YET DONE)

The 3 salvaged files are sitting in the OneDrive clone as of handoff time. Logan needs to:

1. Copy `docs/flooring-schema.md` and `docs/flooring-scope.md` from OneDrive clone to canonical clone (`C:\Users\logan\Documents\GitHub\asf-graphics-app`)
2. Move `prompt-4.7a-job-centric-foundation.md` from OneDrive clone to canonical clone at `docs/archive/prompts/2026-04-18-prompt-4.7a-job-centric-foundation.md`
3. Verify migration state — flooring-schema.md references migrations `005a_flooring_columns_tables.sql` and `005b_flooring_notify_trigger.sql`. Need to know if these exist in the repo (started-and-paused) or don't (started-and-aborted)
4. Commit with appropriate message
5. Then nuke OneDrive clone and `Projects\` clone

PowerShell commands for steps 1-2 preserved below in "Salvage commands" section.

### Item 3 — Court Designer scope clarification

Logan confirmed: Court Designer lives in asf-graphics-app for now. There is no separate flooring internal site. The flooring-schema/scope docs are reference for the eventual flooring expansion — whether as same-platform expansion (per the docs) or separate platform (per Logan's memory framing) is a future strategic decision, not blocking anything currently.

## Pending items (queued, not blocking current work)

- **Commit #2 (stencil intake + design library fixes) — DEFERRED until research synthesis ships.** Catalog work (Fix 8) was the original blocker; deferring it left only 9 fixes which are independent of architecture. Re-evaluate after research synthesis: ship the 9 non-catalog fixes as commit #2, ship components model as commit #3, OR fold everything into one larger commit.
- **Prompt A (QBO imported jobs missing prices) — queued, awaits commit #2 ship.** Full prompt in prior handoff archive.
- **Prompt B (Quick Estimate tool for Brady) — queued, awaits Prompt A ship.** Full prompt in prior handoff archive.
- **Phase 1 Step 3 — Service worker + install prompt + update prompt — queued.** Scope locked in earlier session.
- **2FA manual verification — pending Logan.** Enroll → logout → login flow.
- **Learnings capture in `docs/learnings.md`:**
  - Login signOut-on-mount trap (HIGH severity, cross-project)
  - Session-restore-timeout as fail-closed trap (HIGH severity, cross-project)
  - Storage-format mismatch (display labels vs snake_case keys) — silent backend correctness bug pattern (HIGH severity, ASF-specific but generalizable)
  - Stencil-vs-wrap structural divergence in single-product intake forms (MEDIUM severity, ASF-specific)
  - Industry-specific category naming should pull from actual conventions before invention (LOW severity, cross-project)
  - "Dominant product wins, secondary materials in notes" is anti-pattern that lies to the system (HIGH severity, cross-project — design-decision learning)
  - OneDrive folder + git repo = data loss vector (HIGH severity, cross-project)
- **OneDrive removal on Windows — pending after research week.** Clone safely deleted; Logan should configure git to never re-clone into OneDrive folder.
- **Backend normalization shim removal** (jobs.py:545, emails.py:539, auto_categorizer.py:24, material_advisor.py:226-227, import_qbo.py mapping table) — separate commit after canonical catalog stabilizes for 30 days.
- **`auto_categorizer.py:24`** has dead mapping `"floor": "floor_graphic"` to remove. Trivial. Folds into commit #2.

## Decisions made

- **Components model is target architecture.** Path A (research first, ship single-product fix in interim, build components afterward) selected over Path B (ship components in 5-7 days) and Path C (reserved-but-unused JSONB column antipattern).
- **Catalog work fully deferred** until research synthesis. Includes: 14-entry catalog, IA refactor, snake_case key migration, per-row product_type backfill, productTypes.js single-source-of-truth, intake form storage format fix.
- **Brady continues using current platform during research week.** Imperfect data for ~5-10 jobs is acceptable cost for designing the right architecture. Migration of those rows when components model ships is straightforward (each becomes one component).
- **In-person Brady/Chanté workflow study NOT pursued** — Logan declined ("they're busy and seem to get annoyed when I try to ask them"). Substituted with: W2 UX patterns research + a silent observation log Logan maintains during research week (watching audit log for fields left blank, notes doing structured work, repeated workarounds).
- **Court Designer remains in asf-graphics-app.** No separate flooring internal site exists yet.
- **Strategic conflict surfaced but not resolved:** flooring-schema/scope docs propose flooring-as-expansion of graphics platform with shared infra. Logan's memory frames flooring as a separate future platform. These two strategies are incompatible. Decision deferred to a future strategic session.
- **Three Windows PC clones reduced to one:** `Documents\GitHub` retained as canonical. `OneDrive\Documents\GitHub\` and `Projects\` to be deleted after flooring docs salvaged.

## Files NOT changed this session (intentional)

- No code commits this session
- No migrations applied
- No file edits in any asf-graphics-app clone
- The unstaged `src/lib/productTypes.js` from Mac sync (if it transferred to Windows) should be left untouched — it's a draft from abandoned investigation, not authoritative

## Unresolved questions

- Does the repo contain `005a_flooring_columns_tables.sql` and `005b_flooring_notify_trigger.sql` migrations? (Determines whether flooring schema was partially applied to Supabase or whether it was purely a planning doc.)
- Strategic: flooring as graphics-platform expansion (per docs) vs. separate platform (per Logan's memory framing)?
- Will the in-flight `prompt-4.7a-job-centric-foundation.md` work need anything ported into current architecture, or did it fully ship under different commits?

## Frustration signals (avoid next chat)

- **Don't recommend pursuing in-person workflow study with Brady/Chanté.** Logan tried, they got annoyed. Use silent observation + research substitutes only.
- **Don't recommend nuking files without verifying they're safe to discard.** Near-miss with flooring docs this session — hash check first, always. Test-Path on the assumed-canonical location first, always.
- **Don't propose adding speculative infrastructure ("reserved JSONB column for future")** — Logan correctly identified this as YAGNI. If components model isn't shipping in this commit, don't reserve schema for it.
- **Don't underestimate scope on architectural changes.** Components model is ~9-10 working days for a focused builder, ~2 weeks calendar with CC + verification rounds. Be honest from the start.
- **Don't issue Claude Code prompts mid-flow without ensuring CC can finish in one sitting.** Logan had to abandon a CC session because it took too long. For long-running CC tasks: warn Logan in advance about expected duration, recommend kicking off when he has uninterrupted time available.
- **Don't ask Logan to substitute placeholders in raw URLs or commands** — build a fill-in-the-blank script or HTML form for multi-credential tasks.
- **Don't force-feed migrations via CLI** — Logan applies manually via Supabase SQL Editor.
- **Don't accept "already correct" without grep proof** — persistent CC failure mode.
- **Don't assume PowerShell handles bash-style command chaining (`&&`, `||`).** Use semicolons or write proper PowerShell scripts. Multi-line `if/else` blocks must be in scripts, not pasted line-by-line.
- **Don't assume Claudious repo path without verifying.** Correct path is `C:\Users\logan\Projects\claudious\` (lowercase), not `Documents\GitHub\Claudious\`.

## User Preferences changes pending

None.

## New findings (from this session)

- **Storage-format mismatch in production (HIGH, ASF-specific):** `IntakeFormV2.jsx:598` and `:925` write `productConfig?.label` (display label) to `jobs.product_type` instead of `productConfig.key` (snake_case). 11 jobs in DB stored as display labels. Every backend `product_type === 'gym_stencil'` branch has been dead code since intake went live. Affected files: `backend/routes/jobs.py:545`, `backend/routes/emails.py:539`, `backend/services/auto_categorizer.py`, plus all stencil-aware behavior anywhere in backend.
- **`design_library.product_type` column abuse (MEDIUM, ASF-specific):** column being used to store asset types (`mockup`, `logo`, `template`) and backdrop categories (`school_athletics`, `school_general`, `retail_storefront`) instead of product types. Filter-by-product-type returns garbage. Cleanup deferred to components-model commit but flagged for awareness.
- **Industry-specific category naming research finding:** "Print Media" replaced with "Banners & Graphics" because vinyl/wrap industry uses location-based or installation-based categories, not media-type categories. Two-minute Perplexity search beats invention. Generalizable: when proposing UI category names for any vertical, check the industry first.
- **Bill-of-materials = correct manufacturing data model:** every custom-fab business (sign shops, wrap shops, fabricators, kitchen installers) eventually converges on parent-job + child-components structure. Trying to model multi-material jobs as single-product-per-job creates silent failures everywhere. Generalizable to any production-management platform serving custom fabrication.
- **OneDrive + git is a data loss vector (HIGH, cross-project):** OneDrive sync races with git operations. Files get created in OneDrive folder, sync interrupts the git add/commit cycle, work never reaches origin, only copy lives in the OneDrive folder that gets nuked. Logan's prior memory flagged this; this session nearly cost him the flooring docs as a result.
- **Documented-wrong color range pattern still applies:** sidebar `#1A1A2E` reads as blue/indigo (wrong); correct is `#1D1D1F` (near-black). Per `.claude/settings.json` hooks. Not relevant to this session but reaffirmed in CLAUDE.md as a known trap.
- **Claudious repo path on Windows is `C:\Users\logan\Projects\claudious\` (lowercase), NOT `Documents\GitHub\Claudious\`.** Corrected during this handoff commit.

## Next session first actions

1. **Read `canonical/handoff-active.md` before responding.**
2. **Confirm research workstream status:** ask Logan whether he kicked off W1, W2, W3 yet, and whether outputs are ready.
3. **If outputs ready:** Logan pastes all three documents into the chat. Synthesize into the bulletproof components-model schema + intake form spec + pricing engine refactor plan + migration strategy.
4. **If outputs not ready:** confirm he has the prompts (preserved below), suggest he kick them off and return when results land.
5. **Confirm OneDrive cleanup status:** flooring docs salvaged into canonical clone? OneDrive and Projects (asf-graphics-app) clones nuked?
6. **Verify flooring migration state:** did `Get-ChildItem supabase\migrations -Filter "*flooring*"` return anything? This determines whether the flooring schema was partially applied or remains purely planning-stage.
7. **Then proceed with architecture synthesis.**

---

## Salvage commands (run on Windows PC if not yet done)

```powershell
$src = "C:\Users\logan\OneDrive\Documents\GitHub\asf-graphics-app"
$dst = "C:\Users\logan\Documents\GitHub\asf-graphics-app"

# Copy flooring docs to canonical
Copy-Item "$src\docs\flooring-schema.md" "$dst\docs\flooring-schema.md"
Copy-Item "$src\docs\flooring-scope.md" "$dst\docs\flooring-scope.md"

# Archive 4.7a prompt
$promptArchiveDir = "$dst\docs\archive\prompts"
if (-not (Test-Path $promptArchiveDir)) {
    New-Item -ItemType Directory -Force -Path $promptArchiveDir | Out-Null
}
Copy-Item "$src\prompt-4.7a-job-centric-foundation.md" "$promptArchiveDir\2026-04-18-prompt-4.7a-job-centric-foundation.md"

# Verify migration state
Push-Location $dst
Get-ChildItem supabase\migrations -Filter "*flooring*"
Get-ChildItem supabase\migrations -Filter "005*.sql"
git status
Pop-Location
```

After verifying, commit from asf-graphics-app repo:
git add docs/flooring-schema.md docs/flooring-scope.md docs/archive/prompts/2026-04-18-prompt-4.7a-job-centric-foundation.md
git commit -m "docs: salvage flooring expansion planning + 4.7a prompt archive from OneDrive clone"
git push origin main

Then nuke:
```powershell
Remove-Item -Recurse -Force "C:\Users\logan\OneDrive\Documents\GitHub\asf-graphics-app"
Remove-Item -Recurse -Force "C:\Users\logan\Projects\asf-graphics-app"
```

---

## Prompt W1 — Industry ERP data model research (paste into Perplexity Pro Deep Research)
I'm building an internal production management platform for a custom
sign and wrap shop (vehicle wraps, building signage, banners,
gym floor stencils, window perf, building wraps). Roughly $300K/year
revenue, 4-person team, mix of school district and commercial work.
I need to research how mature sign/wrap industry software solves the
job-modeling problem. Specifically, when a single job involves multiple
materials applied to multiple surfaces (e.g., a press box install with
vinyl on tin metal sides + window perf on the front + dimensional letters
on a Starboard panel), how do industry-standard tools structure this
in their data model and intake workflow?
Research these specific products in depth:

Cyrious Control (cyrious.com)
Shopworks
Signtracker
EstiMate by Signtracker
PrintSmith Vision
Any other sign/wrap industry ERP with significant market share

For each product, find and report:
A. JOB DATA MODEL

How is a "job" structured? Is it one record with multiple line items, or a parent-child structure (job → components/sub-jobs)?
Are line items called "components," "products," "items," "operations," or something else?
Is each line item linked to a material, a surface, an install method, or some combination?
How are ancillary items (equipment rental, hardware, prep work, travel) handled — separate line items, overhead lookup, or job-level fields?

B. INTAKE WORKFLOW

What fields does the user fill in first when creating a new job?
How is product type / material / surface presented — dropdowns, search, templates, "kit" pre-fills?
How does the form scale from a simple one-banner job to a complex multi-surface install?
Are there templates or "kits" that pre-populate common job types (e.g., "full vehicle wrap kit" pre-fills 6 components)?

C. PRICING MODEL

How is price calculated when a job has multiple components with different materials and install difficulties?
Are labor and material priced together (per sqft inclusive) or separately (material cost + labor multiplier)?
How do install difficulty / install location modifiers work?
Are there minimum-order or setup fees per job vs per component?

D. MATERIAL & SURFACE LOOKUP

Is "material" a free-text field, an enum, a lookup against an inventory table, or linked to a vendor catalog?
Is "surface" tracked at all, and if so, how?

E. CUT LIST / ORDER GENERATION

Can these tools generate a cut list, material order, or production sheet from the job record?
How does the data model enable that?

F. KEY CRITICISMS

What do users on industry forums (signs101, signdiscussionboard, reddit r/signshop) complain about with each tool's data model?
What workarounds do shops invent to handle multi-material jobs the tool can't natively model?

Deliver this as a structured comparison document. For each tool, show
the actual data model shape using example records (mock data is fine
if real screenshots aren't available). Cite sources for every claim
including documentation pages, forum threads, and product reviews.
End with a synthesis: across these 5+ tools, what are the 3-5
data-model patterns that consistently work? What patterns consistently
fail or get worked around? Which industry standard is closest to a
"correct" answer for a small custom shop?

---

## Prompt W2 — UX patterns for trades intake forms (paste into Perplexity Pro Deep Research, separate session)
I'm designing an intake form used by non-technical field workers in
a custom fabrication shop (sign and wrap installer, designer). Users
are skilled tradespeople, not designers, not data-entry clerks. They're
often on a phone or tablet, sometimes mid-install, sometimes between
calls. Annoying or confusing forms get abandoned and the data goes
into a notes field instead of structured columns.
The form needs to capture jobs with multiple components — e.g., a
single press box install might involve vinyl wrap on three sides,
window perforation on the front, and dimensional letters mounted
on a substrate. Each component has its own material, surface,
dimensions, and install difficulty.
Research and document UX patterns for this use case. Specifically:
A. MULTI-COMPONENT FORM PATTERNS
Find UX research, case studies, and product examples for intake forms
that capture variable numbers of line items / components per parent
record. Common patterns to evaluate:

Repeater pattern (single form with "Add another" button)
Wizard/stepper pattern (component-by-component multi-step flow)
Spreadsheet-style table input
Card-based component builder (drag and drop)
Template-driven pre-fill ("Choose job type" pre-populates components)
Hybrid (template seed + manual edit)

For each pattern, find:

Where it's used successfully (cite specific products: ServiceTitan, Jobber, Housecall Pro, Buildertrend, PlanGrid, Fieldwire, etc. — focus on field-service and construction software)
User research on cognitive load, error rate, completion time
Where it fails (forums, reviews, abandoned-cart equivalents)
Mobile vs desktop variations

B. FIELD ORDER AND COGNITIVE FLOW
For trades workers entering job data, what is the empirically-supported
order of fields? Some hypotheses to test:

"Who is this for" first (client) — concrete identity anchors the rest
"What is being made" first (product) — task-oriented anchors
"Where is it going" first (install location) — spatial anchors
"When is it due" first (deadline) — urgency anchors

Find research from field-service software UX studies, contractor
software case studies, and trades-industry intake form design.
C. PROGRESSIVE DISCLOSURE
For forms that need to handle both simple jobs (one banner) and
complex jobs (multi-component install), how do best-in-class tools
hide complexity from simple cases without making complex cases
require navigation away? Specifically:

Default to simplest form, expand on user request
Always-show all sections but auto-collapse unused
Conditional sections that appear based on prior answers
"Quick mode" vs "Detailed mode" toggle

D. FIELD WORKER SPECIFIC CONSTRAINTS
What's known about form design for users who are:

On mobile in non-ideal conditions (sun glare, gloves, dust)
Interrupted constantly (calls, customers, deliveries)
Domain-expert but not data-entry-trained
Resistant to "more fields" because it slows real work

What design principles consistently surface in research from companies
that build software for plumbers, electricians, contractors, installers,
HVAC techs?
E. ANTI-PATTERNS THAT FAIL IN FIELD-SERVICE INTAKE
What patterns consistently fail in trades intake forms? Find specific
examples from product reviews, support threads, and UX postmortems.
F. SPECIFIC PRODUCT TEARDOWN
Take 3 field-service / trades software products and document the
exact intake flow with screenshots or detailed descriptions:

ServiceTitan (HVAC/plumbing)
Jobber (general field service)
Either Buildertrend or Fieldwire (construction)

For each, walk through: how does a field worker enter a new job?
What fields, in what order, with what defaults? How does the form
handle a job with multiple line items / phases?
Deliver as a structured document. Cite every claim with sources
(case studies, product documentation, user research papers, forum
threads). End with a synthesis of the 3-5 strongest UX principles
for this specific use case — what patterns I should adopt, what
patterns I should avoid, and what tradeoffs to be aware of.

---

## Prompt W3 — Pricing engine audit (paste into Claude Code on Windows)
Audit-only task. NO file edits. NO changes. Pure documentation pass.
PREFLIGHT
─────────

Confirm git status is clean on main, up to date with origin/main.
If src/lib/productTypes.js exists as untracked, leave it alone.
Do not edit, do not delete, do not stage.

TASK
────
Read in full:

backend/routes/quotes.py
backend/prompts/pricing_finance.py
backend/services/material_advisor.py
src/pages/QuoteCalc.jsx
src/components/job/QuoteCalc.jsx (if it exists — embedded version)
Any other file with pricing logic — grep for: 'calculate', 'price', 'margin', 'cost', 'sqft', 'multiplier', 'tier'

For each pricing rule found, document in this format:
RULE: [name]
LOCATION: [file:line]
TRIGGER: [what condition fires it]
INPUT: [what fields/values it reads]
CALCULATION: [the actual math, in plain language and code]
OUTPUT: [what it produces]
EDGE CASES: [null handling, division-by-zero, negative values]
PRODUCT-TYPE BRANCHES: [if it behaves differently for different products, list each branch]
DEPENDENCIES: [other rules it calls or is called by]
After cataloging every rule, produce:

A flow diagram (text/ASCII) showing the order of operations from
intake input → final price.
A list of every product type currently handled, with notes on
which ones have custom pricing logic vs default.
A list of every place where pricing logic exists in BOTH frontend
and backend (the audit bug #14 problem) — flag each as a
reconciliation risk.
A list of every pricing rule that depends on the current single-
product-per-job assumption, and how each would need to change to
support a multi-component model.
A list of any pricing rules that look broken, inconsistent, or
suspicious — places where you'd flag for human review.

Output as a single markdown document committed to docs/audits/
pricing-engine-audit-2026-04-20.md. Push to main.
CONSTRAINTS
───────────

main branch only, no branches
audit document only — no code changes
if you find something genuinely broken, document it but DO NOT fix
No edits to src/lib/productTypes.js (it's a draft from a prior session)
Do not create or modify any migration files
Push the docs/ file when done. Report commit SHA.


---

## Migration state note

Latest applied migration as of handoff: `046_*.sql` (per Mac session). Commit #2 was going to add `047_stencil_intake_support.sql` but was abandoned. Next migration number when work resumes: `047`. No migrations applied or modified this session.

## Repo state at handoff

- **Active asf-graphics-app clone (Windows):** `C:\Users\logan\Documents\GitHub\asf-graphics-app`
- **HEAD:** `6399d39` — `docs(learnings): capture pwa polish + auth fix root causes`
- **origin/main:** `6399d39` (fully synced, `0 0` ahead/behind)
- **Status:** clean (assuming flooring docs salvage hasn't run yet)
- **Branch:** main
- **Pending cleanup:** OneDrive clone at `C:\Users\logan\OneDrive\Documents\GitHub\asf-graphics-app` (delete after salvage), Projects clone at `C:\Users\logan\Projects\asf-graphics-app` (delete after confirming nothing unique)
- **Claudious repo (Windows):** `C:\Users\logan\Projects\claudious\`

## Court Designer scope (confirmed this session)

Lives in asf-graphics-app for now. No separate flooring internal site exists. The flooring-schema/scope docs salvaged from OneDrive are reference material for eventual flooring expansion (architectural decision deferred). Do not act on flooring-schema/scope docs as if they're current build plans — they're future-state planning artifacts.

## END OF HANDOFF
