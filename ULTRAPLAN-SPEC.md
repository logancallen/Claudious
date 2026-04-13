# ULTRAPLAN SPEC: Living Knowledge System — Final Complete Build
# Version: Integrated + All 10 Fixes Applied
# Run from: Claudious repo root
# Date: April 11, 2026

---

## OBJECTIVE

Build a fully automated, self-improving intelligence system across Logan's entire Claude ecosystem. Captures knowledge from every session, discovers new Claude optimization techniques, evaluates and deploys improvements autonomously, and maintains itself.

**Zero manual touchpoints except:**
1. "approved" after harvest review (one word)
2. Click Sync in Claude Project UI after push (5 seconds, per project)
3. Review queue/ weekly (~5 min)
4. Review proposals/ monthly (~10 min)
5. Add one line to queue/deployed.log when deploying a queued improvement (~10 seconds)

---

## CRITICAL ARCHITECTURE DECISIONS

### 1. Claudious is GLOBAL
Every Claude Project connects to Claudious as a knowledge source — not just a dedicated Claudious project. ASF Graphics, Courtside Pro, Court Designer, GE Diesel, Genesis, Mastery Lab, Forensic (read-only, no write) — all of them. Intelligence flows:

```
Any session (any project)
    ↓ SessionEnd hook (autonomous)
Project-specific → docs/learnings.md (project repo)
Cross-project → Claudious/learnings/ (global repo)
    ↓ GitHub sync (one click per project)
All future sessions in ALL projects have Claudious intelligence
```

### 2. Dual-Path: Mac + PC
Every script detects machine automatically:
- Mac Studio: ~/Projects/[project]/
- PC: C:\Users\logan\Projects\[project]\
- Courtside Pro PC: C:\Users\logan\courtside-pro\
- Claudious PC: C:\Users\logan\OneDrive\Documents\GitHub\Claudious\

### 3. Primary vs Fallback for Auto-Harvest
- **Primary:** SessionEnd directive in global CLAUDE.md (fires in-context, reads conversation)
- **Fallback:** Daily 11pm scheduled task (catches anything SessionEnd missed)
Not the other way around.

### 4. Scout Replaces Cross-Platform Monitor
Scout runs weekly with 6 targeted searches including cross-platform (search 6). No separate monthly cross-platform monitor needed.

---

## PART 1: REPO STRUCTURE

```
Claudious/
├── README.md
├── CLAUDE.md
├── .gitignore
├── learnings/
│   ├── techniques.md
│   ├── patterns.md
│   ├── gotchas.md
│   ├── behavioral.md
│   ├── antipatterns.md
│   └── platforms/
│       ├── claude.md
│       ├── chatgpt.md
│       ├── grok.md
│       └── perplexity.md
├── skills/
│   └── index.md
├── scout/
│   └── .gitkeep
├── evaluations/
│   ├── processed.log
│   └── .gitkeep
├── queue/
│   ├── deployed.log
│   └── .gitkeep
├── proposals/
│   └── .gitkeep
├── retrospectives/
│   └── .gitkeep
├── snapshots/
│   └── .gitkeep
├── digest/
│   └── .gitkeep
├── research/
│   ├── README.md
│   └── 2026-04-11-grok-sweep.md
├── alerts.md
├── scripts/
│   ├── sync-knowledge.sh
│   ├── backup-config.sh
│   └── rollback-config.sh
└── docs/
    └── learnings.md
```

---

## PART 2: FILE CONTENTS

### README.md
```markdown
# Claudious — Living Intelligence Base

**Owner:** logancallen
**Purpose:** Fully automated cross-project, cross-platform intelligence system.
Connected to ALL Claude Projects as a global knowledge source.

## This Repo Is Global
Every Claude Project connects here as a knowledge source. Intelligence captured
here is available in every future session across all projects automatically.

## Automated Components
| Component | What It Does | Frequency |
|---|---|---|
| Scout | 6-search web sweep for new techniques + cross-platform | Weekly |
| Evaluator | Triages scout findings against current config | Weekly |
| Pioneer | Proposes self-improvements to Claude config | Monthly |
| Auto-Harvest | Fallback BUG/GOTCHA capture from CC sessions | Daily |
| Retrospective | Prunes, validates, promotes, graduates skills | Monthly |
| Drift Detector | Compares schema docs vs actual DB | Weekly |
| Config Backup | Snapshots all Claude config files | Weekly |
| Digest | Weekly summary of all system outputs | Weekly |
| Handoff Writer | Writes session handoff at session end | Per session |

## Manual Actions (Logan only)
- "approved" after harvest review
- queue/ — deploy ready improvements (~5 min/week)
- proposals/ — review judgment calls (~10 min/month)
- queue/deployed.log — one line when deploying (~10 sec)
- Sync button in Claude Project UI after pushes

## Alert System
alerts.md is checked at every session start. CRITICAL alerts surface immediately.

## Emergency Rollback
bash scripts/rollback-config.sh YYYY-MM-DD

## File Index
- learnings/techniques.md — Claude techniques (cross-project)
- learnings/patterns.md — Architecture and workflow patterns
- learnings/gotchas.md — Silent failures, edge cases
- learnings/behavioral.md — User Preferences candidates
- learnings/antipatterns.md — Token waste, output-degrading patterns
- learnings/platforms/*.md — Platform-specific findings
- skills/index.md — Master index of ALL skills across ALL projects
- scout/ — Weekly web research outputs
- evaluations/ — Triage results + processed.log
- queue/ — Ready-to-deploy improvements + deployed.log
- proposals/ — Improvements needing human judgment
- retrospectives/ — Monthly analysis reports
- snapshots/ — Weekly config backups
- digest/ — Weekly system digests
- alerts.md — Active system alerts

## Graduation Pipeline
1. Learning appears in learnings/*.md
2. Pattern cited 3+ times → retrospective flags as graduation candidate
3. Pioneer generates skill file → queue/ for approval
4. After approval: skill created, learning archived
```

### CLAUDE.md
```markdown
# Claudious — Claude Code Instructions

## Purpose
Global intelligence base for Logan's entire Claude ecosystem.
Connected to ALL Claude Projects. Fully automated capture and deployment.

## Rules
- Append-only — move stale entries to Archive, never delete
- Every entry self-contained — no cross-references that break RAG
- Entry format: date, category, severity, context, learning, applies-to
- Keep each file under 200 lines — create new files when approaching limit
- After any change: git add . && git commit -m "learnings: [date] [category] — [title]" && git push

## Entry Format
### [DATE] — [CATEGORY] — [Title]
**Severity:** CRITICAL / HIGH / LOW
**Context:** [1 sentence — what was happening]
**Learning:** [Specific, actionable insight]
**Applies to:** [Projects, files, workflows, or platforms affected]

## Categories
- BUG — Root cause + fix
- PATTERN — Reusable architecture or workflow pattern
- GOTCHA — Silent failure, non-obvious behavior, edge case
- DECISION — Architecture decision with rationale
- TECHNIQUE — Claude/tool/workflow technique that improved output
- DOMAIN — Business or domain knowledge
- PERF — Performance finding with specific numbers
- BEHAVIORAL — Claude behavior finding affecting User Preferences
- ANTIPATTERN — Token waste or output-degrading pattern

## Emergency Rollback
If a Pioneer-queued change breaks something:
bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD

## Related Scripts
- scripts/sync-knowledge.sh — one-command knowledge push
- scripts/backup-config.sh — weekly config snapshot
- scripts/rollback-config.sh — restore config from snapshot
```

### alerts.md
```markdown
# Active Alerts
<!-- Written by automated systems. Checked at every session start. -->
<!-- Format: [DATE] [SEVERITY: CRITICAL/HIGH/LOW] [SYSTEM] [Message] -->
<!-- Clear an alert by deleting its line after addressing it. -->

## Current Alerts
(None)
```

