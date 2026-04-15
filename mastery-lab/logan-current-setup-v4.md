# Logan's Current Claude Setup — Baseline Snapshot v4

**Last Updated:** April 14, 2026 (post-MCP expansion + global skills deployment + Cowork Evidence Loop addition)
**Purpose:** This file gives the Mastery Lab project awareness of Logan's existing Claude infrastructure so it can accurately identify gaps, avoid redundant recommendations, and prioritize high-leverage improvements.

**Update trigger:** Update this file whenever a significant change is made to any Claude project, skill, preference, or integration.

---

## Subscription & Access

- **Plan:** Claude Max ($200/month)
- **Models available:** Opus 4.6, Sonnet 4.6, Haiku 4.5
- **Context window:** 1M tokens (GA as of March 13, 2026)
- **Claude Code:** v2.1.104, Opus 4.6, 1M context
- **Features enabled:** Projects, Artifacts, Memory, Web Search, Deep Research, Code Execution, Skills, MCP Integrations, Cowork (active — 8 scheduled tasks)
- **AutoDream:** ✅ LIVE — Auto-memory: on, confirmed April 12, 2026
- **NOT available on Max:** Auto mode (CC-009) — Team/Enterprise/API only

### Other AI Subscriptions
- ChatGPT Business: $63.84/mo
- Perplexity Pro: $20/mo
- Grok Premium+: $40/mo

---

## Claude Projects (8 Active)

| Project | Purpose | Knowledge Source | Status |
|---|---|---|---|
| **ASF Graphics** | Primary business app (job tracking, scheduling, invoicing, design) | GitHub sync — 18 files from docs/ + MEMORY.md + pvo_vehicle_sqft.json | Active — primary build |
| **Courtside Pro** | SaaS product for sports flooring industry intel | GitHub sync — 70 RAG-split files in docs/kb/ | Active — primary focus, demos scheduled |
| **Court Designer** | Standalone SVG court design tool | Manual uploads | Active — maintenance |
| **GE Diesel Performance** | Client ecommerce build | Pending | Blocked — awaiting founder interview |
| **Forensic Investigation** | Family member divorce asset investigation | Manual uploads | Active — sensitive, no Claude Code |
| **Genesis Framework** | Meta-framework for bootstrapping, auditing, and advising projects | Manual uploads + MEMORY.md | Active — framework design & advisory |
| **Claude Mastery Lab** | THIS PROJECT — Claude optimization intelligence | GitHub sync — 8 files from Claudious/mastery-lab/ + MEMORY.md | Active |
| **Claudious** | Global intelligence repo — connected to all projects | GitHub sync | Active — fully built and operational |

---

## Custom Skills (7 Claude.ai + 7 Claude Code Global + 4 ASF Project + 2 Courtside Pro Project)

### Claude.ai Skills (User-level, `/mnt/skills/user/`)

| Skill | What It Does | Maturity |
|---|---|---|
| `operating-system` | Mental models, decision frameworks, Munger lattice | Mature |
| `logan-os` | Entity structures, infrastructure index, hardware, deploy patterns | Mature |
| `financial-modeler` | Scenario modeling, valuation, sensitivity analysis, deal math | Mature |
| `legal-scanner` | Contract/compliance/liability risk identification, TX business law | Mature |
| `asf-ux-design` | ASF Graphics UX design, build, and review system | Mature |
| `ux-reviewer` | Generic frontend UX review for non-ASF projects | Stable |
| `harvest` | Session knowledge extraction, dual-path (project + Claudious) | Stable |

### Claude Code Global Skills (~/.claude/skills/)

| Skill | What It Does | Status |
|---|---|---|
| `harvest` | Extracts learnings, routes to project + Claudious | ✅ |
| `pioneer` | Claude self-improvement engine | ✅ |
| `project-router` | Routes tasks to correct Claude Project | ✅ |
| `caveman` | 75% internal token reduction | ✅ |
| `health-optimizer` | Training, recovery, nutrition, sleep advisor for Logan | ✅ |
| `macro-intelligence` | Macro, investing, and portfolio intelligence for Logan | ✅ |
| `negotiation-playbook` | Counterparty profiling, negotiation strategy, sales framework | ✅ |

