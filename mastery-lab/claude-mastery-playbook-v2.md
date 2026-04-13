# Claude Mastery Playbook

**Last Updated:** April 7, 2026
**Total Techniques:** 33+
**Implemented:** 30+ (see implementation-log-v4.md)
**Queued:** See Claudious queue/ and proposals/

---

## Source Registry

Priority sources for ongoing intelligence gathering. Ranked by signal-to-noise ratio for Logan's level.

### Tier 1 — Ground Truth (always process)
- **Anthropic Official Docs** — docs.claude.com, code.claude.com/docs, support.claude.com
- **Anthropic Courses** — Claude Code in Action (anthropic.skilljar.com)
- **Anthropic Engineering Blog** — anthropic.com/engineering

### Tier 2 — High Signal (process regularly)
- **ykdojo/claude-code-tips** (GitHub) — 45+ production-tested Claude Code tips. Boris Cherny (Claude Code creator) endorsed.
- **How I AI (chatprd.ai)** — 47 step-by-step Claude workflows from expert interviews. Highest technique density.
- **Ado (@adocomplete on X)** — Anthropic DevRel, daily Claude Code tips ("Advent of Claude" series + ongoing)
- **DreamHost Tested Techniques** — empirically tested 25 prompting techniques, found 5 that work with Claude 4.x
- **The AI Corner Newsletter** — comprehensive Claude ship log with setup instructions per release
- **Nate Herk** (YouTube) — AI automation workflows, Claude Code token management, tool deep-dives. High technique density, tests what he shows. *(Added April 7, 2026 — 16 transcripts processed)*

### Tier 3 — Selective (process when topic-relevant)
- **Corbin Brown** (YouTube, 160K subs) — deep AI coding tutorials
- **Carl from Product Faculty** — Claude Code PM workflows, morning planning systems
- **John Isaacson** — video editing with Claude Code (relevant for automation patterns, not video editing)
- **Sabrina Ramonov** (YouTube, 1.4M) — agent systems and automation for business owners
- **Claude Code Best Practices repo** (GitHub) — community-maintained

### Tier 4 — Noise Filter (skim for gems, mostly skip)
- Generic "Claude tips" listicles
- Beginner tutorials
- Marketing/coaching-focused Claude content
- Anything that doesn't include specific implementation steps

### Grok X Research Targets
- Claude Code power users sharing configs
- CLAUDE.md examples and teardowns
- Custom skill builders
- MCP integration workflows
- Agent team architectures
- Claude Max / Cowork early adopters

---

## Playbook — All Techniques

---

### CC-001: Optimize CLAUDE.md for Conciseness

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Anthropic Official Docs (code.claude.com/docs/best-practices), April 2026
**Credibility:** OFFICIAL
**Model Version:** Universal

**What it is:** CLAUDE.md is loaded on **every single message** (not just per-session — every prompt rereads it). Bloated files cause Claude to ignore instructions AND burn tokens on every interaction. Each line should pass the test: "Would removing this cause Claude to make mistakes?" If not, cut it. Use emphasis ("IMPORTANT", "YOU MUST") for critical rules. Target: under 200 lines. Treat CLAUDE.md as an index that routes to files, not a dump.

**Implementation:**
1. Audit existing CLAUDE.md in asf-graphics-app repo (`~/Projects/asf-graphics-app/`)
2. For every line, apply the deletion test
3. Move domain knowledge and workflows that aren't needed every message into `.claude/skills/` (on-demand loading)
4. Add emphasis markers to the 3-5 most critical rules
5. Keep under 200 lines — route to other files for detail
6. Add token-saving rules: "Do not make any changes until you have 95% confidence in what you need to build. Ask me follow-up questions until you reach that confidence level."
7. Test: Does Claude's behavior actually change? If instructions are being ignored, the file is too long.

**Logan Relevance:** NEW
**Impact Estimate:** HIGH — directly affects every Claude Code message quality AND token cost
**Effort:** LOW (~30 min per project)
**Dependencies:** NONE
**Compounding:** Enables CC-002, CC-003, CC-004. Reduces per-message overhead for entire session.