### evaluations/processed.log
```
# Evaluator processed findings log — append only
# Format: [DATE] [FINDING-ID] [DISPOSITION: QUEUED|PROPOSED|REDUNDANT|CONFLICT]
# Finding ID format: [scout-date]-[title-slug]
```

### queue/deployed.log
```
# Pioneer/Evaluator deployed improvements log
# Format: [DATE-DEPLOYED] [IMPROVEMENT-NAME] [RESULT: WORKING|BROKE|UNCLEAR] [NOTES]
# Logan adds one line here after deploying any queued improvement
```

### skills/index.md
```markdown
# Global Skills Index — All Projects
Auto-updated by Pioneer when new skills are created anywhere.

## Global (~/.claude/skills/)
| Skill | Trigger Phrases | Maturity |
|---|---|---|
| harvest | harvest this, what have we learned, capture learnings | New |
| pioneer | improve claude, optimize setup, self-improve, audit config | New |
| project-router | where should I do X, which project handles, route this | New |
| caveman | (internal — auto-loads for token reduction) | New |

## ASF Graphics (.claude/skills/)
| Skill | Trigger Phrases | Maturity |
|---|---|---|
| deploy-checklist | deploy, push to production, ship | Stable |
| schema-migration | migration, schema change, add column, RLS | Stable |
| component-build | build component, create page, add UI | Stable |

## Courtside Pro (.claude/skills/)
| Skill | Trigger Phrases | Maturity |
|---|---|---|
| deploy | deploy, push to production, go live | Stable |
| schema-migration | migration, schema change, database | Stable |
| knowledge-sync | sync knowledge, update docs, refresh files | Stable |

## Graduation Candidates
(Populated by monthly retrospective when patterns appear 3+ times)
```

### learnings/techniques.md
```markdown
# Techniques — Cross-Claude Intelligence
<!-- Auto-maintained. Keep under 200 lines. Archive stale entries at bottom. -->

## Active Techniques

### 2026-04-11 — TECHNIQUE — GitHub Closed-Loop Knowledge Sync
**Severity:** CRITICAL
**Context:** Discovered building Courtside Pro — the agent with ground truth should maintain knowledge files.
**Learning:** Store all Claude Project knowledge files in docs/ inside the project GitHub repo. Connect Claude Project to repo via GitHub sync. Claude Code updates docs/ files in same commit as code changes. Hit Sync in Claude Project UI after pushing. Result: knowledge files always current, version-controlled, maintained by the agent with ground truth — never manually by Logan.
**Applies to:** All Claude Projects with a GitHub repo

### 2026-04-11 — TECHNIQUE — MEMORY.md Separation from CLAUDE.md
**Severity:** CRITICAL
**Context:** Discovered during deep architecture research — facts and instructions should live in separate systems.
**Learning:** CLAUDE.md = instructions (what to do). MEMORY.md at ~/.claude/projects/[project]/memory/MEMORY.md = facts (what Claude knows). Mixing them degrades both. MEMORY.md auto-loads into every session's system prompt (first 200 lines / ~25KB). Create one per project, populate with: incidents, gotchas, architecture decisions, current status.
**Applies to:** All Claude Code projects

### 2026-04-11 — TECHNIQUE — Path-Scoped Rules via .claude/rules/
**Severity:** HIGH
**Context:** Rules that only apply in certain directories shouldn't load every message.
**Learning:** Create .claude/rules/ with individual .md files containing YAML frontmatter paths: ["frontend/**"]. Rules only activate when Claude edits files in those paths. Keeps CLAUDE.md lean while enforcing domain-specific standards precisely. Use for frontend/, backend/, migrations/ domains.
**Applies to:** All Claude Code projects with distinct domain directories

### 2026-04-11 — TECHNIQUE — Env Var Layer for Claude Code Tuning
**Severity:** HIGH
**Context:** Discovered via March 2026 source leak — Claude Code has internal controls exposed as env vars.
**Learning:** Add to shell profile: CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 (fixes April 2026 quality nerf), CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000 (extends auto-compact threshold), CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (pins sub-agents to 1M context vs Opus 200k cap), CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true (enables team coordination), CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1 (prevents retry double-work).
**Applies to:** All Claude Code sessions globally — add to shell profile on both Mac and PC

### 2026-04-11 — TECHNIQUE — Skill YAML Full Spec
**Severity:** HIGH
**Context:** Most builders only use name and description — full spec unlocks tool restrictions, effort control, path scoping.
**Learning:** Full skill frontmatter: effort (tiny/small/medium/large/epic), allowed-tools (restrict tool access), paths (scope to directories), model (override per skill), context (none/inherited/fork), agent (spawn sub-agent). Triggering is semantic — name and description ONLY. Add exclusion phrases directly in description text: "Do NOT trigger for: [list]". No negatives: YAML field exists — that field is invalid.
**Applies to:** All Claude Code skills across all projects

### 2026-04-11 — TECHNIQUE — Post-Commit Hook for Auto-Knowledge Updates
**Severity:** HIGH
**Context:** Claude Code should update knowledge files as part of commits, not as an afterthought.
**Learning:** Create .claude/hooks/post-commit that inspects changed files and updates relevant docs/ files. migrations/* → update docs/schema-state.md. source files → update docs/codebase-state.md. functions/* → flag docs/business-rules.md. Use managed <!-- BEGIN: --> <!-- END: --> blocks so hook updates in place without duplicating. Wire with: git config core.hooksPath .claude/hooks (must re-verify each session on PC).
**Applies to:** All Claude Code projects with docs/ knowledge sync

### 2026-04-11 — TECHNIQUE — Sync Script for One-Command Knowledge Push
**Severity:** HIGH
**Context:** Built for Courtside Pro as the final step in the knowledge sync loop.
**Learning:** Create scripts/sync-knowledge.sh that warns on stale docs/ files, commits pending changes with "docs: auto-sync knowledge files", pushes to main, prints Sync reminder listing ALL connected Claude Projects. Run after every session. Wire git identity first using local (not --global) config on Windows when bash doesn't read global config.
**Applies to:** All Claude Code projects with GitHub sync

## Archive
```

### learnings/patterns.md
```markdown
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

## Archive
```

### learnings/gotchas.md
```markdown
# Gotchas — Silent Failures and Non-Obvious Behaviors
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Gotchas

### 2026-04-11 — GOTCHA — PostgREST Silent 1000-Row Truncation
**Severity:** CRITICAL
**Context:** Root cause of persistent vehicle/trailer dropdown bug in ASF Graphics that survived multiple fix attempts.
**Learning:** PostgREST truncates DISTINCT query results at 1000 rows silently — no error, no warning. Truncation occurred alphabetically at "Honda". Fix: always add .limit() with explicit count or use range headers on any query that could return large result sets. This is PostgREST default behavior, not a bug. Every Supabase query returning >500 rows needs explicit pagination.
**Applies to:** ASF Graphics, Courtside Pro — any Supabase query with large result sets

### 2026-04-11 — GOTCHA — Windows Bash git config --global Not Sticking
**Severity:** HIGH
**Context:** Setting up git identity for Courtside Pro sync script on PC.
**Learning:** On Windows, bash sessions may not read same git global config as PowerShell. git config --global user.email fails silently — git still reports "Author identity unknown". Fix: use git config (no --global flag) to set identity at repo level. Or set credential.helper to manager via Windows Credential Manager. Always verify: git config user.email after setting.
**Applies to:** All git operations from bash on Windows PC

### 2026-04-11 — GOTCHA — CRLF Line Ending Warnings on Hook Files
**Severity:** LOW
**Context:** Committing post-commit hook and sync script from Windows PC.
**Learning:** Git on Windows converts LF to CRLF when touching shell scripts, breaking bash execution. Fix: git config core.autocrlf false, then re-add and recommit affected files. All hook files and .sh scripts must use LF line endings to execute in bash.
**Applies to:** All shell scripts and hook files committed from Windows PC

### 2026-04-11 — GOTCHA — Skill negatives: YAML Field Does Not Exist
**Severity:** HIGH
**Context:** Community incorrectly reported this as a valid YAML field.
**Learning:** There is no negatives: YAML field in Claude Code skill frontmatter. To prevent skill misfires, add exclusion phrases directly in the description text: "Do NOT trigger for: staging deploys, preview builds, local testing." Triggering is semantic — only name and description influence auto-triggering. Max ~34-36 skills before available_skills block truncates.
**Applies to:** All Claude Code skills

### 2026-04-11 — GOTCHA — RAG Activates Earlier Than Expected
**Severity:** HIGH
**Context:** Deep architecture research on Claude Projects.
**Learning:** Claude Projects activate RAG at surprisingly low context usage (as low as 2-6%) when many files exist — not just when approaching the limit. Files may already be RAG-chunked even in small projects. Files over 5KB need RAG-optimized structure regardless of total project size.
**Applies to:** All Claude Projects with multiple knowledge files

### 2026-04-11 — GOTCHA — core.hooksPath Must Be Verified Each Session on PC
**Severity:** HIGH
**Context:** Post-commit hook wired but not firing on Courtside Pro.
**Learning:** git config core.hooksPath .claude/hooks must be set per repo. On PC it may not persist reliably across sessions. Verify at start of any Claude Code session involving hooks: git config core.hooksPath. If empty: re-run git config core.hooksPath .claude/hooks. Add verification to session-start hook output.
**Applies to:** All Claude Code projects using .claude/hooks/ on Windows PC

## Archive
```

