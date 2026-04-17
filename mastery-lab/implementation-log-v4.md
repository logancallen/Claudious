# Implementation Log

**Purpose:** Track every technique implemented from the playbook — what changed, where, and whether it worked. This creates the feedback loop that makes the Mastery Lab smarter over time.

**Last Updated:** April 14, 2026

---

## Log Format

```
### [DATE] — [TECHNIQUE-ID]: [Name]

**Applied to:** [Project/skill/global]
**What changed:** [Specific changes made]
**Result:** [POSITIVE | NEUTRAL | NEGATIVE | PENDING]
**Measured impact:** [Specific observation or metric, or "subjective" if not measurable]
**Propagate to:** [Other projects that should get this change, or N/A]
**Notes:** [Lessons, surprises, adjustments]
```

---

## Sprint 1 — April 7, 2026

### CC-001: Optimize CLAUDE.md for Conciseness
**Applied to:** asf-graphics-app (Claude Code)
**What changed:** CLAUDE.md slimmed from bloated state to 40-line lean index. Removed duplicated rules, merged agent escalation rules, moved Python/backend rules to AGENTS.md.
**Result:** POSITIVE
**Measured impact:** Per-message token cost reduced significantly. Build passes cleanly.
**Propagate to:** Pattern applicable to all projects

### CC-002: Create Project-Specific Claude Code Skills
**Applied to:** asf-graphics-app (Claude Code)
**What changed:** Created 3 skill files: deploy-checklist.md, schema-migration.md, component-build.md. Created AGENTS.md.
**Result:** POSITIVE
**Measured impact:** ~217 lines of domain knowledge moved from per-message to on-demand loading.

### CC-018: Hooks (Deterministic Lifecycle)
**Applied to:** asf-graphics-app (Claude Code)
**What changed:** 3 hook scripts: pre-bash-safety.sh, post-edit-format.sh, post-edit-typecheck.sh.
**Result:** POSITIVE
**Measured impact:** Deterministic quality gates on every edit.

### CC-012: Disconnect Unused MCP Servers
**Applied to:** asf-graphics-app (Claude Code)
**What changed:** Kept 2 servers, disconnected 3.
**Result:** POSITIVE
**Measured impact:** ~8,400 tokens/message saved.

### CC-003: Install Code Intelligence Plugins
**Applied to:** asf-graphics-app (Claude Code)
**What changed:** Installed typescript-lsp, pyright-lsp, security-guidance.
**Result:** POSITIVE
**Measured impact:** Precise symbol navigation and auto error detection.

### CC-011: Status Line Setup
**Applied to:** Claude Code (global)
**What changed:** Configured to show model name, context %, token count.
**Result:** POSITIVE

### CC-016: /effort Command
**Applied to:** Claude Code (global)
**What changed:** Set to medium (was high).
**Result:** POSITIVE

### CC-008: AutoDream Memory Consolidation
**Applied to:** Claude Code (global)
**What changed:** Manual consolidation performed. Toggle not available at time.
**Result:** PARTIAL
**Notes:** AutoDream confirmed LIVE on April 12, 2026. Auto-memory: on.

---

## Sprint 2 — April 8, 2026

### CC-019: Disable Adaptive Thinking Env Var
**Applied to:** Claude Code (global — PC PowerShell profile)
**What changed:** CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1
**Result:** POSITIVE
**Measured impact:** Fixes April 2026 quality regression on reasoning tasks.

### CC-020: Auto-Compact Window + Subagent Model Pin
**Applied to:** Claude Code (global — PC PowerShell profile)
**What changed:** CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000, CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6
**Result:** POSITIVE

### CC-021: Agent Teams Env Var
**Applied to:** Claude Code (global — PC PowerShell profile)
**What changed:** CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true
**Result:** POSITIVE — available but not yet used in production

### CC-022: Codex Adversarial Review Plugin
**Applied to:** Claude Code (global)
**What changed:** Installed openai/codex-plugin-cc. First /codex:review found 3 real bugs: migration ordering, designer RLS policy blocking inserts, financial data leaking through base table SELECT policies.
**Result:** POSITIVE
**Measured impact:** 3 production bugs caught that Claude missed reviewing its own code.
**Notes:** Keep review gate manual (/codex:review) to avoid runaway token loops.

