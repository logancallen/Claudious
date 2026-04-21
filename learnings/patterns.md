# Patterns — Architecture and Workflow
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Patterns

### 2026-04-17 — PATTERN — Roadmap auto-close via post-commit hook dispatcher

**Severity:** HIGH
**Context:** ASF Graphics accumulated ~50 open work items tracked across chat transcripts — invisible across sessions. Sprint 4.6 stood up `docs/roadmap.md` as the single source of truth (P0–P3, BUG/UX/FEATURE/PERF/REFACTOR/DOC) and wired `.claude/hooks/post-commit-roadmap.sh` to parse `roadmap: close RM-XXX` directives from commit messages, move the matching line from OPEN to CLOSED with a date + sprint-tag stamp, and re-commit as `docs: roadmap auto-update`. Pre-existing inline `post-commit` logic was preserved by renaming it to `post-commit-docs.sh`; the new `post-commit` is a 10-line dispatcher that runs every executable `post-commit-*.sh` in the hooks dir.
**Learning:** One commit-message directive replaces manual roadmap.md editing across multiple sessions. The dispatcher pattern (`post-commit` → `post-commit-*.sh`) lets independent hook concerns coexist without stepping on each other. Key failure modes to guard: self-recursion on the auto-update commit (skip via subject regex), and sprint-tag extraction picking up model-version strings like "Claude Opus 4.7" in `Co-Authored-By` trailers (scrub trailer lines before regex). Live-test the hook in the same session by including a close directive in the first fix commit — a hook that's never exercised is a hook that breaks in the next sprint.
**Applies to:** Any repo with a cross-session work backlog and `core.hooksPath` set. Pairs well with a `roadmap: add` directive for symmetry.

### 2026-04-17 — PATTERN — Single source of truth for domain-object classification

**Severity:** HIGH
**Context:** Press Box Wrap intake rendered Vehicle Lookup + Coverage Zones because step 3 branched on `productConfig.category === 'wrap'`, independent of JobMaterials.jsx's `VEHICLE_PRODUCT_TYPES` gate. Each component had its own product-type predicate; fixing one did not fix the others. Amendment audit found 14 parallel vocabularies across the codebase, each with its own branching logic.
**Learning:** Any feature that differentiates behavior by a domain-object classification (product type, client type, job phase) must be audited at every touchpoint (intake, materials, stencils, warranty, emails, phases) — not just the first one that surfaces a bug. A single canonical predicate imported from one source of truth (`src/lib/productTypes.js` with `isVehicle(productType)`, `isBuilding(productType)`, etc.) is the only sustainable pattern. Ad-hoc `SET.has(row.col)` or `col === 'SomeLabel'` comparisons scattered across components generate scatter bugs whenever the storage format shifts (data migration, CHECK constraint, enum extension).
**Applies to:** Any domain classification used for conditional UI or business logic. Particularly acute post-data-migration when the stored vocabulary changes underneath live predicates.

### 2026-04-17 — PATTERN — Split tactical fixes from strategic refactors

**Severity:** HIGH
**Context:** Press Box Wrap intake bug had a 1-line fix (intakeConfig.js:64 category 'wrap'→'flat') and a 16-file consolidation (product-type vocabulary unification). Bundling them would have delayed the user-visible fix by days while the refactor scoped. Split into two commits: fix(intake) shipped immediately, docs(audit) staged for later prompt.
**Learning:** When a production bug has both a tactical patch and a strategic refactor path, ship the patch FIRST as a standalone commit, then plan the refactor separately. Never let the patch wait on the refactor. Document the larger scope in a committed audit doc so the future work isn't lost.
**Applies to:** Any bug where the root-cause fix is large but a symptom-fix is small.

### 2026-04-11 — PATTERN — 3-Layer Claude Code Knowledge Architecture
**Severity:** HIGH
**Context:** Discovered during deep architecture research.
**Learning:** Separate .claude/ into three layers: skills/ (procedural — what to do), memory/ (episodic — what went wrong), knowledge/ (reference — static docs). CLAUDE.md = instructions. MEMORY.md = facts. Skills = on-demand procedures. Mixing layers degrades all of them. Most builders only have skills/. All three are needed.
**Applies to:** All Claude Code projects

### 2026-04-11 — PATTERN — RAG Split for Large Knowledge Files
**Severity:** HIGH
**Context:** Courtside Pro knowledge-base.md was 162KB — completely unretrievable by RAG.
**Learning:** Files over ~5KB degrade RAG retrieval. Split into individual topic files under a subdirectory (docs/kb/). Each file: descriptive filename, H2/H3 headers, self-contained sections, key fact in first 2 sentences. Create index.md as master list. Replace original with redirect. Claude Code can split a 162KB file into 70 RAG-optimized files in under 5 minutes. RAG may activate as early as 2-6% context usage with many files.
**Applies to:** All Claude Project knowledge files over 5KB

### 2026-04-11 — PATTERN — Agent Specialization via .claude/agents/
**Severity:** HIGH
**Context:** Discovered during .01% blueprint research.
**Learning:** Create individual agent definition files in .claude/agents/ with YAML frontmatter: name, isolation (worktree), tools, model, effort. Agents snap into defined behavior when addressed by name. Standard roles: BUILDER (frontend only), MIGRATOR (database only), DEPLOYER (pre-deploy verification), REVIEWER (adversarial review). Cleaner and more precise than flat AGENTS.md definitions.
**Applies to:** ASF Graphics and any project using parallel agents

### 2026-04-11 — PATTERN — SessionEnd/Start Hook Chain for Automatic Handoff
**Severity:** HIGH
**Context:** Manual handoffs are the most common session continuity failure.
**Learning:** SessionEnd directive prompts Claude to write handoff to .claude/handoff.md (completed, pending, blockers, next action). SessionStart reads handoff.md and pre-appends to new session. Eliminates manual handoff writing entirely. Add handoff.md to .gitignore. Primary mechanism is CLAUDE.md directive (in-context), not a scheduled task.
**Applies to:** All Claude Code projects

### 2026-04-15 — PATTERN — Operator Pattern with allowedTools Scoping
**Severity:** HIGH
**Context:** Central orchestrator + specialized subagents becomes deterministic when orchestrator uses --allowedTools to restrict each subagent's tool access.
**Learning:** Define orchestrator with narrow scope (Task, Bash), spawn subagents with restricted scopes (frontend: Edit,Read,Glob — no Bash; DB: Bash,Read — no Edit). Prevents scope creep.
**Applies to:** All projects using .claude/agents/ subagent definitions.

### 2026-04-14 — PATTERN — Spec-First Plan Mode Workflow
**Severity:** HIGH
**Context:** Formalizes Logan's "plan first, approve, then code" User Preference into a repeatable file artifact.
**Learning:** Before any non-trivial feature, create `specs/<feature-name>.md` with four sections: Scope, Constraints, Acceptance Criteria, Do-Not-Do. Start Claude Code in plan mode. Share spec. Prompt: "Review this spec and propose an implementation plan. Do not write code." Iterate on plan — challenge assumptions, require rationale. Only after plan approval, exit plan mode and execute. The Do-Not-Do section is the highest-leverage block: it replaces negative User Preferences instructions with positive constraints scoped to one feature.
**Applies to:** All Claude Code projects — ASF Graphics, Courtside Pro — for any feature >2 files or >30 min estimated work

## Archive