### learnings/behavioral.md
```markdown
# Behavioral — Claude Model Behavior Findings
<!-- Entries here are User Preferences candidates. Review monthly. -->

## Active Behavioral Findings

### 2026-04-11 — BEHAVIORAL — Claude 4.x Fixates on Negative Instructions
**Severity:** CRITICAL
**Context:** DreamHost empirical testing, confirmed in deep architecture research.
**Learning:** Claude 4.x paradoxically increases attention on things you tell it NOT to do. "Don't write a fluffy intro" → Claude focuses on fluff. Fix: reframe ALL negative instructions as positive direction. "Don't write fluffy intro" → "Begin directly with core argument." Applies to CLAUDE.md, skills, User Preferences, prompts. Audit all "never," "don't," "avoid" instructions and rewrite positively.
**Applies to:** User Preferences, all CLAUDE.md files, all skill descriptions, all prompts

### 2026-04-11 — BEHAVIORAL — Context-Before-Question Yields 30% Better Results
**Severity:** HIGH
**Context:** Empirically validated by DreamHost testing on Claude 4.x.
**Learning:** On long-context prompts, place all reference material BEFORE the question. Claude weights end of context most heavily — question at end has maximum attention. For prompts under 5K tokens: doesn't matter. For long prompts (large docs, code, research): always structure as [all context] → [question last].
**Applies to:** All Claude.ai sessions with substantial reference material

### 2026-04-11 — BEHAVIORAL — Adaptive Thinking Nerf (April 2026)
**Severity:** HIGH
**Context:** Community-wide discovery post April 2026 Anthropic update.
**Learning:** Anthropic shipped adaptive thinking throttle in early April 2026 that reduces reasoning depth on routine tasks. Fix: CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 env var bypasses throttling. Also: effortLevel: max in ~/.claude/settings.json. Use /effort high or ultrathink keyword for one-turn deep reasoning.
**Applies to:** All Claude Code sessions — add env var to shell profile

### 2026-04-11 — BEHAVIORAL — Skill Triggering is Semantic Name+Description Only
**Severity:** HIGH
**Context:** Confirmed via deep architecture research and official skill guide.
**Learning:** Claude matches skills semantically against name and description fields ONLY. No other YAML fields influence auto-triggering. Write descriptions with explicit trigger phrases and exclusion phrases inline. Cap: ~34-36 skills before available_skills block truncates and skills stop matching entirely.
**Applies to:** All Claude Code and Claude.ai skill design

## Archive
```

### learnings/antipatterns.md
```markdown
# Antipatterns — Token Waste and Output-Degrading Patterns
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Antipatterns

### 2026-04-11 — ANTIPATTERN — Bloated CLAUDE.md with Domain Knowledge
**Severity:** HIGH
**Context:** April 7 optimization sprint.
**Learning:** CLAUDE.md is loaded on every single message — not per session, every prompt. Domain knowledge in CLAUDE.md costs tokens on every message regardless of relevance. Move domain knowledge to .claude/skills/ (on-demand) or docs/knowledge/ (reference). Only rules that must fire on every message belong in CLAUDE.md. Target: under 150 lines.
**Applies to:** All Claude Code projects

### 2026-04-11 — ANTIPATTERN — ALL CAPS Emphasis in Claude 4.x
**Severity:** HIGH
**Context:** DreamHost empirical testing.
**Learning:** ALL CAPS emphasis is ignored in Claude 4.x in favor of logic and context. Intensity modifiers like "L99:" have no effect. Replace with conditional phrasing: "If X is available, do Y, else do Z." Never use all-caps for emphasis in any instruction.
**Applies to:** All prompts, CLAUDE.md files, User Preferences

### 2026-04-11 — ANTIPATTERN — Connecting Unused MCP Servers
**Severity:** HIGH
**Context:** April 7 MCP audit — each server costs significant tokens per message.
**Learning:** Every connected MCP server loads full tool definitions into context on every message. One server alone = ~8,400 tokens per message wasted if unused. Disconnect all MCP servers not needed for current task. Reconnect on demand. Audit at start of every Claude Code session via /mcp.
**Applies to:** Claude.ai and Claude Code MCP management

## Archive
```

### learnings/platforms/claude.md
```markdown
# Claude Platform — Specific Findings

## Active Findings

### 2026-04-11 — TECHNIQUE — Claude Max Plan Capabilities (April 2026)
**Severity:** HIGH
**Context:** Setup audit confirmation.
**Learning:** Claude Max ($100/month) includes: Opus 4.6, Sonnet 4.6, Haiku 4.5, 1M token context, Projects, Skills, MCP integrations, Cowork, Web Search, Deep Research, Code Execution, Artifacts. NOT included: Auto mode permissions (Team/Enterprise/API only). AutoDream: server-side rollout, not yet on all accounts — check /memory for toggle. Ultraplan: available, no setup needed, use /ultraplan on next complex task.
**Applies to:** All Claude sessions — plan capability awareness

### 2026-04-11 — TECHNIQUE — Ultraplan for Complex Planning
**Severity:** HIGH
**Context:** Available on Max plan, not yet used on a real task.
**Learning:** /ultraplan offloads complex planning to cloud Anthropic infrastructure running Opus 4.6 with multi-agent exploration. Terminal stays free during planning. Use for any task touching 3+ files or requiring architectural decisions. Don't use for pre-planned execution sprints — it's for cloud planning, not execution.
**Applies to:** Claude Code — complex feature planning

## Archive
```

### learnings/platforms/chatgpt.md
```markdown
# ChatGPT Platform — Specific Findings

## Active Findings

### 2026-04-11 — TECHNIQUE — ChatGPT Deep Research for Architecture Intel
**Severity:** HIGH
**Context:** Used April 11 for comprehensive Claude architecture research sweep.
**Learning:** ChatGPT Pro Deep Research (25-35 min runs) produces highest-quality synthesis of GitHub, blogs, docs, and forums. Superior to Grok for web-wide synthesis. Best for: GitHub repo analysis, documentation synthesis, cross-source comparison. Run monthly with consolidated 8-section prompt targeting specific architecture areas.
**Applies to:** Monthly intelligence research pipeline

## Archive
```

### learnings/platforms/grok.md
```markdown
# Grok Platform — Specific Findings

## Active Findings

### 2026-04-11 — TECHNIQUE — Grok for X/Twitter Real-Time Intelligence
**Severity:** HIGH
**Context:** Used April 11 for Claude power-user intelligence sweep.
**Learning:** Grok Deep Research has exclusive X/Twitter firehose access. Best for: undocumented behaviors shared by builders, real-time technique discovery, community-discovered workarounds. Prioritize posts with >10 likes and substantive reply threads. Filter out AI content creators and course sellers — target independent builders only. Run monthly with consolidated 9-section prompt.
**Applies to:** Monthly intelligence research pipeline

## Archive
```

