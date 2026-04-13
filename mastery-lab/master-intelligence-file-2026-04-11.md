# Master Intelligence File — April 11, 2026
**Logan Allen × Claude Mastery Lab**
**Scope:** Everything learned, discovered, built, and planned in this session
**Replaces:** All previous session handoffs, playbook fragments, and status docs
**Feed this to:** Every Claude Project as a knowledge file

---

## April 12 Update

Session-on-top of the April 11 build. Captures changes made the following day — anything below this section is the April 11 baseline and may be stale where it conflicts with this update.

- **Mastery Lab knowledge files moved to `Claudious/mastery-lab/` and connected via GitHub sync** — no more manual uploads; 8 files now version-controlled with the rest of Claudious.
- **All 10 Cowork scheduled tasks deployed and manually verified** — Scout, Evaluator, Implementer, Drift Detector, Retrospective, Pioneer, Digest, Config Backup, Auto-Harvest, AutoDream Check.
- **Implementer task added** — closes the autonomous loop (Scout → Evaluator → Implementer → Pioneer). First run deployed 4 SAFE items and routed 3 to proposals/.
- **AutoDream confirmed live on Logan's account** — auto-memory: on. CC-008 upgraded from PARTIAL to POSITIVE.
- **ASF Graphics docs updated** — schema-state.md, codebase-state.md, living-system-state.md corrected against Drift Detector's 17-discrepancy report.
- **Designer financial access documentation corrected across 3 files** — CLAUDE.md, business-rules.md, operating-framework.md. Prior docs overstated designer financial visibility relative to actual RLS policies.
- **Two-layer role scheme documented as GOTCHA** — `ops_manager` (DB/RLS layer) vs. `ops` (frontend grouping). Conflating them is the root cause of repeated role-docs errors. Captured in Claudious learnings.md.
- **Cowork sandbox limitations identified** — can't git push (identity workaround added), can't access files outside the working folder (Config Backup + Auto-Harvest partially blocked), permission prompts on every file op (no disable — Cowork is research preview).
- **ChatGPT Pro Deep Research DISTILL pass confirmed complete** — both 7-section and 13-section reports were processed during Sprint 3 (April 11). Gap #8 marked resolved.

---

## WHAT WE ARE (Current Stack — April 11, 2026)

**Subscription:** Claude Max ($100/month)
**Models:** Opus 4.6, Sonnet 4.6, Haiku 4.5
**Context:** 1M tokens
**Platform:** Claude.ai + Claude Code (primary build tool)

**7 Active Claude Projects:**
| Project | Purpose | Status |
|---|---|---|
| Genesis Framework | Meta-framework, cross-project coordination | Active |
| ASF Graphics | Primary SaaS build (React/FastAPI/Supabase) | Active — primary |
| Court Designer | SVG court design tool | Active — maintenance |
| Courtside Pro | Sports flooring SaaS | ON HOLD — post-sale |
| GE Diesel Performance | Client ecommerce | Blocked — awaiting founder |
| Forensic Investigation | Divorce asset investigation | Active — sensitive |
| Claude Mastery Lab | Claude optimization intelligence | Active |
| **Claudious** | **Global intelligence base — NEW** | **Building via ultraplan** |

**6 Claude.ai Skills:** operating-system, logan-os, financial-modeler, legal-scanner, asf-ux-design, ux-reviewer

**Claude Code (ASF Graphics):** CLAUDE.md (40 lines), 3 skills, 3 hooks, 3 plugins, audited MCPs

---

## WHAT WE LEARNED — COMPLETE INTELLIGENCE CAPTURE

### CRITICAL DISCOVERIES (production-breaking if ignored)

**MEMORY.md System — Facts and Instructions Must Be Separated**
CLAUDE.md = instructions (what to do). MEMORY.md at `~/.claude/projects/[project]/memory/MEMORY.md` = facts (what Claude knows). Mixing them degrades both. MEMORY.md auto-loads into every session's system prompt (first 200 lines / ~25KB). You had NO MEMORY.md anywhere before today. Every session was starting from scratch on facts.
*Action: Create MEMORY.md for every active project immediately.*