### CC-023: Caveman Skill
**Applied to:** Claude Code (global — ~/.claude/skills/caveman/)
**What changed:** Installed JuliusBrussee/caveman for 75% internal token reduction.
**Result:** POSITIVE

### CC-028: .claude/agents/ Directory
**Applied to:** asf-graphics-app
**What changed:** Created builder, migrator, deployer agent definitions.
**Result:** POSITIVE

---

## Sprint 3 — April 11-12, 2026

### Courtside Pro Full Automation
**Applied to:** courtside-pro
**What changed:** Post-commit hook, session-start/end hooks, sync-knowledge.sh, path-scoped rules (.claude/rules/), 3 skills with full YAML spec, CLAUDE.local.md, MEMORY.md, docs/kb/ (70 RAG-split files from 162KB knowledge-base.md), docs/learnings.md cleaned.
**Result:** POSITIVE
**Measured impact:** Fully autonomous knowledge sync loop. Zero manual maintenance needed.
**Notes:** Status upgraded to ACTIVE 2026-04-12 — demos/meetings with contractors and manufacturers scheduled. Automation carried over from post-sale phase.

### Claudious Repo Built
**Applied to:** Global (all projects)
**What changed:** Full repo structure built via ultraplan. 3 global skills (harvest, pioneer, project-router), 6 custom subagents, 3 shell scripts, alert system, research pipeline. Connected to ALL 8 Claude Projects as knowledge source.
**Result:** POSITIVE
**Measured impact:** First full system cycle completed April 12: Scout found 13 techniques, Evaluator triaged (3 queued, 4 proposed, 5 redundant, 1 conflict), Pioneer found 3 auto-queue improvements + 4 proposals (config health B), Implementer deployed 4 items.

### ASF Graphics Knowledge Consolidation
**Applied to:** asf-graphics-app
**What changed:** 9 missing knowledge files recovered from Claude Project UI, committed to docs/. GitHub sync connected (18 files). Manual uploads removed. docs/knowledge-index.md created.
**Result:** POSITIVE
**Measured impact:** Single source of truth — all knowledge in git, synced to Claude Project automatically.

### ASF Graphics Automation (Courtside Pro Parity)
**Applied to:** asf-graphics-app
**What changed:** Post-commit hook (auto-updates docs/), session-start hook (reads handoff + learnings), session-end hook (writes handoff), sync-knowledge.sh, path-scoped rules (jsx.md, migrations.md, netlify.md), .claude/handoff.md in .gitignore.
**Result:** POSITIVE
**Measured impact:** Same autonomous knowledge sync loop as Courtside Pro.

### 4 MEMORY.md Files Placed
**Applied to:** Global + ASF + Genesis + Mastery Lab
**What changed:** MEMORY.md created for: ~/.claude/ (global), asf-graphics-app root (committed), Genesis Framework (uploaded), Claude Mastery Lab (uploaded).
**Result:** POSITIVE
**Notes:** Facts separated from instructions per 3-layer knowledge architecture.

### 6 Claude.ai MCPs Disconnected
**Applied to:** Claude.ai (global)
**What changed:** Disconnected Gmail, Canva, Jotform, Linear, Figma, Clarify. Kept Google Drive, Supabase, Stripe, Netlify.
**Result:** POSITIVE
**Measured impact:** Reduced per-message token overhead from unused tool definitions.

### PR-003: User Preferences Positive Reframing
**Applied to:** Claude.ai User Preferences (global)
**What changed:** 4 negative framings rewritten as positive direction. "didn't ask" → "proactively", "not quote" → "cite only when necessary", "non-negotiable" → "always apply".
**Result:** PENDING — applies to new conversations only.