### learnings/platforms/perplexity.md
```markdown
# Perplexity Platform — Specific Findings

## Active Findings

### 2026-04-11 — TECHNIQUE — Perplexity for Citation-First Research
**Severity:** HIGH
**Context:** Established routing from task routing table.
**Learning:** Perplexity Pro wins on: live web search with citations, competitive intelligence, vendor scouting, procurement research, quick factual lookups requiring source verification. Every answer cited by default — audit-ready sourcing. Use before Claude for any research requiring verifiable sources. Not for long-form writing or synthesis.
**Applies to:** Research tasks requiring citations

## Archive
```

### research/README.md
```markdown
# Research Pipeline Index

## Cadence
| Frequency | Action | Surface | Time |
|---|---|---|---|
| Weekly | Scout automated 6-search sweep (includes cross-platform) | CC Scheduled | Auto |
| Weekly | Evaluator triage of scout output | CC Scheduled | Auto |
| Monthly | Grok full 9-section sweep | Manual | 45 min |
| Monthly | ChatGPT Pro Deep Research 8-section sweep | Manual | 30 min wait |
| After Anthropic release | G-08 + behavioral section | Manual | 20 min |
| Quarterly | Full both prompts + DISTILL | Manual | 4 hrs |

## Process
1. Manual sweeps → paste into Claude Mastery Lab → DISTILL
2. Approved techniques → playbook + claudious/learnings/techniques.md
3. Scout sweeps → Evaluator triages → queue/ or proposals/
4. All research saved to research/YYYY-MM-DD-[source]-sweep.md
```

### research/2026-04-11-grok-sweep.md
```markdown
# Grok Research Sweep — April 11, 2026

**Type:** Full 9-section sweep
**Processed:** Yes — DISTILL complete in Claude Mastery Lab
**Techniques extracted:** 7 new (CC-019 through CC-025, PA-002)

## Key Findings
- CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 — fixes April 2026 quality nerf
- /batch for parallel agent fan-out — 24 agents from one prompt (Boris Cherny pattern)
- Caveman skill — 75% internal token reduction (JuliusBrussee/caveman)
- Dynamic /loop with Monitor tool — intelligent scheduling vs fixed interval
- Self-eval pattern — agents improve their own skills post-task
- Success criteria > cautions in CLAUDE.md

## Status
All findings processed into Mastery Lab playbook. Cross-project techniques copied to learnings/techniques.md.
```

### docs/learnings.md
```markdown
# Claudious — Project Learnings

## Active Learnings

### 2026-04-11 — DECISION — Claudious Architecture
**Severity:** CRITICAL
**Context:** April 11, 2026 design session.
**Learning:** Claudious connects to ALL Claude Projects as global knowledge source. Per-project learnings stay in each project's docs/learnings.md. Cross-project techniques, patterns, gotchas route to Claudious learnings/. Harvest skill produces dual CC prompts: one for project repo, one for Claudious. After both pushes, click Sync in both Claude Project UIs.
**Applies to:** All sessions — routing and sync decisions

### 2026-04-11 — DECISION — Queue vs Proposals Architecture
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** queue/ = SAFE + HIGH impact + TRIVIAL effort items Claude deploys with one-word approval. proposals/ = anything requiring human judgment (User Preferences, production code, schema, deletes). Pioneer never auto-deploys. queue/deployed.log tracks what was actually implemented and whether it worked — Pioneer reads this to calibrate future proposals.
**Applies to:** Pioneer skill, Evaluator scheduled task

### 2026-04-11 — DECISION — Primary vs Fallback Auto-Harvest
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** Primary harvest mechanism is SessionEnd directive in global CLAUDE.md (fires in-context, can read conversation). Daily scheduled task is FALLBACK only — catches sessions where SessionEnd hook was skipped. Never treat scheduled task as primary or duplicates accumulate.
**Applies to:** Auto-harvest architecture

## Archive
```

---

## PART 3: SCRIPTS

### scripts/sync-knowledge.sh
```bash
#!/bin/bash
# One-command knowledge push for Claudious
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/OneDrive/Documents/GitHub/Claudious"
else
    REPO_PATH="$HOME/Projects/claudious"
fi

cd "$REPO_PATH"

# Check for stale files
STALE=$(find learnings/ -name "*.md" -mtime +7 -type f 2>/dev/null)
if [ -n "$STALE" ]; then
    echo "⚠️  Stale files (not modified in 7+ days):"
    echo "$STALE"
fi

# Commit and push if changes exist
DIRS="learnings/ research/ docs/ scout/ evaluations/ queue/ proposals/ retrospectives/ cross-platform/ skills/ digest/ alerts.md"
if ! git diff --quiet $DIRS 2>/dev/null || git ls-files --others --exclude-standard $DIRS 2>/dev/null | grep -q .; then
    git add $DIRS
    git commit -m "docs: auto-sync knowledge files $(date +%Y-%m-%d)"
    git push origin main
    echo ""
    echo "✅ Claudious synced to main."
    echo "📋 Click Sync in ALL connected Claude Project UIs:"
    echo "   - ASF Graphics Claude Project"
    echo "   - Courtside Pro Claude Project"
    echo "   - Court Designer Claude Project"
    echo "   - GE Diesel Claude Project"
    echo "   - Genesis Framework Claude Project"
    echo "   - Claude Mastery Lab Claude Project"
    echo "   - Claudious Claude Project"
else
    echo "ℹ️  No changes to sync."
fi
```

### scripts/backup-config.sh
```bash
#!/bin/bash
# Weekly config backup to claudious/snapshots/
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/OneDrive/Documents/GitHub/Claudious"
    HOME_PATH="C:/Users/logan"
    PROJECTS_PATH="C:/Users/logan/Projects"
    CP_PATH="C:/Users/logan/courtside-pro"
else
    REPO_PATH="$HOME/Projects/claudious"
    HOME_PATH="$HOME"
    PROJECTS_PATH="$HOME/Projects"
    CP_PATH="$HOME/Projects/courtside-pro"
fi

DATE=$(date +%Y-%m-%d)
DEST="$REPO_PATH/snapshots/$DATE"
mkdir -p "$DEST"

# Global Claude config
cp "$HOME_PATH/.claude/CLAUDE.md" "$DEST/global-CLAUDE.md" 2>/dev/null && echo "✅ global CLAUDE.md" || true
cp "$HOME_PATH/.claude/settings.json" "$DEST/global-settings.json" 2>/dev/null && echo "✅ global settings.json" || true
[ -d "$HOME_PATH/.claude/skills/" ] && cp -r "$HOME_PATH/.claude/skills/" "$DEST/global-skills/" && echo "✅ global skills" || true
[ -d "$HOME_PATH/.claude/agents/" ] && cp -r "$HOME_PATH/.claude/agents/" "$DEST/global-agents/" && echo "✅ global agents" || true

# Per-project configs
for project in asf-graphics-app; do
    PPATH="$PROJECTS_PATH/$project"
    if [ -d "$PPATH/.claude" ]; then
        mkdir -p "$DEST/$project"
        cp -r "$PPATH/.claude/" "$DEST/$project/.claude/" 2>/dev/null || true
        cp "$PPATH/CLAUDE.md" "$DEST/$project/CLAUDE.md" 2>/dev/null || true
        echo "✅ $project"
    fi
done

# Courtside Pro (different path on PC)
if [ -d "$CP_PATH/.claude" ]; then
    mkdir -p "$DEST/courtside-pro"
    cp -r "$CP_PATH/.claude/" "$DEST/courtside-pro/.claude/" 2>/dev/null || true
    cp "$CP_PATH/CLAUDE.md" "$DEST/courtside-pro/CLAUDE.md" 2>/dev/null || true
    echo "✅ courtside-pro"
fi

cd "$REPO_PATH"
git add snapshots/
git commit -m "backup: config snapshot $DATE"
git push origin main
echo "✅ Config backed up to snapshots/$DATE"
```