---

### CC-002: Create Project-Specific Claude Code Skills

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Anthropic Docs + Udemy Claude Code Masterclass (Arunprabu, Feb 2026)
**Credibility:** OFFICIAL + VERIFIED
**Model Version:** 4.x+

**What it is:** Skills are instruction folders in `.claude/skills/` that Claude loads on demand. Unlike CLAUDE.md (loaded every message), skills only load when relevant. This keeps the base context lean while allowing deep domain knowledge when needed.

**Implementation:**
1. Create `.claude/skills/` directory in asf-graphics-app repo
2. Create skill files for repeatable workflows: `deploy-checklist.md`, `schema-migration.md`, `component-build.md`
3. Each skill file: description at top (triggers when Claude should load it), then step-by-step instructions
4. Test by asking Claude Code to perform a task covered by a skill — verify it loads the skill
5. Note from ultraplan testing: cloud sessions sometimes miss skills unless you explicitly name them. Add skill names to CLAUDE.md index.

**Logan Relevance:** NEW
**Impact Estimate:** HIGH — reduces context bloat while increasing domain-specific accuracy
**Effort:** MEDIUM (~2 hrs to create initial skill set)
**Dependencies:** CC-001 (clean CLAUDE.md first, then migrate domain knowledge to skills)
**Compounding:** Amplifies every Claude Code workflow in the project

---

### CC-003: Install Code Intelligence Plugin

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Anthropic Docs (code.claude.com/docs/best-practices)
**Credibility:** OFFICIAL
**Model Version:** 4.x+

**What it is:** For typed languages (TypeScript), a code intelligence plugin gives Claude precise symbol navigation and automatic error detection after edits. Run `/plugin` to browse the marketplace.

**Implementation:**
1. Open Claude Code in asf-graphics-app
2. Run `/plugin` to open the marketplace
3. Search for TypeScript/React code intelligence plugins
4. Install the highest-rated one
5. Test: Make an edit, verify Claude detects type errors automatically

**Logan Relevance:** NEW
**Impact Estimate:** MEDIUM — reduces silent type errors and improves navigation in a 29-table, React/FastAPI codebase
**Effort:** TRIVIAL (<5 min)
**Dependencies:** NONE
**Compounding:** Improves every code edit session

---

### CC-004: Writer/Reviewer Pattern — Codex as Preferred Reviewer

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Anthropic Docs (best practices — agent teams), ykdojo tips, Nate Herk (Codex integration)
**Credibility:** OFFICIAL + VERIFIED
**Model Version:** 4.x+

**What it is:** Use separate contexts for writing and reviewing code. A fresh reviewer catches bugs that the writer is blind to. **Preferred implementation:** Use Codex plugin (GPT 5.4) as the reviewer — it's free, uses a different model (catches different bug classes), and benchmarks show it beats Opus 4.6 on most coding tasks except SWE-bench. Fallback: two Claude Code sessions if Codex isn't suitable for the task.

**Implementation:**
1. Install Codex plugin via `/plugin` marketplace or Claude Code CLI
2. Build feature with Claude Code (writer)
3. Run Codex review on changed files (reviewer) — it creates a review branch and diffs
4. Feed Codex findings back to Claude Code for fixes
5. Fallback: Open two terminal sessions — one writes, one reviews as fresh context
6. For PRs: reviewer session creates the draft PR