**Claude 4.x Fixates on Negative Instructions**
Telling Claude "don't do X" makes it focus on X. Every "never," "don't," "avoid" in CLAUDE.md, User Preferences, and prompts is actively hurting output quality. Rewrite all as positive direction: "don't write fluffy intro" → "begin directly with core argument."
*Action: Audit User Preferences and all CLAUDE.md files. Rewrite all negatives.*

**PostgREST Silent 1000-Row Truncation**
PostgREST cuts DISTINCT results at 1000 rows with no error, no warning. Root cause of the vehicle/trailer dropdown bug in ASF that survived multiple fix attempts. Always add `.limit()` or range headers on any Supabase query returning large datasets.
*Action: Audit all Supabase queries in ASF Graphics for missing pagination.*

**Migrations 026-028 RLS Regression — UNRESOLVED**
Employee permissions broken. Root cause not yet identified. Do not run new migrations until this is fixed.

**RAG Activates Earlier Than Expected**
Claude Projects activate RAG at 2-6% context usage when many files exist — not just at limits. Files over 5KB need RAG-optimized structure regardless of total project size. Self-contained sections, descriptive H2/H3 headers, key fact in first 2 sentences.

### HIGH VALUE DISCOVERIES

**GitHub Closed-Loop Knowledge Sync (Logan's Original Pattern)**
Store all Claude Project knowledge files in `docs/` inside the project GitHub repo. Connect Claude Project to repo via GitHub sync. Claude Code updates docs/ files in same commit as code changes. Hit Sync in Claude Project UI. Knowledge files stay permanently current, version-controlled, maintained by the agent with ground truth — never manually by Logan.
Status: Live on Courtside Pro. Pending for ASF Graphics.

**Env Var Control Layer (From Source Leak)**
Five env vars that tune Claude Code behavior at the session level:
```bash
export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1      # Fixes April 2026 quality nerf
export CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000        # More runway before auto-compact
export CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 # Pins sub-agents to 1M context
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true    # Enables team coordination
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1  # Prevents retry double-work
```
*Action: Add to shell profile on both Mac Studio and PC.*

**Path-Scoped Rules via .claude/rules/**
Create `.claude/rules/` with individual .md files containing `paths: ["frontend/**"]` YAML frontmatter. Rules only load when Claude edits files in those paths. Frontend rules only fire when touching frontend files. Migration rules only fire when touching migrations. Keeps CLAUDE.md lean while enforcing domain-specific standards.

**Skill YAML Full Spec**
Most builders only use `name` and `description`. Full spec includes: `effort`, `allowed-tools`, `paths`, `model`, `context`, `agent`. Triggering is semantic — name and description ONLY influence auto-triggering. Add exclusion phrases in description text: "Do NOT trigger for: [list]". **The `negatives:` YAML field does not exist — it is invalid.**

**Caveman Skill — 75% Internal Token Reduction**
```bash
gh repo clone JuliusBrussee/caveman ~/.claude/skills/caveman
```
Forces compressed language for internal reasoning. User-facing output unchanged. Verified by Anthropic DevRel.

**Context-Before-Question — 30% Quality Improvement**
On long-context prompts: paste all reference material BEFORE the question. Claude weights the end of context most heavily. Applies to every Claude.ai session with substantial reference material.

**Post-Commit Hook for Auto-Knowledge Updates**
`.claude/hooks/post-commit` inspects changed files and updates relevant docs/ automatically. migrations/* → schema-state.md. source files → codebase-state.md. functions/* → flags business-rules.md. Wire with: `git config core.hooksPath .claude/hooks` (must re-verify each session on PC — Windows doesn't always persist this).

**Agent Specialization via .claude/agents/**
Individual agent definition files with YAML frontmatter: name, isolation (worktree), tools, model, effort. Standard roles: BUILDER (frontend), MIGRATOR (database), DEPLOYER (pre-deploy), REVIEWER (adversarial). Cleaner than flat AGENTS.md definitions.

**3-Layer Knowledge Architecture**
- `skills/` — procedural (what to do, on-demand)
- `memory/` — episodic (what went wrong, always loaded)
- `knowledge/` — reference (static docs, RAG-retrieved)
Mixing these layers degrades all of them.

**RAG Split for Large Files**
Files over 5KB degrade RAG. Split into individual topic files under a subdirectory. Each file: descriptive filename, H2/H3 headers, self-contained sections, key fact first. Create index.md as master list. Courtside Pro's 162KB knowledge-base.md → 70 files in 5 minutes.

**SessionEnd/Start Hook Chain**
SessionEnd: writes handoff to `.claude/handoff.md` automatically. SessionStart: reads handoff and pre-appends to new session. Eliminates manual session continuity entirely. Add `handoff.md` to `.gitignore`.

**Windows Bash git config --global Doesn't Stick**
On Windows, bash doesn't read the same global git config as PowerShell. Use `git config` (no `--global`) to set identity at repo level. Always verify: `git config user.email` after setting.

**CRLF Line Endings Break Hook Files**
Git on Windows converts LF to CRLF when touching shell scripts, breaking bash execution. Fix: `git config core.autocrlf false`, then re-add and recommit affected files.

**Skill Triggering Cap**
Maximum ~34-36 skills before the `<available_skills>` block truncates and skills silently stop matching.

**@import Syntax for CLAUDE.md**
Write `@relative/path/to/file.md` in CLAUDE.md to inline other files. Resolves up to 5 levels deep. Enables modular CLAUDE.md that stays lean while routing to detailed rule files.

**CLAUDE.local.md for Private Overrides**
Machine-specific, gitignored CLAUDE.md extension. For local dev URLs, personal shortcuts, machine-specific paths. Add to `.gitignore`.

**Success Criteria Over Cautions**
Replace negative rules ("don't break RLS") with measurable outcomes ("every migration passes `SELECT * FROM pg_policies` before marking done"). Agents optimize toward targets, not away from fears.

**Self-Improving Skills via /self-eval**
After completing any task that used a skill, prompt: "Evaluate the skill you used. What did it miss or get wrong? Propose specific edits." Skills improve with every use instead of staying frozen at creation date.

**AutoDream Still Rolling Out**
Check `/memory` for toggle. ChatGPT research confirmed users seeing "Auto-Dreamed 5 entries" messages — it's rolling out. When available on your account: enable immediately on all projects.

**Ultraplan Available — Use It**
`/ultraplan` offloads complex planning to cloud Opus 4.6. No setup needed. Use on any task touching 3+ files or requiring architectural decisions. Terminal stays free during planning.

---

## WHAT WE BUILT TODAY

### Courtside Pro — Fully Automated (✅ Complete)

Everything autonomous. The complete pattern, proven in production:

```
Claude Code does work
    ↓ same commit
Updates relevant docs/ file automatically (post-commit hook)
    ↓
bash scripts/sync-knowledge.sh
    ↓ commits pending docs, pushes to main
Click Sync in Claude Project UI (5 seconds)
    ↓
All knowledge files current forever
```

**Files created:**
- `.claude/hooks/post-commit` — auto-updates docs/ on relevant commits
- `.claude/hooks/session-end` — writes handoff before exit
- `.claude/hooks/session-start` — reads handoff on entry
- `.claude/rules/jsx.md`, `migrations.md`, `netlify.md` — path-scoped rules
- `.claude/skills/deploy.md`, `schema-migration.md`, `knowledge-sync.md` — full YAML spec
- `.claude/agents/` — agent definitions (if applicable)
- `scripts/sync-knowledge.sh` — one-command push
- `CLAUDE.local.md` — PC-specific overrides (gitignored)
- `~/.claude/projects/.../memory/MEMORY.md` — project facts layer
- `docs/kb/` — 70 RAG-split files from 162KB knowledge-base.md
- `evaluations/processed.log`, `queue/deployed.log` in Claudious

**Git identity on PC:** `loganallensf@gmail.com` / `logancallen` (local config, not global)
**Credential helper:** `manager` — no more password prompts
**Hook wired:** `git config core.hooksPath .claude/hooks` — verify each session

### Claudious — Living Intelligence Base (🔄 Building via ultraplan)

Global intelligence repo connected to ALL 7 Claude Projects. Every session in every project feeds it. It feeds every future session everywhere.

**Repo:** `logancallen/Claudious` (GitHub, private)
**Local path:** `C:\Users\logan\OneDrive\Documents\GitHub\Claudious`

**What it contains:**
```
Claudious/
├── learnings/
│   ├── techniques.md      ← Claude techniques (cross-project)
│   ├── patterns.md        ← Architecture patterns
│   ├── gotchas.md         ← Silent failures, edge cases
│   ├── behavioral.md      ← User Preferences candidates
│   ├── antipatterns.md    ← Token waste patterns
│   └── platforms/         ← Claude, ChatGPT, Grok, Perplexity
├── skills/index.md        ← Master index of ALL skills everywhere
├── scout/                 ← Weekly web research outputs
├── evaluations/           ← Triage results + processed.log
├── queue/                 ← Ready-to-deploy improvements + deployed.log
├── proposals/             ← Judgment-required improvements
├── retrospectives/        ← Monthly analysis reports
├── snapshots/             ← Weekly config backups
├── digest/                ← Weekly system summaries
├── research/              ← Research pipeline outputs
├── alerts.md              ← Active system alerts (checked every session)
└── scripts/
    ├── sync-knowledge.sh
    ├── backup-config.sh
    └── rollback-config.sh  ← Emergency: restore config from snapshot
```

**9 Automated Components:**
| Component | What | When |
|---|---|---|
| Scout | 6-search web sweep for new techniques + cross-platform | Weekly Sunday |
| Evaluator | Triages scout findings vs current config (uses processed.log) | Weekly Monday |
| Pioneer | Self-improvement analysis, reads deployed.log for feedback | Monthly 2nd |
| Retrospective | Prunes, validates, graduates skills | Monthly 1st |
| Drift Detector | Schema docs vs actual DB | Weekly Wednesday |
| Config Backup | Snapshots all Claude config | Weekly Saturday |
| Digest | Aggregates all system outputs into one summary | Weekly Friday |
| AutoDream Check | Monitors rollout status | Weekly Sunday |
| Auto-Harvest | Fallback BUG/GOTCHA capture (primary is SessionEnd hook) | Daily 11pm |

**3 New Global Skills:**
- `harvest` — extracts learnings from any session, routes to project + Claudious simultaneously
- `pioneer` — Claude's self-improvement engine
- `project-router` — routes any task to the correct Claude Project

**6 Custom Subagents:**
- `rls-auditor` — Supabase RLS policy audit
- `context-scout` — reads files, returns compressed summary, never modifies
- `migration-validator` — validates migrations before applying
- `builder` (ASF) — frontend React only
- `migrator` (ASF) — database only
- `deployer` (ASF) — pre-deploy verification

**Alert System:** `alerts.md` checked at every session start. CRITICAL alerts surface immediately. Automated systems write to it. Logan clears alerts by deleting lines.

**Emergency Rollback:** `bash scripts/rollback-config.sh YYYY-MM-DD`

### Research Pipeline — Fully Executed

Three research sweeps completed today:
1. **Grok 9-section sweep** — X/Twitter power-user intelligence
2. **ChatGPT 8-section Deep Research** — GitHub, blogs, docs synthesis
3. **Deep Architecture Research (13 sections)** — Complete Claude architecture deep-dive

All DISTILL'd into playbook. Key new techniques: CC-019 through CC-029, PA-002 through PA-006, MM-001, SK-002, PR-002, PR-003, MCP-004.

**Research prompts:** Ready to run monthly. Both prompts updated with Section 8/9 additions. Grok also searches for Logan's GitHub closed-loop pattern to confirm if anyone else discovered it independently.

---

## WHAT WE ARE IMPLEMENTING — COMPLETE PLAN

### Today (Under 30 minutes)
- [ ] Add 5 env vars to shell profile — both Mac Studio AND PC
- [ ] Install Caveman skill: `gh repo clone JuliusBrussee/caveman ~/.claude/skills/caveman`
- [ ] Disconnect 6 Claude.ai MCPs: Gmail, Canva, Jotform, Linear, Figma, Clarify
- [ ] Check `/memory` in Claude Code — enable AutoDream if available

### This Week
- [ ] Audit User Preferences — rewrite every "never/don't/avoid" as positive direction
- [ ] Add Success Criteria section to ASF CLAUDE.md
- [ ] Create MEMORY.md for ASF Graphics (populate with RLS incident, PostgREST gotcha, Railway env vars, React 19 migration)
- [ ] Create MEMORY.md for Genesis Framework
- [ ] Create MEMORY.md for Claude Mastery Lab
- [ ] Create global `~/.claude/MEMORY.md` with universal facts
- [ ] Update ASF skill YAML frontmatter to full spec (effort, allowed-tools, paths)
- [ ] Add exclusion phrases to skill descriptions (replace invalid negatives: YAML)
- [ ] Install project-router skill globally
- [ ] Install follow-builders skill: `git clone https://github.com/zarazhangrui/follow-builders.git ~/.claude/skills/follow-builders`
- [ ] Install TranscriptAPI MCP: `claude mcp add --transport http transcript-api https://transcriptapi.com/mcp`
- [ ] Create CLAUDE.local.md on both machines (gitignored)
- [ ] Verify Claudious ultraplan completed — check Part 13 verification checklist

### Next Build Session (ASF Graphics)
- [ ] Create `docs/` folder in asf-graphics-app repo
- [ ] Move all ASF knowledge files into docs/
- [ ] Connect ASF Graphics Claude Project to GitHub repo
- [ ] Create `.claude/rules/` with frontend, backend, migrations scopes
- [ ] Create `.claude/agents/` with BUILDER, MIGRATOR, DEPLOYER definitions
- [ ] Create ASF `docs/learnings.md` with bootstrap entries
- [ ] Add SessionEnd/Start hooks
- [ ] Install Codex plugin: `claude --plugin marketplace add openai/codex-plugin-cc`
- [ ] Set up @import modularization for CLAUDE.md
- [ ] Add Global Intelligence section to CLAUDE.md

### Post-Ultraplan (Manual Steps for Claudious)
- [ ] Install harvest skill in Claude.ai via Skills UI
- [ ] Create Claudious Claude Project
- [ ] Connect Claudious GitHub repo to Claudious Claude Project
- [ ] Add Claudious as knowledge source to ALL 6 other Claude Projects
- [ ] Add `docs/learnings.md` as knowledge file in ASF Graphics and Courtside Pro
- [ ] Add session opener to each project's system instructions field
- [ ] Set up 9 scheduled tasks (Scout, Evaluator, Pioneer, Retrospective, Drift Detector, Config Backup, Digest, AutoDream Check, Auto-Harvest)
- [ ] Click Sync on ALL Claude Projects

### Next Sprint
- [ ] Build health-optimizer skill
- [ ] Build macro-intelligence skill
- [ ] Build negotiation-playbook skill
- [ ] Update Task Routing Table project
- [ ] FastAPI-to-MCP bridge for ASF backend (MCP-004)
- [ ] RAG content pass on 7 large Courtside Pro files (deferred until reactivation)

### Monthly (Starting May 1)
- [ ] Run Grok 9-section research sweep
- [ ] Run ChatGPT 8-section Deep Research sweep
- [ ] DISTILL both into Mastery Lab
- [ ] Run monthly retrospective prompt in each active project
- [ ] Review Claudious queue/ (~5 min)
- [ ] Review Claudious proposals/ (~10 min)

---

## COMPLETE TECHNIQUE REGISTRY

### Implemented April 7, 2026 (Sprint 1)
| ID | Name | Status |
|---|---|---|
| CC-001 | CLAUDE.md Optimization (40 lines) | ✅ Done |
| CC-002 | Project Skills (deploy-checklist, schema-migration, component-build) | ✅ Done |
| CC-003 | Code Intelligence Plugins (typescript-lsp, pyright-lsp, security-guidance) | ✅ Done |
| CC-006/CC-018 | Hooks (safety gate, formatter, typecheck) | ✅ Done |
| CC-011 | Status Line (model + context% + tokens) | ✅ Done |
| CC-012 | MCP Audit (3 servers disconnected, ~8,400 tokens/msg saved) | ✅ Done |
| CC-016 | Effort Level Set to Medium | ✅ Done |
| CC-008 | AutoDream (manual consolidation done, toggle pending) | ⚠️ Partial |
| CC-009 | Auto Mode Permissions | ❌ Not on Max plan |

### Implemented April 11, 2026 (This Session — Courtside Pro)
| ID | Name | Status |
|---|---|---|
| PA-006 | GitHub Closed-Loop Knowledge Sync | ✅ Done (Courtside Pro) |
| CC-026 | SessionEnd/Start Hooks | ✅ Done (Courtside Pro) |
| CC-028 | .claude/agents/ Directory | ✅ Done (Courtside Pro) |
| CC-029 | CLAUDE.local.md | ✅ Done (Courtside Pro) |
| PA-003 | Path-Scoped Rules (.claude/rules/) | ✅ Done (Courtside Pro) |
| SK-002 | Full Skill YAML Spec | ✅ Done (Courtside Pro) |
| MM-001 | MEMORY.md System | ✅ Done (Courtside Pro) |

### Pending Implementation
| ID | Name | Effort | Priority |
|---|---|---|---|
| CC-019 | Disable Adaptive Thinking env var | TRIVIAL | Do today |
| CC-020 | Auto-compact window + subagent pin | TRIVIAL | Do today |
| CC-023 | Caveman Skill | TRIVIAL | Do today |
| PR-002 | Context-Before-Question | TRIVIAL | Behavioral |
| PR-003 | Positive Reframing (User Preferences) | LOW | This week |
| CC-025 | Success Criteria in CLAUDE.md | LOW | This week |
| PA-004 | @import Modularization | TRIVIAL | This week |
| CC-024 | Self-Improving Skills | LOW | This week |
| MM-001 | MEMORY.md (ASF, Genesis, Mastery Lab) | MEDIUM | This week |
| PA-006 | GitHub Sync (ASF Graphics) | MEDIUM | Next build |
| CC-022 | /batch Fan-Out | MEDIUM | Next build |
| PA-002 | 3-Layer Knowledge Architecture | MEDIUM | Next build |
| MCP-004 | FastAPI-to-MCP Bridge | HIGH | Next sprint |
| ML-001 | Harvest Skill | MEDIUM | Post-ultraplan |
| ML-002 | Per-Project Learnings Files | LOW | Post-ultraplan |
| ML-003 | Monthly Retrospective Protocol | TRIVIAL | May 1 |

### Invalidated
| ID | Name | Reason |
|---|---|---|
| CC-027 | Skill negatives: YAML field | Field does not exist — use description text |

---

## ARCHITECTURE DECISIONS (Final, Not To Be Revisited)

**Claudious is global.** Connected to ALL Claude Projects. Not just its own project.

**CLAUDE.md = instructions. MEMORY.md = facts.** Never mix.

**Primary harvest = SessionEnd hook. Daily scheduled task = fallback only.**

**Auto-queue criteria: SAFE + HIGH impact + TRIVIAL effort.** Everything else goes to proposals/.

**Scout replaces cross-platform monitor.** Search 6 handles cross-platform weekly. No separate monthly monitor.

**Session opener = project system instructions field.** Not a skill. Fires on every session automatically.

**Bootstrap entries are mandatory.** Empty learnings files don't get used. Pre-populate with real known data.

**Negative framing in Claude 4.x is actively harmful.** Rewrite ALL negatives as positive direction everywhere.

**RAG structure required for all files over 5KB.** Not optional regardless of project size.

---

## GLOBAL SKILLS INDEX (All Projects — April 11, 2026)

### Global (~/.claude/skills/)
| Skill | Trigger | Status |
|---|---|---|
| harvest | "harvest this", "what have we learned" | 🔄 Building |
| pioneer | "improve claude", "self-improve" | 🔄 Building |
| project-router | "where should I do X", "which project" | 🔄 Building |
| caveman | (internal token reduction) | ⏳ Pending install |
| follow-builders | builder digest monitoring | ⏳ Pending install |

### Claude.ai User Skills (/mnt/skills/user/)
| Skill | Purpose | Status |
|---|---|---|
| operating-system | Mental models, decision frameworks | ✅ Mature |
| logan-os | Entity structures, infrastructure index | ✅ Mature |
| financial-modeler | Valuation, projections, deal math | ✅ Mature |
| legal-scanner | Contract risk, TX business law | ✅ Mature |
| asf-ux-design | ASF-specific UX design and review | ✅ Mature |
| ux-reviewer | Generic frontend review | ✅ Stable |
| harvest | Session knowledge extraction | 🔄 Building |

### ASF Graphics (.claude/skills/)
| Skill | Trigger | Status |
|---|---|---|
| deploy-checklist | deploy, push to production | ✅ Stable |
| schema-migration | migration, schema change, RLS | ✅ Stable |
| component-build | build component, create page | ✅ Stable |

### Courtside Pro (.claude/skills/)
| Skill | Trigger | Status |
|---|---|---|
| deploy | deploy, push to production | ✅ Stable |
| schema-migration | migration, schema change | ✅ Stable |
| knowledge-sync | sync knowledge, update docs | ✅ Stable |

---

## MCP STATUS

### Claude.ai
| MCP | Status | Action |
|---|---|---|
| Google Drive | ✅ Keep | Active use |
| Supabase | ✅ Keep | Database context |
| Stripe | ✅ Keep | Payment context |
| Netlify | ✅ Keep | Deploy context |
| Gmail | ⚠️ Disconnect | Light use |
| Canva | ⚠️ Disconnect | Light use |
| Jotform | ⚠️ Disconnect | Unused |
| Linear | ⚠️ Disconnect | Unused |
| Figma | ⚠️ Disconnect | Light use |
| Clarify | ⚠️ Disconnect | Unknown utility |

### Claude Code (ASF Graphics)
| MCP | Status |
|---|---|
| 2 project-relevant servers | ✅ Kept |
| 3 unused servers | ✅ Disconnected |
| Playwright MCP | ⏳ Pending |
| GitHub MCP | ⏳ Pending |
| TranscriptAPI MCP | ⏳ Pending install |

---

## CROSS-PLATFORM TASK ROUTING (Summary)

| Task | Platform | Why |
|---|---|---|
| Core reasoning, analysis | Claude | Highest quality |
| File/doc analysis | Claude | 1M context |
| Project/workspace management | Claude | Projects + skills |
| Multi-file coding | Claude Code | Native |
| X/Twitter intelligence | Grok | Exclusive firehose |
| Deep research synthesis | ChatGPT Pro | Best web synthesis |
| Citation-required research | Perplexity | Citations by default |
| Image/video generation | ChatGPT | DALL-E + Sora |
| Voice conversations | ChatGPT | Full-duplex voice |
| Browser automation | ChatGPT | Agent mode |
| Best value | Grok | Price/performance |

---

## KNOWN GAPS (Post-Session)

| Gap | Status | When |
|---|---|---|
| Migrations 026-028 RLS regression | UNRESOLVED | Next ASF sprint |
| AutoDream toggle | Pending rollout | Check /memory |
| Codex plugin | Needs ChatGPT credentials | Next build session |
| ASF GitHub sync | Not set up | Next build session |
| 6 Claude.ai MCPs to disconnect | Pending | Today |
| User Preferences negative reframing | Pending | This week |
| health-optimizer skill | Not built | Next month |
| macro-intelligence skill | Not built | Next month |
| negotiation-playbook skill | Not built | Next month |
| 7 large Courtside Pro RAG files | Deferred | On reactivation |
| Parallel agent workflows | Not tested | Next complex ASF feature |

---

## X ACCOUNT — @Claudified

**Handle:** @Claudified
**Bio direction:** "finding what anthropic didn't document. shipping what others theorize."
**Content:** Frameworks, hidden tools, mental models, agent architecture — no code that reveals projects
**Identity:** Fully anon — no connection to Logan Allen or any project
**Monetization:** Build audience first, evaluate later
**Edge:** Techniques not in any tutorial (GitHub closed-loop, MEMORY.md, research pipeline, .01% architecture)

---

*Built: April 11, 2026 | Logan Allen × Claude Mastery Lab*
*Next update: After ultraplan completes + ASF Graphics GitHub sync implemented*