### scripts/rollback-config.sh
```bash
#!/bin/bash
# Restore Claude config from a snapshot
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/OneDrive/Documents/GitHub/Claudious"
    HOME_PATH="C:/Users/logan"
else
    REPO_PATH="$HOME/Projects/claudious"
    HOME_PATH="$HOME"
fi

if [ -z "$1" ]; then
    echo "Usage: bash scripts/rollback-config.sh YYYY-MM-DD"
    echo ""
    echo "Available snapshots:"
    ls "$REPO_PATH/snapshots/"
    exit 1
fi

DATE="$1"
SNAPSHOT="$REPO_PATH/snapshots/$DATE"

if [ ! -d "$SNAPSHOT" ]; then
    echo "❌ No snapshot found for $DATE"
    echo "Available: $(ls $REPO_PATH/snapshots/)"
    exit 1
fi

echo "⚠️  Restoring Claude config from $DATE snapshot..."
echo "This will overwrite current ~/.claude/ config files."
read -p "Type 'yes' to confirm: " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 0
fi

# Restore
[ -f "$SNAPSHOT/global-CLAUDE.md" ] && cp "$SNAPSHOT/global-CLAUDE.md" "$HOME_PATH/.claude/CLAUDE.md" && echo "✅ global CLAUDE.md restored"
[ -f "$SNAPSHOT/global-settings.json" ] && cp "$SNAPSHOT/global-settings.json" "$HOME_PATH/.claude/settings.json" && echo "✅ global settings.json restored"
[ -d "$SNAPSHOT/global-skills/" ] && cp -r "$SNAPSHOT/global-skills/." "$HOME_PATH/.claude/skills/" && echo "✅ global skills restored"
[ -d "$SNAPSHOT/global-agents/" ] && cp -r "$SNAPSHOT/global-agents/." "$HOME_PATH/.claude/agents/" && echo "✅ global agents restored"

echo ""
echo "✅ Rollback complete from snapshot $DATE"
echo "Verify restored files and restart Claude Code."
```

---

## PART 4: HARVEST SKILL (Claude.ai user-level)

Create /mnt/skills/user/harvest/SKILL.md:

```yaml
---
name: harvest
description: >
  Session knowledge harvester. Extracts durable learnings from the current
  conversation and formats ready-to-paste Claude Code prompts to append
  structured entries to the project's docs/learnings.md AND the Claudious
  global repo. Trigger on: "what have we learned," "harvest this," "capture
  learnings," "session takeaways," "extract insights," "what should we
  remember," "update learnings," "capture knowledge," "save session
  intelligence." Works in any project. Do NOT trigger for: greetings,
  status checks, or requests unrelated to knowledge capture.
---
```

SKILL.md body:
```markdown
# Harvest — Session Knowledge Extractor

## What This Skill Does
Scans current conversation for durable knowledge. Produces two Claude Code
prompts: one for project-level docs/learnings.md, one for Claudious global
repo. One approval triggers autonomous execution of both.

## Step 1: Identify Target Project
| Project | Mac Path | PC Path | Learnings File |
|---|---|---|---|
| ASF Graphics | ~/Projects/asf-graphics-app/ | C:\Users\logan\Projects\asf-graphics-app\ | docs/learnings.md |
| Courtside Pro | ~/Projects/courtside-pro/ | C:\Users\logan\courtside-pro\ | docs/learnings.md |
| Court Designer | ~/Projects/court-designer/ | C:\Users\logan\Projects\court-designer\ | docs/learnings.md |
| GE Diesel | ~/Projects/ge-diesel/ | C:\Users\logan\Projects\ge-diesel\ | docs/learnings.md |
| Claudious | ~/Projects/claudious/ | C:\Users\logan\OneDrive\Documents\GitHub\Claudious\ | learnings/[category].md |
| Claude Mastery Lab | (no repo) | (no repo) | Format as playbook entries |
| Genesis Framework | (no repo) | (no repo) | Format as decision log entries |
| Forensic Investigation | SENSITIVE — ask Logan before capturing anything | | |

**If project not in table:** Ask Logan for the repo path. Add: "Also update harvest skill routing table with this project's paths."

## Step 2: Scan and Extract
Review entire conversation. For each piece of durable knowledge:
1. What was learned (specific, actionable)
2. Why it matters
3. What it applies to
4. Category: BUG | PATTERN | GOTCHA | DECISION | TECHNIQUE | DOMAIN | PERF | BEHAVIORAL | ANTIPATTERN
5. Severity: CRITICAL | HIGH | LOW

**Quality bar:** "If a fresh Claude session hit the same situation 3 months from now, would this prevent a mistake or accelerate the solution?" If no → skip.

**Routing:**
- Project-specific bug/fix → project docs/learnings.md only
- Cross-project technique → claudious/learnings/techniques.md
- Architecture pattern → claudious/learnings/patterns.md
- Silent failure/edge case → claudious/learnings/gotchas.md
- Claude behavior finding → claudious/learnings/behavioral.md
- Token waste pattern → claudious/learnings/antipatterns.md
- Platform-specific → claudious/learnings/platforms/[platform].md
- BEHAVIORAL entries → flag: "User Preferences candidate — review in monthly retrospective"
- TECHNIQUE entries → flag: "Mastery Lab candidate — consider promoting to playbook"

**Filter out:** Greetings, status updates, debugging dead-ends, things already in CLAUDE.md or knowledge files, temporary state.

**Max 10 learnings per harvest — prioritize by severity.**

## Step 3: Present for Review
Show Logan numbered list: category, severity, 1-line summary.
Note any cross-project implications or User Preferences candidates.
Wait for "approved" or "skip [N]".

## Step 4: Autonomous Execution After Approval

**Prompt 1 — Project-level (always):**
Open [PROJECT_PATH]. Append to docs/learnings.md (create if missing, preserve header).
Add under ## Active Learnings:

### [DATE] — [CATEGORY] — [Title]
**Severity:** [CRITICAL/HIGH/LOW]
**Context:** [1 sentence]
**Learning:** [The insight]
**Applies to:** [Scope]

git add docs/learnings.md && git commit -m "learnings: [DATE] harvest ([N] entries)" && git push

**Prompt 2 — Claudious-level (if cross-project entries exist):**
Open [CLAUDIOUS_PATH]. Append to learnings/[relevant-file].md.
Same format. git add . && git commit -m "learnings: [DATE] [category] — [title]" && git push

**After both prompts print:**
✅ Learnings captured.
📋 Click Sync in:
   - [Project Name] Claude Project UI
   - Claudious Claude Project UI (if cross-project entries added)
```

---

## PART 5: PIONEER SKILL (Claude Code global)

Create ~/.claude/skills/pioneer/SKILL.md:

```yaml
---
name: pioneer
description: >
  Self-improvement engine for Claude's own configuration. Analyzes CLAUDE.md
  files, skills, hooks, agents, memory, and learnings across all projects.
  Writes SAFE improvements to claudious/queue/ and judgment-required
  improvements to claudious/proposals/. Reads queue/deployed.log to learn
  from past proposals. Trigger on: "improve claude," "optimize setup,"
  "self-improve," "self-optimize," "tune claude," "audit config," "find
  improvements," "pioneer." Do NOT trigger for: application code, database
  schemas, deployment configs, User Preferences changes.
---
```