**Logan Relevance:** NEW
**Impact Estimate:** HIGH — catches bugs before deploy, especially valuable with push-to-main workflow. Codex is free (doesn't consume Claude tokens).
**Effort:** LOW (~15 min to set up)
**Dependencies:** Free ChatGPT account for Codex plugin access
**Compounding:** Pairs with CC-001, CC-007 (ultraplan), CC-005 (PR automation)

---

### CC-005: Git PR Automation with Claude Code

**Category:** Claude Code
**Platform:** Claude Code
**Source:** ykdojo/claude-code-tips, Udemy Claude Code Masterclass
**Credibility:** VERIFIED
**Model Version:** 4.x+

**What it is:** Claude Code can create draft PRs, generate PR descriptions, and even respond to GitHub issues tagged with @claude by generating fixes and opening PRs automatically. For Logan's push-to-main workflow, even using draft PRs as a review step before merging adds a quality gate.

**Implementation:**
1. Install GitHub CLI (`gh`) if not already installed
2. Authorize Claude Code to trigger GitHub actions
3. Instead of pushing directly to main, have Claude create a draft PR with description
4. Review the PR diff (use GitHub Desktop as visual diff tool)
5. Merge when satisfied
6. Optional: Set up @claude tagging on GitHub issues for automated fix generation

**Logan Relevance:** NEW — currently pushes directly to main with no PR review
**Impact Estimate:** MEDIUM — adds quality gate without slowing velocity significantly
**Effort:** LOW (~30 min setup)
**Dependencies:** GitHub CLI installed
**Compounding:** Pairs with CC-004 (Codex reviews the PR), CC-007 (ultraplan can execute to PR)

---

### CC-006: Hooks for Automated Quality Checks

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Anthropic Docs, Udemy Masterclass
**Credibility:** OFFICIAL
**Model Version:** 4.x+

**What it is:** Hooks are automated actions that trigger on Claude Code events (before/after edits, before commit, etc.). Use them for: auto-running lint after edits, type checking before commits, running tests before PR creation.

**Implementation:**
1. Research available hook triggers in Claude Code docs
2. Create a pre-commit hook: run `npm run build` and `tsc --noEmit`
3. Create a post-edit hook: run relevant linter on changed files
4. Test that hooks fire correctly and don't slow down the workflow excessively

**Logan Relevance:** NEW
**Impact Estimate:** MEDIUM — automates the "npm run build before pushing" rule already in logan-os
**Effort:** MEDIUM (~1 hr to configure and test)
**Dependencies:** NONE
**Compounding:** Enforces existing deploy rules automatically instead of relying on memory

---

### CC-007: Ultraplan for Complex Planning Sessions

**Category:** Claude Code
**Platform:** Claude Code CLI only (not VS Code extension, not desktop app)
**Source:** Nate Herk "Planning In Claude Code Just Got a Huge Upgrade" + Anthropic Docs (code.claude.com/docs/ultraplan)
**Credibility:** OFFICIAL + VERIFIED
**Model Version:** 4.6 (always uses Opus 4.6 in cloud)

**What it is:** `/ultraplan` offloads planning to Anthropic's cloud infrastructure running Opus 4.6 with multi-agent exploration (3 parallel exploration agents + 1 critique agent). Returns a structured plan you review in-browser with inline comments. ~2x faster than local planning. Terminal stays free during planning. Requires git repo + Claude Code on the web account.

**Implementation:**
1. Ensure asf-graphics-app has git initialized and pushed (already done — GitHub private repo)
2. For any complex feature or refactor (3+ files, architectural decisions): type `/ultraplan [task description]` in CLI
3. Terminal stays free — run `/tasks` to monitor progress
4. Review plan in browser, leave inline comments for refinement
5. Choose execution: "Approve and execute on web" (generates PR) or "Teleport back to terminal"
6. For simple changes (single file, quick fix): continue using local plan or no plan
7. **Known limitation:** 3 plan variants (Simple, Visual, Deep) assigned via A/B testing — you can't control which you get
8. **Known limitation:** Plans against a frozen git snapshot — commit and push before launching for critical tasks

**Logan Relevance:** NEW — replaces local /plan for complex tasks. Also supersedes PR-001 (extended thinking) for Claude Code.
**Impact Estimate:** HIGH — complex features currently planned in-session, burning local tokens and context. This offloads to cloud Opus.
**Effort:** TRIVIAL (<5 min — just start using the command)
**Dependencies:** Git repo synced (done), Claude Code on the web account (Max plan covers this)
**Compounding:** Pairs with CC-004 (Codex reviews the ultraplan output), CC-005 (ultraplan can execute to PR)

---

### CC-008: AutoDream Memory Consolidation

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Nate Herk "Claude Code Just Dropped Memory 2.0" + Anthropic docs/community verification
**Credibility:** VERIFIED (feature exists, multiple independent confirmations)
**Model Version:** 4.x+

**What it is:** AutoDream runs between sessions (or on-demand via `/dream`) to consolidate Claude Code's memory files. It follows a 4-phase process: Orient → Gather → Consolidate → Prune. Merges duplicates, converts relative dates to absolute, removes stale references, deletes contradictions. Keeps MEMORY.md under 200 lines. Like REM sleep for Claude's memory.

**Implementation:**
1. Back up `~/.claude/projects/` directory as safety net before first run
2. In Claude Code: run `/memory`
3. Toggle Auto-dream to ON (Auto-memory should already be ON)
4. Run `/dream` manually for first pass on asf-graphics-app
5. Review what was added/removed — verify nothing critical was pruned
6. Let it run automatically on schedule going forward
7. Periodically audit memory files to ensure quality

**Logan Relevance:** NEW — directly addresses "Memory strategy — organic accumulation vs. deliberate seeding" gap
**Impact Estimate:** HIGH — after hundreds of sessions, memory files are almost certainly bloated with contradictions and stale references
**Effort:** TRIVIAL (<5 min to enable)
**Dependencies:** Auto-memory ON (likely already is)
**Compounding:** Improves every future Claude Code session. Cleaner memory = less wasted context = better output.

---

### CC-009: Auto Mode for Permissions

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Nate Herk "STOP Using Bypass Permissions" + Anthropic release notes
**Credibility:** VERIFIED
**Model Version:** 4.x+

**What it is:** Auto mode sits between default ask-everything and dangerously-skip-permissions. Uses a classifier before each tool call to assess risk. Safe actions (file reads, git status, non-destructive edits) execute automatically. Risky actions (deletions, sensitive data access) get flagged. Slightly more expensive per session due to classifier overhead.

**Implementation:**
1. Run `claude --enable-auto-mode` or toggle in VS Code extension → permissions → auto mode
2. Test with known-safe workflow (editing files, running build) — verify it doesn't interrupt
3. Test with risky action (delete command) — verify it flags for approval
4. Compare against current settings.local.json allow/deny lists — auto mode may complement or replace them
5. Keep deny list for operations you NEVER want (rm -rf, drop table, etc.)

**Logan Relevance:** NEW
**Impact Estimate:** MEDIUM — removes friction from long-running build sessions
**Effort:** TRIVIAL (<5 min)
**Dependencies:** Verify availability on Max plan (was initially Team-only research preview)
**Compounding:** Pairs with CC-007 (ultraplan execution runs uninterrupted)

---

### CC-010: Manual Compact at 60% Context

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Nate Herk "18 Easy Fixes"
**Credibility:** VERIFIED
**Model Version:** Universal

**What it is:** Auto-compact triggers at ~95% context, by which point output quality has already degraded ("lost in the middle" phenomenon — models pay most attention to beginning and end, not middle). Manually compact at 60% with specific instructions on what to preserve. After 3-4 compacts in one session, start fresh with a summary handoff.

**Implementation:**
1. Set up status line (CC-011) to monitor context percentage
2. At ~60% context: run `/compact preserve all information about [current feature/task]`
3. After 3-4 compacts in one session: `/summary` → `/clear` → paste summary into fresh session
4. Consider adding to CLAUDE.md: "Alert me when context exceeds 60%"
5. If you step away for >5 min (prompt cache expires), consider compacting before the break

**Logan Relevance:** UPGRADE to WA-003 (fresh session for code review) — specific tactical implementation
**Impact Estimate:** MEDIUM — prevents quality degradation mid-build
**Effort:** TRIVIAL (behavioral change)
**Dependencies:** CC-011 (status line for visibility)
**Compounding:** Directly extends session productivity

---

### CC-011: Status Line for Token/Context Visibility

**Category:** Claude Code
**Platform:** Claude Code CLI
**Source:** Nate Herk "18 Easy Fixes"
**Credibility:** VERIFIED
**Model Version:** Universal

**What it is:** Configure terminal status line to show: current model, context % used, token count. Real-time visibility into context consumption.

**Implementation:**
1. In Claude Code terminal: run `/status-line`
2. Configure to show: model name, context percentage bar, token count
3. Or ask Claude Code: "Set up my status line to show model name, context percentage bar, and token count"

**Logan Relevance:** NEW
**Impact Estimate:** LOW-MEDIUM — visibility tool enabling better decisions
**Effort:** TRIVIAL (<5 min)
**Dependencies:** NONE
**Compounding:** Enables CC-010 (knowing when to compact)

---

### CC-012: Disconnect Unused MCP Servers Per Session

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Nate Herk "18 Easy Fixes"
**Credibility:** VERIFIED
**Model Version:** Universal

**What it is:** Every connected MCP server loads its full tool definitions into context on every message. One server alone can cost ~18K tokens per message. Run `/mcp` at session start and disconnect servers not needed for the current task. Consider CLIs over MCP where available (e.g., `gh` CLI instead of GitHub MCP).

**Implementation:**
1. At start of each Claude Code session: run `/mcp` → review connected servers
2. Disconnect any servers not needed for the current task
3. Audit which MCP servers are globally connected vs. project-specific
4. For frequently used tools with CLIs (git, GitHub): prefer CLI over MCP
5. Run `/context` to see token impact of connected MCPs

**Logan Relevance:** NEW — need to verify Claude Code MCP state (logan-current-setup only lists Claude.ai MCPs)
**Impact Estimate:** MEDIUM — could save 50K+ tokens per session if multiple MCPs are connected
**Effort:** TRIVIAL (<5 min per session)
**Dependencies:** NONE
**Compounding:** Directly extends token budget

---

### CC-013: Codex Plugin for Adversarial Code Review

**Category:** Claude Code
**Platform:** Claude Code
**Source:** Nate Herk "Codex Just 10x'd Claude Code Projects"
**Credibility:** VERIFIED
**Model Version:** 4.x+ (uses GPT 5.4 via free ChatGPT subscription)

**What it is:** OpenAI's official Codex plugin for Claude Code. Uses GPT 5.4 for adversarial code reviews — catching bugs Claude misses because it's reviewing its own code. Free tier available. GPT 5.4 beats Opus 4.6 on most coding benchmarks except SWE-bench. Claude is better at planning and creative architecture; Codex is better at catching edge cases, overengineering, and long-run drift.

**Implementation:**
1. In Claude Code: install Codex plugin via `/plugin` marketplace
2. After building a feature: run Codex review on changed files
3. Codex creates a review branch, diffs, reports issues by severity
4. Feed findings back to Claude Code for implementation
5. Use for all significant features before push-to-main

**Logan Relevance:** NEW — implements CC-004 (writer/reviewer) with zero Claude token cost for review
**Impact Estimate:** HIGH — free adversarial review from complementary model
**Effort:** LOW (~15 min to install and test)
**Dependencies:** Free ChatGPT account
**Compounding:** Pairs with CC-004, CC-005 (PR automation)

---

### CC-014: Channels (iMessage/Telegram/Discord) for Remote Claude Code

**Category:** Claude Code
**Platform:** Claude Code + messaging apps
**Source:** Nate Herk "Claude Code + iMessage is Finally Here"
**Credibility:** VERIFIED
**Model Version:** 4.x+

**What it is:** Channels let you text your Claude Code session from iMessage, Telegram, or Discord. Messages route through an MCP tunnel to your running terminal session. Claude Code can use all local skills, files, and API keys.

**Implementation:**
1. In Claude Code: set up channel MCP for preferred platform (iMessage recommended for Logan — Apple ecosystem)
2. Claude Code enters listening mode for channel messages
3. Text from phone → Claude Code executes locally → sends response back
4. Useful for: checking build status from field, triggering deploys, running quick queries against codebase

**Logan Relevance:** NEW — addresses "Voice-to-Claude workflows" gap. Logan does field work and could send commands remotely.
**Impact Estimate:** MEDIUM — useful for field days
**Effort:** LOW (~30 min to set up)
**Dependencies:** Claude Code running on machine, macOS for iMessage channel
**Compounding:** STANDALONE initially

---

### CC-015: Paperclip Agent Orchestration

**Category:** Workflow Automation
**Platform:** Claude Code + Paperclip (open source, MIT license)
**Source:** Nate Herk "This One Tool Turns Claude Code Into an Entire Agent Company"
**Credibility:** COMMUNITY (new tool, 36K GitHub stars, MIT license, but only weeks old)
**Model Version:** 4.x+

**What it is:** Open-source orchestration layer for managing multiple Claude Code agent sessions. Dashboard with agent management, task ticketing, heartbeats (scheduled wake-ups), routines, budget controls per agent, and pre-built company templates. Solves multi-terminal coordination problems.

**Implementation:** Defer — evaluate after core Claude Code optimization is complete.

**Logan Relevance:** FUTURE — revisit when agent teams become part of workflow
**Impact Estimate:** LOW (currently) — HIGH potential at scale
**Effort:** HIGH (significant setup and learning curve)
**Dependencies:** Core Claude Code optimizations first (CC-001 through CC-012)
**Compounding:** Would amplify agent teams if/when adopted

---

### PR-001: Extended Thinking for Complex Problems

**Category:** Prompting Patterns
**Platform:** Claude.ai ONLY (for Claude Code, use CC-007 Ultraplan instead)
**Source:** DreamHost tested techniques, Anthropic docs
**Credibility:** OFFICIAL + VERIFIED
**Model Version:** 4.x+

**What it is:** Extended thinking mode shows dramatic improvement on complex reasoning. For Claude Code, this is now superseded by CC-007 (Ultraplan) which uses multi-agent Opus 4.6 automatically. Keep this technique for Claude.ai conversations only (Genesis advisory, strategic analysis).

**Implementation:**
1. For complex strategic decisions in Claude.ai: explicitly request extended thinking
2. Frame: "Think through this step by step. Identify key factors, consider counterarguments, work through the logic, then conclude."
3. For Claude Code: use `/ultraplan` instead — it invokes extended reasoning automatically

**Logan Relevance:** UPGRADE — partially superseded by CC-007 for Claude Code use cases
**Impact Estimate:** MEDIUM — improves complex decision quality in Genesis advisory sessions
**Effort:** TRIVIAL
**Dependencies:** NONE
**Compounding:** Improves Genesis advisory and design sessions

---

### PA-001: RAG-Aware Knowledge File Design

**Category:** Project Architecture
**Platform:** Claude.ai
**Source:** Anthropic support docs, Claude Projects guides
**Credibility:** OFFICIAL
**Model Version:** Universal

**What it is:** On paid plans, Claude automatically enables RAG when project knowledge approaches context limits, expanding capacity 10x. But RAG works on chunks, not whole documents. Knowledge files designed with clear section headers, self-contained sections, and front-loaded key information perform better under RAG retrieval.

**Implementation:**
1. Audit each project's knowledge files for RAG readability
2. Ensure every major section has a descriptive header (RAG retrieves by section)
3. Front-load the most important information in each section (first 2-3 sentences)
4. Avoid cross-references that only make sense with the full document in context
5. Test: Ask the project a question that requires finding a specific detail buried in a large knowledge file

**Logan Relevance:** UPGRADE — Logan's knowledge files are generally well-structured but not explicitly optimized for RAG chunking
**Impact Estimate:** MEDIUM — improves retrieval accuracy as knowledge files grow
**Effort:** MEDIUM (~1-2 hrs to audit and restructure across projects)
**Dependencies:** NONE
**Compounding:** Every knowledge file improvement compounds across all conversations in that project

---

### MCP-001: Playwright MCP for Browser Automation

**Category:** MCP
**Platform:** Claude Code
**Source:** ykdojo/claude-code-tips, Anthropic DevRel
**Credibility:** VERIFIED
**Model Version:** 4.x+

**What it is:** Playwright MCP gives Claude Code browser automation capabilities — navigate to pages, take screenshots, interact with elements. Install: `claude mcp add -s user playwright npx @playwright/mcp@latest`

**Implementation:**
1. Run: `claude mcp add -s user playwright npx @playwright/mcp@latest`
2. Test: Ask Claude Code to navigate to app.asfgraphics.com and take a screenshot
3. Use cases: visual regression testing, UI verification after builds

**Logan Relevance:** NEW
**Impact Estimate:** MEDIUM — enables visual verification in Claude Code
**Effort:** TRIVIAL (<5 min to install)
**Dependencies:** Node.js (already installed), npx available
**Compounding:** Enables visual verification skills

---

### MCP-002: GitHub MCP for Claude Code

**Category:** MCP
**Platform:** Claude Code
**Source:** Anthropic docs, community best practices
**Credibility:** OFFICIAL
**Model Version:** 4.x+

**What it is:** Connects Claude Code directly to GitHub for issue management, PR creation, code review, and action triggering without leaving the terminal.

**Implementation:**
1. Check if GitHub MCP is available in Claude Code's MCP registry
2. Install and authorize with GitHub credentials
3. Test: Ask Claude to list open issues on asf-graphics-app repo
4. Integrate with CC-005 (PR automation)

**Logan Relevance:** NEW
**Impact Estimate:** MEDIUM — streamlines git workflow within Claude Code
**Effort:** TRIVIAL (<5 min)
**Dependencies:** GitHub CLI or GitHub access token
**Compounding:** Pairs with CC-005 (PR automation) and CC-004 (reviewer pattern)

---

### WA-001: Morning Planning Workflow

**Category:** Workflow Automation
**Platform:** Claude Code + MCP
**Source:** Carl (Product Faculty), How I AI workflows
**Credibility:** VERIFIED
**Model Version:** 4.x+

**What it is:** Connect Claude Code to Google Calendar via MCP, create a "start day" prompt file that checks calendar, reads tasks, and surfaces priorities.

**Implementation:**
1. Ensure Google Calendar MCP is connected to Claude Code
2. Create a `/start-day` custom slash command
3. Prompt template: "Check my calendar for today. List my scheduled meetings with prep needed. Flag any conflicts. Based on [task list source], recommend my top 3 priorities for today."
4. Iterate based on what's actually useful in Logan's work pattern

**Logan Relevance:** NEW — evaluate whether this fits Logan's field work + dev work split
**Impact Estimate:** MEDIUM — depends on how much Logan uses calendar-driven planning
**Effort:** LOW (~30 min to set up and test)
**Dependencies:** Google Calendar MCP connected to Claude Code
**Compounding:** STANDALONE initially, could integrate with Linear

---

### WA-002: Double-Check Verification Prompt

**Category:** Workflow Automation
**Platform:** Universal
**Source:** ykdojo/claude-code-tips
**Credibility:** VERIFIED
**Model Version:** Universal

**What it is:** After Claude produces research or claims, use: "Double check everything, every single claim in what you produced and at the end make a table of what you were able to verify."

**Implementation:**
1. Add this as a standard follow-up prompt for research-heavy output
2. Especially useful in Genesis Advisory Mode research phases and forensic investigation
3. Consider adding to relevant project instructions

**Logan Relevance:** UPGRADE — Logan's preferences already require verification, but this specific prompt pattern is useful
**Impact Estimate:** MEDIUM — reduces hallucination risk
**Effort:** TRIVIAL
**Dependencies:** NONE
**Compounding:** Improves all research workflows

---

### WA-003: Fresh Session Discipline + Compact Protocol

**Category:** Workflow Automation
**Platform:** Claude Code / Claude.ai
**Source:** ykdojo tips, Anthropic best practices, Nate Herk "18 Easy Fixes"
**Credibility:** OFFICIAL + VERIFIED
**Model Version:** Universal

**What it is:** Context degradation is real — 98.5% of tokens in a 100+ message chat are spent rereading history. Start fresh sessions between unrelated tasks. Use `/clear` between topics. For long sessions: compact at 60% with targeted preservation. After 3-4 compacts: summary → clear → fresh session with summary. Prompt caching has a 5-minute timeout — breaks longer than 5 min reprocess everything at full cost.

**Implementation:**
1. For major features: build in Session 1, review in Session 2 (fresh) — or use Codex (CC-013)
2. When context hits 60%: `/compact preserve [specifics]`
3. After 3-4 compacts: `/summary` → `/clear` → paste summary
4. When switching tasks: `/clear` before starting new topic
5. Before breaks >5 min: consider compacting to minimize reprocessing cost

**Logan Relevance:** UPGRADE — Logan already uses Genesis handoff pattern. Apply compact protocol more consistently.
**Impact Estimate:** MEDIUM — prevents quality degradation in long sessions
**Effort:** TRIVIAL (behavioral change)
**Dependencies:** CC-011 (status line for context visibility)
**Compounding:** Pairs with CC-010, CC-011

---

## Archive (Redundant / Below Level)

| ID | Name | Reason Archived |
|---|---|---|
| PA-002 | Single-Project Anti-Pattern | Already implemented — Logan's architecture is multi-project by design |
| MS-001 | Sonnet Default / Opus Complex | Already implemented |
| — | Ollama/OpenRouter local models | Logan is on Max ($200/mo). Local models inferior. Cost ≠ bottleneck. |
| — | Obsidian knowledge base (Karpathy) | Genesis Framework + multi-project architecture already serves this purpose |
| — | /buddy virtual pets | April Fools feature. Zero utility. |
| — | Basic visibility tips (dashboard, watch Claude work) | Below Logan's level |
| — | Batch prompts | Already implied by User Preferences |
| — | Prompt cache 5-min timeout | Good to know, not independently actionable |

---

## Implementation Priority Queue

**STATUS:** This priority queue is outdated. Most items have been implemented across Sprints 1-3 (April 7-12, 2026). See implementation-log-v4.md for current status. See Claudious queue/ and proposals/ for the live pipeline.

Ranked by impact × effort, accounting for dependencies and compounding:

| # | ID | Name | Effort | Key Reason |
|---|---|---|---|---|
| 1 | CC-008 | AutoDream Memory Consolidation | TRIVIAL | One toggle. Cleans hundreds of sessions of memory debt immediately. |
| 2 | CC-011 | Status Line Setup | TRIVIAL | 5 min. Enables visibility for CC-010 (compact protocol). |
| 3 | CC-007 | Ultraplan | TRIVIAL | Just use `/ultraplan` on next complex task. Instant planning upgrade. |
| 4 | CC-001 | CLAUDE.md Optimization | LOW | Per-message reloading makes this MORE urgent than originally estimated. |
| 5 | CC-013 | Codex Plugin (Adversarial Review) | LOW | Free adversarial review. Biggest code quality gate available. |
| 6 | CC-009 | Auto Mode Permissions | TRIVIAL | Removes friction from build sessions. |
| 7 | CC-010 | Manual Compact at 60% | TRIVIAL | Behavioral change. Compact earlier + targeted preservation. |
| 8 | CC-012 | Disconnect Unused MCP Servers | TRIVIAL | Per-session hygiene. Quick token savings. |
| 9 | CC-002 | Claude Code Skills | MEDIUM | Move domain knowledge out of CLAUDE.md into on-demand skills. |
| 10 | CC-006 | Hooks for Quality Checks | MEDIUM | Automate pre-commit linting/type checking. |
| 11 | CC-003 | Code Intelligence Plugin | TRIVIAL | Browse `/plugin` marketplace. |
| 12 | CC-005 | Git PR Automation | LOW | Quality gate for push-to-main workflow. |
| 13 | CC-014 | Channels (iMessage) | LOW | Remote build commands from field. |
| 14 | MCP-001 | Playwright MCP | TRIVIAL | Visual verification capability. |
| 15 | MCP-002 | GitHub MCP | TRIVIAL | Streamlines git workflow. |
| 16 | PA-001 | RAG-Aware Knowledge Files | MEDIUM | Long-term compounding across projects. |
| 17 | WA-002 | Verification Prompt | TRIVIAL | Research quality improvement. |
| 18 | WA-001 | Morning Planning Workflow | LOW | Evaluate fit with Logan's work pattern. |
| 19 | CC-015 | Paperclip Agent Orchestration | HIGH | Defer until agent teams are part of workflow. |