### 10 Cowork Scheduled Tasks Deployed
**Applied to:** Claude Desktop / Cowork
**What changed:** Scout, Evaluator, Implementer, Drift Detector, Retrospective, Pioneer, Digest, Config Backup, Auto-Harvest, AutoDream Check. All manually verified on first run.
**Result:** POSITIVE
**Measured impact:** Full autonomous intelligence loop operational. Scout → Evaluator → Implementer → Pioneer feedback cycle proven.
**Notes:** Cowork sandbox limitations: can't git push (identity workaround added), can't access files outside working folder (Config Backup + Auto-Harvest limited), permission prompts on file operations (no disable option — Cowork is research preview).

### CC-008: AutoDream Confirmed Live
**Applied to:** Claude Code (global)
**What changed:** AutoDream (auto-memory) confirmed active on Logan's account. Auto-memory: on.
**Result:** POSITIVE
**Measured impact:** Automatic memory consolidation — prunes stale entries, merges duplicates, resolves contradictions.

### Drift Detector First Run
**Applied to:** asf-graphics-app
**What changed:** First drift report generated. Found 17 discrepancies: 11 migrations (020-030) undocumented, 8 new tables not in schema-state.md, 15+ undocumented columns, designer financial model documentation wrong everywhere.
**Result:** POSITIVE — system working as designed, catching real drift.

### Implementer First Run
**Applied to:** Claudious queue/ → global config
**What changed:** Implementer daily task executed first autonomous deploy cycle. 4 SAFE items deployed from queue/ (written to deployed.log), 3 judgment-required items moved to proposals/ for Logan review.
**Result:** POSITIVE — closes the autonomous loop (Scout → Evaluator → Implementer → Pioneer feedback).
**Measured impact:** First end-to-end proof that the pipeline deploys without human intervention for SAFE-tier improvements.

### Designer Financial Access Documentation Corrected
**Applied to:** asf-graphics-app (docs/)
**What changed:** Designer role financial access corrected across 3 files — CLAUDE.md, business-rules.md, operating-framework.md. Prior docs incorrectly described designers as having broader financial visibility than the RLS policies actually allow.
**Result:** POSITIVE — docs now match implementation; Drift Detector flagged this on first run.
**Notes:** Triggered by Drift Detector output. Fix revealed a two-layer role scheme that was previously undocumented (see GOTCHA below).

### Two-Layer Role Scheme Documented as GOTCHA
**Applied to:** Claudious learnings.md
**What changed:** Added GOTCHA entry documenting ASF's two-layer role model — `ops_manager` at the database/RLS layer vs. `ops` at the frontend layer. The frontend role is a display-level grouping; the DB role is the actual permission boundary. Conflating them has caused repeated documentation errors (including the designer financial access bug).
**Result:** POSITIVE — durable capture of a non-obvious architectural detail.
**Propagate to:** Reference when reasoning about any permission or role logic in ASF.

---

### April 12, 2026 — .01% Gap Closure Sprint

**Pre-Push Hook (ASF + Courtside Pro)**
Applied to: asf-graphics-app, courtside-pro
What changed: Git pre-push hook blocks push if build or tests fail. Guarded tsc behind tsconfig.json existence check for portability.
Result: POSITIVE — immediately caught 5 pre-existing GeometryEngine test failures on ASF main.

**Codex Review in Deploy Checklist (ASF + Courtside Pro)**
Applied to: asf-graphics-app (.claude/skills/deploy-checklist.md), courtside-pro (.claude/skills/deploy.md)
What changed: /codex:review added as mandatory step before deploy.
Result: PENDING — not yet used in production deploy.

**Parallel-Build Skill (ASF + Courtside Pro)**
Applied to: Both repos (.claude/skills/parallel-build.md)
What changed: New skill documenting 3 parallel execution patterns. CLAUDE.md one-liner added.
Result: PENDING — first production use planned for migrations 026-028 fix.

**Cowork Tasks Reduced 10 → 7**
Applied to: Cowork scheduled tasks
What changed: Removed Config Backup, Auto-Harvest, AutoDream Check. All 7 remaining updated with git lock cleanup prefix. Drift Detector got dedup logic. Schedule staggered 60+ min gaps.
Result: POSITIVE — eliminates 3 no-value tasks, prevents git lock collisions.