SKILL.md body:
```markdown
# Pioneer — Claude Self-Improvement Engine

## Step 1: Read Feedback First
Read queue/deployed.log before anything else.
For each deployed improvement: did learnings files mention it working or breaking?
Report: "X deployed [date]. Status: [working/broke/no signal yet]."
Use to calibrate: consistent failures → lower auto-queue threshold. Consistent wins → raise confidence.

## Step 2: Gather Current State
Read (skip missing):
- ~/.claude/CLAUDE.md + settings.json + skills/ + agents/
- ~/Projects/asf-graphics-app/CLAUDE.md + .claude/ + docs/learnings.md
- ~/Projects/courtside-pro/CLAUDE.md + .claude/ + docs/learnings.md
- ~/Projects/claudious/learnings/ + queue/ + proposals/

## Step 3: Analyze
Identify:
1. Dead weight — rules that never trigger or are redundant
2. Unused skills — haven't loaded for recent session topics
3. Graduation candidates — patterns in learnings appearing 3+ times
4. Token inefficiencies — verbose instructions, duplicated rules
5. Missing coverage — common patterns with no skill/hook/rule
6. Stale config — old versions, deprecated features, wrong paths
7. Cross-project inconsistencies — same rule written differently

## Step 4: Classify
- Impact: HIGH / MEDIUM / LOW
- Effort: TRIVIAL / LOW / MEDIUM
- Risk: SAFE / TEST-FIRST / REVIEW-REQUIRED

AUTO-QUEUE if ALL: SAFE + HIGH impact + TRIVIAL effort
PROPOSE everything else

## Step 5: Output
AUTO-QUEUE → ~/Projects/claudious/queue/[improvement-name].md
PROPOSE → ~/Projects/claudious/proposals/[improvement-name].md

For graduation candidates: generate skill file → queue/ for one-word approval

NEVER auto-queue:
- Production application code
- Database schema or migrations
- Deployment configurations
- File deletions
- User Preferences changes
- git remote or credential changes

## Step 6: Report + Alert
Write summary to ~/Projects/claudious/proposals/pioneer-report-[DATE].md
If any HIGH or CRITICAL improvements found: append to alerts.md
cd ~/Projects/claudious && git add . && git commit -m "pioneer: [DATE] ([N] queued, [M] proposed)" && git push
```

---

## PART 6: PROJECT ROUTER SKILL (Claude Code global)

Create ~/.claude/skills/project-router/SKILL.md:

```yaml
---
name: project-router
description: >
  Routes any task or question to the correct Claude Project or repo.
  Triggers when Logan asks "where should I do X," "which project handles Y,"
  "which project is responsible for Z," "which repo," "route this," or
  starts a task without specifying a project context. Also triggers on
  ambiguous cross-project requests. Do NOT trigger for tasks clearly
  within the current project context.
---
```

SKILL.md body:
```markdown
# Project Router

## Project Map
| Project | Handles | Repo | Status |
|---|---|---|---|
| ASF Graphics | ASF app code, schema, deploys, components, migrations | asf-graphics-app | Active |
| Courtside Pro | Courtside app, flooring intel | courtside-pro | Active — demos scheduled |
| Court Designer | SVG court design tool, integration planning | court-designer | Active — maintenance |
| GE Diesel Performance | Client ecommerce build | ge-diesel | Blocked — awaiting founder |
| Genesis Framework | Cross-project strategy, architecture, bootstrapping | none | Active |
| Forensic Investigation | Divorce asset investigation | none | Active — SENSITIVE |
| Claude Mastery Lab | Claude optimization, playbook, research DISTILL | none | Active |
| Claudious | Global intelligence, cross-project learnings | Claudious | Active |

## Routing Rules
- Code/schema/deploys for ASF → ASF Graphics
- Cross-project strategy, architecture → Genesis Framework
- Claude optimization, technique research → Claude Mastery Lab
- Learnings capture, cross-project intelligence → Claudious
- Sensitive investigation → Forensic Investigation ONLY, never cross-reference
- On hold projects → bugs and planning only, no new features

## Output
"Route to: [Project Name]
Why: [One sentence]
First action: [Specific next step]"

## Fallback
Task spans multiple projects → route to Genesis Framework to decide first.
Project not in table → ask Logan for repo path, then update this skill file.
```

---

## PART 7: CUSTOM SUBAGENTS

Create ~/.claude/agents/:

### rls-auditor.md
```yaml
---
name: rls-auditor
isolation: worktree
model: claude-sonnet-4-6
effort: high
---
```
```
Supabase RLS policy auditor.
Check: SELECT without user filtering, INSERT not setting user_id from auth.uid(),
UPDATE/DELETE with overly broad conditions, missing policies (default deny must be explicit),
policies on base tables instead of views (financial data exposure).
Output severity-rated findings: CRITICAL=data leaks, HIGH=too permissive, LOW=style issue.
```

### context-scout.md
```yaml
---
name: context-scout
isolation: worktree
model: claude-sonnet-4-6
effort: medium
---
```
```
Codebase explorer. Read files, return compressed summary under 200 lines. Never modify files.
Include: file paths, key functions, data flow, dependencies, anything surprising.
```

### migration-validator.md
```yaml
---
name: migration-validator
isolation: worktree
model: claude-sonnet-4-6
effort: high
---
```
```
Database migration validator.
Check: contradicts schema-state.md or business-rules.md, missing RLS for new tables,
no rollback path, naming convention (NNN_description.sql).
Output: SAFE / WARNING (proceed with notes) / BLOCK (do not apply + reasons).
```

### ASF-specific agents in asf-graphics-app/.claude/agents/:

### builder.md
```yaml
---
name: BuilderAgent
isolation: worktree
tools: [bash, read, write, typescript-lsp]
model: claude-sonnet-4-6
effort: medium
---
```
```
Frontend React agent. Scope: src/, components/, frontend/ only.
Skills: component-build, asf-ux-design.
Never touch: migrations/, backend/, auth logic.
Output: Working component + PR.
```

### migrator.md
```yaml
---
name: MigratorAgent
isolation: worktree
tools: [bash, read, write]
model: claude-sonnet-4-6
effort: large
---
```
```
Database migration agent. Scope: migrations/, supabase/ only.
Skills: schema-migration. Required before PR: SELECT * FROM pg_policies.
Never touch: frontend files. Output: Migration + rollback + verification + PR.
```

### deployer.md
```yaml
---
name: DeployerAgent
isolation: worktree
tools: [bash, read]
model: claude-sonnet-4-6
effort: medium
---
```
```
Pre-deploy verification agent. Skills: deploy-checklist.
Never push unless all checks pass. Output: Checklist completed + push executed.
```

---

## PART 8: GLOBAL CLAUDE.MD SESSION LIFECYCLE

Add to ~/.claude/CLAUDE.md:

```markdown
## Session Lifecycle (non-negotiable)

### On Session Start
1. Check .claude/handoff.md — if exists, read and acknowledge prior state
2. Check ~/Projects/claudious/alerts.md — if CRITICAL alerts: surface immediately ("🚨 Alert: [message]")
3. Check ~/Projects/claudious/digest/ — if digest exists under 7 days old, surface Action Required section
4. Scan docs/learnings.md for CRITICAL and HIGH entries relevant to today's task
5. Check Claudious learnings/ for cross-project relevant entries (available via project knowledge)
6. Surface any CRITICAL learnings: "⚠️ Relevant learning: [title] — [1-line summary]"
7. Check .claude/last-retrospective — if over 30 days: "⚠️ Monthly retrospective due"
8. Verify: git config core.hooksPath (should return .claude/hooks — re-set if empty)

### On Session End
1. Write .claude/handoff.md: completed tasks, pending tasks, blockers, next action (under 30 lines)
2. If session involved debugging, unexpected behavior, or non-obvious discovery:
   Append BUG or GOTCHA entry to docs/learnings.md (standard format)
   git add docs/learnings.md && git commit -m "auto-harvest: [date]" && git push
3. If routine build session with no surprises: skip auto-harvest
4. Run bash scripts/sync-knowledge.sh (project) if applicable
5. Print: "✅ Session complete. Click Sync in [project] and Claudious Claude Project UIs."

## Emergency Rollback
bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD
```

---

## PART 9: SCHEDULED TASKS

### Cowork Scheduled Tasks (Claude Desktop /schedule)