### ASF Graphics Project Skills (.claude/skills/)

| Skill | What It Does | Status |
|---|---|---|
| `deploy-checklist.md` | 6-step pre-deploy verification | ✅ |
| `schema-migration.md` | Migration naming, RLS, rollback conventions | ✅ |
| `component-build.md` | React component patterns, mobile-first | ✅ |
| `parallel-build.md` | Parallel execution patterns (Agent Teams, split-merge, /batch) | ✅ |

### Courtside Pro Project Skills (.claude/skills/)

| Skill | What It Does | Status |
|---|---|---|
| `parallel-build.md` | Parallel execution patterns (Agent Teams, split-merge, /batch) | ✅ |
| `deploy.md` | Deploy checklist with Codex review gate | ✅ |

---

## Claude Code Configuration

### Global (~/.claude/)
- **CLAUDE.md:** Session lifecycle (start/end hooks, self-check block, emergency rollback)
- **MEMORY.md:** Global facts — infrastructure, projects, gotchas, subscriptions
- **settings.json:** Hooks configured, effort level medium
- **AutoDream:** ✅ Active — auto-memory: on

### ASF Graphics (.claude/)
- **Hooks:** post-commit (auto-updates docs/), session-start (reads handoff + learnings), session-end (writes handoff)
- **Rules:** jsx.md, migrations.md, netlify.md (path-scoped)
- **Agents:** builder (frontend), migrator (database), deployer (pre-deploy)
- **scripts/sync-knowledge.sh:** One-command knowledge push

### Global Agents (~/.claude/agents/)
- rls-auditor, context-scout, migration-validator

### Plugins Installed
- typescript-lsp, pyright-lsp, security-guidance, Context7, Codex (openai/codex-plugin-cc)

### Environment Variables (PC — set in PowerShell profile)
- CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1
- CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000
- CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6
- CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true
- CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1

### Environment Variables (Mac Studio — NOT YET SET)
- Same 5 vars need adding to ~/.zshrc when at office

---

## MCP Integrations

### Claude.ai (4 active — 6 disconnected April 12)

| Integration | Status |
|---|---|
| Google Drive | ✅ Connected |
| Supabase | ✅ Connected |
| Stripe | ✅ Connected |
| Netlify | ✅ Connected |
| Gmail | ❌ Disconnected April 12 |
| Canva | ❌ Disconnected April 12 |
| Jotform | ❌ Disconnected April 12 |
| Linear | ❌ Disconnected April 12 |
| Figma | ❌ Disconnected April 12 |
| Clarify | ❌ Disconnected April 12 |

### Claude Code

| MCP Server | Status | Purpose |
|---|---|---|
| Playwright | ✅ Connected | Browser automation for UI testing and verification |
| TranscriptAPI | ✅ Connected | YouTube transcript ingestion for Mastery Lab DISTILL pipeline |
| GitHub | ✅ Connected | Repo, PR, and issue operations from within Claude Code |

- 2 project-relevant MCP servers kept from Sprint 1
- 3 unused servers disconnected (Sprint 1, ~8,400 tokens/msg saved)
- 3 new servers added April 14, 2026 (Playwright, TranscriptAPI, GitHub)

---

## Claudious — Autonomous Intelligence System

**Repo:** logancallen/Claudious (GitHub, private)
**Local:** C:\Users\logan\OneDrive\Documents\GitHub\Claudious (PC)
**Connected to:** ALL 8 Claude Projects as knowledge source

### Automated Components (8 Cowork Scheduled Tasks)