**Proposals Cleanup**
Applied to: Claudious proposals/
What changed: 7 resolved/stale proposals deleted, 3 graduation candidates moved to skills/graduated/, pioneer report archived to retrospectives/.
Result: POSITIVE — proposals/ reduced from 12 to 5 active items.

---

## April 14, 2026 — MCP Expansion + Global Skills + Cowork Evidence Loop

### Claude Code MCP Expansion (Playwright + TranscriptAPI + GitHub)
**Applied to:** Claude Code (global)
**What changed:** Installed 3 new MCP servers:
- Playwright — browser automation for UI testing/verification directly from Claude Code
- TranscriptAPI — YouTube transcript ingestion for Mastery Lab DISTILL pipeline (removes manual copy/paste step)
- GitHub — repo, PR, and issue operations from inside Claude Code
**Result:** POSITIVE
**Measured impact:** DISTILL pipeline can now pull transcripts autonomously; UI regressions verifiable without leaving Claude Code; GitHub ops (PRs, issue triage) consolidated into the CC loop.
**Propagate to:** All active Claude Code projects inherit automatically (global scope).

### Global Claude Code Skills (health-optimizer, macro-intelligence, negotiation-playbook)
**Applied to:** Claude Code (global — ~/.claude/skills/)
**What changed:** Deployed 3 new personal-domain skills:
- health-optimizer — training, recovery, nutrition, sleep, supplement advisor
- macro-intelligence — investing, portfolio, macro thesis, position sizing
- negotiation-playbook — counterparty profiling, proposal/RFP drafting, deal structuring (BuyBoard, school district procurement, contractor/manufacturer meetings)
**Result:** POSITIVE — global skill count 4 → 7.
**Notes:** Triggers tuned to avoid false positives with business-ops tasks (e.g., macro-intelligence skips routine Courtside Pro financials; negotiation-playbook skips internal invoicing).

### Cowork Task 8: Evidence Loop Added
**Applied to:** Cowork scheduled tasks
**What changed:** Added 8th weekly task — Evidence Loop. Verifies that techniques marked "deployed" in deployed.log actually produced measurable impact; closes the Implementer → playbook feedback gap identified in prior sprints. Cowork total: 7 → 8.
**Result:** POSITIVE — previously the loop ended at "deployed"; now it ends at "verified impact or flagged for review."
**Notes:** Without Evidence Loop, Pioneer had no signal on whether deployed SAFE items were actually working in practice — only whether they landed.

### All 8 Cowork Task Prompts Audited and Corrected
**Applied to:** Cowork scheduled tasks (all 8)
**What changed:** Full audit pass across Scout, Evaluator, Implementer, Drift Detector, Retrospective, Pioneer, Digest, Evidence Loop prompts. Fixed path references, tightened output contracts (explicit file targets and schemas), removed ambiguous scope language, verified each task against its required inputs/outputs. Global agents directory received fixes surfaced during the audit.
**Result:** POSITIVE
**Measured impact:** Prompts now deterministic about where to read from and write to — reduces Cowork sandbox failure modes (wrong path, silent no-op, ambiguous handoff).
**Notes:** Audit triggered by realization that Evidence Loop couldn't be added cleanly without first normalizing what the other 7 tasks were actually writing.

---

## April 16, 2026 — Sprint 5: Routines + Self-Eval + Prompt Cache

### CC-041: /self-eval Slash Command Deployed
**Applied to:** Global ~/.claude/commands/ + ASF Graphics + Courtside Pro
**What changed:** Created /self-eval global command that critiques skills used during a session and writes proposed edits to `_proposed-edits/` directories (gitignored with .gitkeep tracked) for Pioneer weekly review. Session-end reminder added to global CLAUDE.md. Directories created in ~/.claude/skills/ + asf-graphics-app/.claude/skills/ + courtside-pro/.claude/skills/.
**Result:** Deployed — effectiveness TBD after first full Pioneer review cycle (Sunday April 19).
**Measured impact:** None yet — instrument for future measurement.
**Notes:** Skill-improvement feedback loop was identified in April 11 bootstrap but never implemented until now. Caught and corrected a .gitignore pattern error during deployment — single-line ignore would have defeated .gitkeep; corrected to `_proposed-edits/*` + `!_proposed-edits/.gitkeep`.