**SCOUT — Weekly (Sunday 8am)**
```
Run all 6 searches. Aggregate and deduplicate. Max 15 findings total.

Search 1: "Claude Code env vars flags undocumented 2026"
Search 2: "CLAUDE.md optimization techniques production 2026"
Search 3: "Claude Code subagent parallel workflow patterns"
Search 4: "Claude Code hooks skills marketplace new features"
Search 5: "Claude Code MCP integration production patterns"
Search 6: "ChatGPT Grok Perplexity new capabilities features [current month] 2026"

For each finding extract only:
- Specific implementation steps (not opinions)
- Source URL
- Risk: SAFE | TEST-FIRST | REVIEW-REQUIRED

Save to scout/weekly-YYYY-MM-DD.md:
### [Title]
**Source:** [URL]
**Finding-ID:** [YYYY-MM-DD]-[title-slug]
**Category:** COMMAND | CONFIG | SKILL | PLUGIN | WORKFLOW | PATTERN | CROSS-PLATFORM
**What it does:** [2 sentences max]
**Implementation:** [Specific steps]
**Risk:** SAFE | TEST-FIRST | REVIEW-REQUIRED

If any HIGH or CRITICAL findings: append to alerts.md
cd ~/Projects/claudious && git add scout/ alerts.md && git commit -m "scout: weekly YYYY-MM-DD" && git push
```

**RETROSPECTIVE — Monthly (1st, 10am)**
```
For each active project (asf-graphics-app, courtside-pro, claudious):
1. Read docs/learnings.md (or learnings/*.md for claudious)
2. Flag entries older than 90 days for archive
3. Count citation frequency — any pattern cited 3+ times = graduation candidate
4. For graduation candidates: generate skill file → write to queue/
5. Flag TECHNIQUE entries for claudious promotion
6. Flag BEHAVIORAL entries confirmed multiple times → proposals/ for User Preferences update
7. Check for entries contradicted by current code → archive with note
8. Update .claude/last-retrospective with today's date: echo "$(date +%Y-%m-%d)" > .claude/last-retrospective

Save report to retrospectives/YYYY-MM.md
cd ~/Projects/claudious && git add . && git commit -m "retrospective: YYYY-MM" && git push
```

**DIGEST — Weekly (Friday 5pm)**
```
Read all system outputs from this week:
- scout/weekly-[this week].md — findings count
- evaluations/[this week].md — queued/proposed/redundant counts
- auto-harvest commits in all project repos — learnings captured
- docs/drift-report.md in asf-graphics-app — drift found or not
- alerts.md — active alerts
- queue/ file count (excluding deployed.log)
- proposals/ file count

Write to digest/YYYY-WW.md:

# Weekly Digest — Week [N], [DATE RANGE]

## Intelligence
- Scout found: [N] new techniques
- Evaluator queued: [N] ready to deploy, [N] need review
- Cross-platform: [notable changes if any]

## Knowledge Capture
- Auto-harvest captured: [N] learnings
- Total learnings added this week: [N]

## System Health
- Schema drift: NONE / [N issues — see drift-report.md]
- Active alerts: [N]
- Config backup: COMPLETED / FAILED

## Action Required
- queue/ has [N] items ready to deploy (~5 min to review)
- proposals/ has [N] items needing judgment (~10 min to review)
[List any CRITICAL alerts]

cd ~/Projects/claudious && git add digest/ && git commit -m "digest: YYYY-WW" && git push
```

### Claude Code Cloud Scheduled Tasks

**EVALUATOR — Weekly (Monday 8am)**
```
Repo: claudious
1. Read most recent file in scout/
2. Read evaluations/processed.log — skip any finding whose ID already appears there
3. For each NEW finding, cross-reference against:
   - ~/.claude/CLAUDE.md
   - ~/Projects/asf-graphics-app/CLAUDE.md
   - ~/Projects/claudious/learnings/techniques.md
   - Existing queue/ and proposals/
4. Classify each new finding:
   REDUNDANT → skip, log to processed.log as REDUNDANT
   CANDIDATE SAFE (SAFE risk) → write to queue/[finding-name].md, log as QUEUED
   CANDIDATE REVIEW → write to proposals/[finding-name].md, log as PROPOSED
   CONFLICT → write to proposals/[finding-name].md with conflict noted, log as CONFLICT
5. Append all processed finding IDs to evaluations/processed.log
6. Write triage summary to evaluations/YYYY-MM-DD.md
git add . && git commit -m "evaluator: YYYY-MM-DD" && git push
```

**PIONEER — Monthly (2nd, 8am)**
```
Repo: claudious
Run pioneer self-improvement analysis.
First: read queue/deployed.log for feedback on past proposals.
Then: analyze all Claude config files across projects.
Write SAFE findings to queue/, judgment calls to proposals/.
Write summary to proposals/pioneer-report-YYYY-MM.md
If HIGH/CRITICAL findings: append to alerts.md
git add . && git commit -m "pioneer: YYYY-MM" && git push
```

**DRIFT DETECTOR — Weekly (Wednesday 8am)**
```
Repo: asf-graphics-app
Compare docs/schema-state.md against actual Supabase schema.
Query information_schema for tables, columns, RLS policies.
Flag: tables in DB not in docs, vice versa, column differences, RLS differences.
If drift found: append to claudious/alerts.md: "[DATE] HIGH DRIFT [description]"
Save to docs/drift-report.md
git add docs/drift-report.md && git commit -m "drift: YYYY-MM-DD" && git push
```

**CONFIG BACKUP — Weekly (Saturday 8am)**
```
Repo: claudious
Run scripts/backup-config.sh
Verify snapshot created in snapshots/YYYY-MM-DD/
Confirm push succeeded.
```

**AUTODREAM CHECK — Weekly (Sunday 9am)**
```
Repo: claudious
Run /memory in Claude Code. Check if Auto-dream toggle is available.
If available: enable it, run /dream, add TECHNIQUE entry to learnings/techniques.md
If not: append to evaluations/autodream-checks.md: "[DATE] Still not available"
git add . && git commit -m "autodream-check: YYYY-MM-DD" && git push
```

### Claude Code Desktop

**AUTO-HARVEST FALLBACK — Daily (11pm)**
```
FALLBACK ONLY — primary harvest is SessionEnd directive in CLAUDE.md.

Check all project repos for sessions modified today that do NOT have
an auto-harvest commit today (no commit containing "auto-harvest" in message).

For those sessions only: scan conversation files for BUG/GOTCHA entries.
If found: append to relevant project's docs/learnings.md.
If all sessions already have auto-harvest commits: print "All harvested — nothing to do" and exit.
git add docs/learnings.md && git commit -m "auto-harvest: YYYY-MM-DD" && git push
```

---

## PART 10: PROJECT BOOTSTRAPPING

### ASF Graphics — docs/learnings.md
Create with bootstrap entries:
```markdown
# Project Learnings — ASF Graphics
<!-- Auto-maintained by harvest skill and auto-harvest. Manual edits welcome. -->

## Active Learnings

### 2026-04-11 — GOTCHA — PostgREST Silent 1000-Row Truncation
**Severity:** CRITICAL
**Context:** Root cause of vehicle/trailer dropdown bug that survived multiple fix attempts.
**Learning:** PostgREST truncates DISTINCT results at 1000 rows silently. Fix: always add .limit() with explicit count or range headers on any query returning >500 rows.
**Applies to:** All Supabase queries with large result sets

### 2026-04-11 — BUG — Migrations 026-028 Broke Employee Permissions
**Severity:** CRITICAL
**Context:** Post-deploy regression discovered April 2026.
**Learning:** Migrations 026-028 introduced RLS regression that broke employee permissions. Root cause not yet identified. UNRESOLVED — fix before next migration sprint.
**Applies to:** Employee table RLS policies, migrations 026-028

### 2026-04-11 — GOTCHA — Railway Env Vars Are Authoritative
**Severity:** HIGH
**Context:** Silent deploy failures from env var mismatches.
**Learning:** Railway Variables is the authoritative source for backend config. Local .env is for development only. Mismatches cause silent deploy failures — always verify exact Railway variable names match what the code expects.
**Applies to:** All backend deploys to Railway

### 2026-04-11 — GOTCHA — React 19 Not 18
**Severity:** HIGH
**Context:** Migration from React 18 to 19 completed April 7, 2026.
**Learning:** Codebase is on React 19. Any React 18-specific patterns, APIs, or lifecycle methods are wrong. Update any 18-specific code immediately.
**Applies to:** All React components and patterns

### 2026-04-11 — GOTCHA — Never Hardcode Schema
**Severity:** HIGH
**Context:** Core Claude Code rule from CLAUDE.md.
**Learning:** Always read the codebase before editing. Never hardcode schema field names, table names, or column references without verifying current state in repo. Schema has 29 tables and changes frequently.
**Applies to:** All Claude Code sessions on ASF Graphics

## Archive
```