| Task | Frequency | What It Does |
|---|---|---|
| Scout | Weekly Sun 8:45am | 6-search web sweep for new techniques |
| Evaluator | Weekly Sun 10:40am | Triages Scout findings → queue/ or proposals/ |
| Implementer | Daily 7:45am | Auto-deploys SAFE items from queue/ |
| Drift Detector | Weekly Sun 10:10am | Compares schema docs vs actual migrations |
| Retrospective | Weekly Sun 11:10am | Prunes, validates, graduates knowledge |
| Pioneer | Weekly Sun 12:30pm | Analyzes config, proposes improvements |
| Digest | Weekly Sun 9:35pm | Compiles weekly summary for Logan |
| Evidence Loop | Weekly | Verifies deployed techniques produced measurable impact; closes the loop between Implementer and playbook |

**April 14, 2026:** All 8 task prompts audited and corrected — fixed path references, tightened output contracts, removed ambiguous scope language, and verified each task against its required inputs/outputs.

### Closed Loop
Scout discovers → Evaluator triages → queue/ → Implementer deploys → deployed.log → Pioneer verifies → feeds back to queue/

### Logan's Time Commitment
- Weekly: Read Digest (~2 min), review queue/ (~5 min)
- Monthly: Review proposals/ (~10 min)
- Total: ~30 min/month across 8 scheduled tasks

---

## Knowledge Architecture

### Per-Project Pattern
- All knowledge files live in `docs/` in the GitHub repo
- GitHub sync replaces manual uploads to Claude.ai Projects
- Claude Code updates docs/ in same commit as code changes (post-commit hook)
- MEMORY.md at repo root = project facts (separate from CLAUDE.md = instructions)

### Global Pattern
- Claudious repo connected to ALL projects as knowledge source
- Cross-project learnings route to Claudious via harvest skill
- Per-project learnings stay in project's docs/learnings.md

### MEMORY.md Locations
| Location | Content |
|---|---|
| ~/.claude/MEMORY.md | Global — infrastructure, projects, gotchas, subscriptions |
| ~/Projects/asf-graphics-app/MEMORY.md | ASF — team, architecture, bugs, pricing, deploy pattern |
| Genesis Framework (uploaded) | Genesis — advisory rhythm, decisions, methodology |
| Claude Mastery Lab (uploaded) | Mastery Lab — knowledge files, pipeline, implementation status |

---

## Known Gaps (Updated April 12, 2026)

| # | Gap | Status |
|---|---|---|
| 1 | Migrations 026-028 employee permissions broken | CRITICAL — unresolved |
| 2 | Design Library upload bug | OPEN — files upload but don't display |
| 3 | Cowork sandbox can't git push autonomously | Limitation — git identity lines added as workaround |
| 4 | Config Backup + Auto-Harvest limited by sandbox | Partial — rely on Claude Code hooks as primary |
| 5 | Claudious not connected as knowledge source to remaining 5 projects | Pending — ASF, Claudious, and Mastery Lab connected; 5 remaining |
| 6 | Session opener not added to project system instructions | Pending |
| 7 | Mac Studio env vars not set | Pending — do when at office |
| 8 | ChatGPT Pro Deep Research DISTILL pass | ✅ Resolved April 11 — both 7-section and 13-section reports processed in Sprint 3 |
| 9 | Mastery Lab files not in git (still manual uploads) | ✅ Resolved April 12 — moved to Claudious/mastery-lab/, GitHub sync connected (8 files) |
| 10 | GeometryEngine test failures (5 tests) in Court Designer | OPEN — pre-existing, blocks pre-push hook |

---

## User Preferences

Rewritten April 12, 2026 (PR-003 — negative framing → positive direction). Comprehensive coverage: response mode, response structure, behavioral rules, code/build rules, tool discipline, expertise calibration, reinforced rules. Applied to new conversations only.

---

## Refresh Protocol

Update this file when:
- A new Claude Project is created or archived
- A new skill is created or significantly modified
- An MCP integration changes
- Claude Code configuration changes
- Subscription tier changes
- A gap is resolved (move to implementation-log)
- Cowork tasks are added or modified
- Claudious architecture changes