### CC-040: ENABLE_PROMPT_CACHING_1H Env Var on PC
**Applied to:** Windows PC PowerShell $PROFILE
**What changed:** Added $env:ENABLE_PROMPT_CACHING_1H = "1". Did NOT set FORCE_PROMPT_CACHING_5M.
**Result:** Deployed April 16 — measurement window 48 hours. Revert trigger: noticeable burn rate increase at claude.ai/settings/usage.
**Measured impact:** Baseline burn rate recorded April 16. Re-check April 18.
**Notes:** Grok dump incorrectly claimed this was a slash command. Correct implementation is env var. Anthropic reverted default to 5m in March 2026 because short sessions benefit more from cheaper 5m write cost (25% premium vs 100% for 1h).

### CC-039: First Cloud Routine Deployed — Claudious Weekly Health Check
**Applied to:** claude.ai/code/routines
**What changed:** Created scheduled routine running Sundays 8:00 AM CDT. Reads Claudious queue/ + proposals/ + deployed.log + retrospectives/ + visible `_proposed-edits/` contents. Outputs 1-paragraph state summary + top 3 action items. Posts to Slack DM. Runs before Scout (8:45 AM).
**Result:** Deployed — first scheduled run Sunday April 19. Run now verification TBD.
**Measured impact:** TBD — measured by whether Sunday summary reduces Logan's manual queue/proposals review time.
**Notes:** Chose Health Check over BuyBoard RFP as first routine because BuyBoard has no data source yet. Proves Cloud Routines end-to-end before trusting with revenue-adjacent workflows. CC-042 (API routines) deferred until RFP webhook source exists.

### /recap Adoption (Behavior Change, Not Playbook Entry)
**Applied to:** Global ~/.claude/CLAUDE.md
**What changed:** Added session-lifecycle v2 section instructing Claude to run /recap on any resumed session before acting.
**Result:** Deployed.
**Notes:** Supersedes manual session-start handoff reading. Works alongside SessionEnd hook chain.

### Grok Dump Credibility Finding
**Applied to:** Claudious learnings (cross-project)
**What changed:** Logged learning — Grok X-scraping dumps produced ~10% signal rate on April 13-16 batch (4 of ~35 "findings" were new and verifiable). One claim was substantively correct but surface wrong (CC-040 as slash command vs env var). Action: reduce Grok dump frequency to bi-weekly unless a major Anthropic announcement triggers targeted sweep.
**Result:** Finding logged. Cadence change to implement.

---

## Rejected After Testing

### CC-009: Auto Mode Permissions
**Reason:** Not available on Max plan. Team/Enterprise/API only.
**Alternative:** Use acceptEdits (Shift+Tab).
**Revisit trigger:** Anthropic announces Max plan support.

---

## Distillation Log

### April 7, 2026 — Batch 1: Nate Herk Transcripts (16 files)
**Source:** YouTube transcripts (Nate Herk / AI Automation)
**Yield:** 9 new techniques, 3 upgrades, 4 skipped (redundant/below level), 3 skipped (duplicates)

### April 11, 2026 — Batch 2: Grok Deep Research Sweep
**Source:** Grok 9-section research sweep
**Yield:** 7 new techniques (CC-019 through CC-025, PA-002)

---

## Cross-Project Propagation Tracker

| Technique | Origin Project | Propagated To | Status |
|---|---|---|---|
| CC-001 CLAUDE.md optimization | asf-graphics-app | Courtside Pro | ✅ Done |
| CC-002 Skills pattern | asf-graphics-app | Courtside Pro | ✅ Done |
| CC-018 Hooks pattern | asf-graphics-app | Courtside Pro, ASF (expanded) | ✅ Done |
| PA-006 GitHub sync | Courtside Pro | ASF Graphics | ✅ Done |
| MM-001 MEMORY.md | Courtside Pro | ASF, Genesis, Mastery Lab, Global | ✅ Done |
| Session lifecycle | Global CLAUDE.md | All CC projects | ✅ Done |
| Claudious knowledge source | Claudious | All 8 Claude Projects | ✅ Done |