Also add to ASF Graphics CLAUDE.md:
```markdown
## Global Intelligence
- docs/learnings.md — accumulated session learnings (auto-harvested, check before starting any task)
- Claudious repo — global cross-project intelligence (available via project knowledge)
- Before starting any task: surface any CRITICAL or HIGH learnings relevant to today's work
- After any session involving debugging or unexpected behavior: append to docs/learnings.md
```

### Courtside Pro — docs/learnings.md
Add missing entries (file already exists):
```markdown
### 2026-04-11 — BUG — computeFloorIntel() null year_installed Gate
**Severity:** HIGH
**Context:** Open bug, unresolved, fix on project reactivation.
**Learning:** computeFloorIntel() has a null gate on year_installed that causes silent failures. Do not deploy to production until fixed on reactivation.
**Applies to:** netlify/functions/ai.js — computeFloorIntel function

### 2026-04-11 — GOTCHA — esbuild Build Command Must Be Exact
**Severity:** HIGH
**Context:** Any variation breaks the bundle silently.
**Learning:** Build cmd must be exactly: npx esbuild app.jsx --bundle --format=iife --platform=browser --loader:.jsx=jsx --jsx=automatic --outfile=app.js --minify. Any variation (different flags, order, output name) breaks the Netlify deploy.
**Applies to:** All Courtside Pro builds and deploys
```

Also add to Courtside Pro CLAUDE.md:
```markdown
## Global Intelligence
- docs/learnings.md — accumulated session learnings (check before starting any task)
- Claudious repo — global cross-project intelligence (available via project knowledge)
- Before starting any task: surface any CRITICAL or HIGH learnings relevant to today's work
- After any debugging session: append to docs/learnings.md
```

---

## PART 11: ENV VARS

Add to shell profile on BOTH machines (Mac ~/.zshrc and PC PowerShell $PROFILE):

```bash
export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1
export CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000
export CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1
```

---

## PART 12: GIT SETUP

```bash
cd [CLAUDIOUS_PATH]
git config user.email "loganallensf@gmail.com"
git config user.name "logancallen"
git config credential.helper manager
git config core.autocrlf false
chmod +x scripts/sync-knowledge.sh
chmod +x scripts/backup-config.sh
chmod +x scripts/rollback-config.sh
git add .
git commit -m "feat: initialize Claudious living intelligence system with April 11 seed data"
git push origin main
```

---

## PART 13: VERIFICATION CHECKLIST

### Claudious Repo
- [ ] Full directory structure exists (all folders including digest/, alerts.md)
- [ ] evaluations/processed.log exists (empty with header)
- [ ] queue/deployed.log exists (empty with header)
- [ ] alerts.md exists with empty Active Alerts section
- [ ] All learnings files populated with seed entries
- [ ] skills/index.md created with all current skills
- [ ] research/ with pipeline index and first sweep
- [ ] All 3 scripts exist and are executable
- [ ] Initial commit pushed to GitHub

### Global Skills
- [ ] ~/.claude/skills/harvest/SKILL.md (harvest skill — full spec above)
- [ ] ~/.claude/skills/pioneer/SKILL.md (pioneer skill — full spec above)
- [ ] ~/.claude/skills/project-router/SKILL.md (project router — full spec above)
- [ ] ~/.claude/skills/caveman/ (third-party install: gh repo clone JuliusBrussee/caveman ~/.claude/skills/caveman)

### Global Agents
- [ ] ~/.claude/agents/rls-auditor.md
- [ ] ~/.claude/agents/context-scout.md
- [ ] ~/.claude/agents/migration-validator.md

### ASF Graphics Agents
- [ ] .claude/agents/builder.md
- [ ] .claude/agents/migrator.md
- [ ] .claude/agents/deployer.md

### Global Config
- [ ] ~/.claude/CLAUDE.md has full Session Lifecycle section (start + end)
- [ ] Shell profile has all 5 env vars (both Mac and PC)

### Per-Project
- [ ] ASF Graphics: docs/learnings.md with 5 bootstrap entries
- [ ] ASF Graphics: CLAUDE.md has Global Intelligence section
- [ ] Courtside Pro: docs/learnings.md has 2 new entries added
- [ ] Courtside Pro: CLAUDE.md has Global Intelligence section

### Scheduled Tasks
- [ ] Scout: weekly Sunday 8am, 6-search multi-query protocol
- [ ] Evaluator: weekly Monday 8am, reads processed.log
- [ ] Pioneer: monthly 2nd, reads deployed.log
- [ ] Retrospective: monthly 1st 10am, updates last-retrospective
- [ ] Drift Detector: weekly Wednesday 8am
- [ ] Config Backup: weekly Saturday 8am
- [ ] Digest: weekly Friday 5pm
- [ ] AutoDream Check: weekly Sunday 9am
- [ ] Auto-Harvest Fallback: daily 11pm (FALLBACK only)
- [ ] No separate Cross-Platform Monitor (handled by Scout search 6)

### Manual Post-Build Steps
1. Install harvest skill in Claude.ai via Skills UI
2. Create dedicated Claudious Claude Project
3. Connect Claudious GitHub repo to Claudious Claude Project as knowledge source
4. Add Claudious as knowledge source to ALL other Claude Projects:
   - ASF Graphics → connect Claudious repo
   - Courtside Pro → connect Claudious repo
   - Court Designer → connect Claudious repo
   - GE Diesel → connect Claudious repo
   - Genesis Framework → connect Claudious repo
   - Claude Mastery Lab → connect Claudious repo
5. Add docs/learnings.md as knowledge file in ASF Graphics and Courtside Pro projects
6. Add session opener to each project's system instructions field (not a skill):
   "At session start, silently scan docs/learnings.md for CRITICAL and HIGH entries relevant to today's task. If found, surface before anything else: '⚠️ Relevant learning: [title] — [summary]'. Check Claudious learnings for cross-project relevant entries."
7. Set up all scheduled tasks per Part 9
8. Click Sync on ALL Claude Projects after initial push

---

## SUMMARY

This build creates:
- 1 Claudious repo (global, connected to ALL 7 Claude Projects)
- 3 Claude.ai / global skills (harvest, pioneer, project-router)
- 1 third-party skill install (caveman)
- 6 custom subagents (rls-auditor, context-scout, migration-validator, builder, migrator, deployer)
- 3 shell scripts (sync, backup, rollback)
- 5 environment variables (both machines)
- Global CLAUDE.md session lifecycle (full start + end automation)
- 9 scheduled tasks (Scout with 6-search protocol, Evaluator with processed.log, Pioneer with deployed.log feedback loop, Retrospective, Drift Detector with alerts, Config Backup, Digest, AutoDream Check, Auto-Harvest Fallback)
- Per-project bootstrapping (learnings files with real entries, CLAUDE.md global intelligence sections, agent definitions)
- Alert system (alerts.md checked every session start)
- Emergency rollback script

Net result: fully autonomous intelligence system. Logan reviews queue/ weekly (5 min), proposals/ monthly (10 min), adds one line to deployed.log when deploying (~10 sec), and clicks Sync after pushes (5 sec). Everything else runs without intervention.
