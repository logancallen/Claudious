# Patterns — Architecture and Workflow
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Patterns

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
