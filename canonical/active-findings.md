# Active Findings — Last 7 Days

**Last updated:** 2026-04-26
**Scope:** Intake findings captured in the last 7 days that have not yet graduated to `prompting-rules.md` / `antipatterns.md` or been archived.
**Refresh:** Maintained by the `intake` routine — new findings appended, items graduated or >7 days old removed.

---

## Format per finding

```
### <kebab-id>
**Captured:** YYYY-MM-DD — from intake section B/C/D
**Severity:** HIGH / MEDIUM / LOW
**Credibility:** OFFICIAL / VERIFIED / COMMUNITY
**Finding:** <1–2 sentence summary>
**Logan relevance:** <what it unlocks or threatens>
**Graduation path:** <which canonical file or proposals/ it targets> | pending Process deploy | superseded
```

---

## 2026-04-17 Intake (novelty=high, 13 findings)

### ultraplan-cloud-preview
**Captured:** 2026-04-17 — B-1
**Severity:** HIGH | **Credibility:** OFFICIAL
**Finding:** Week 15 preview ships Ultraplan — draft plans in cloud CLI, review in web editor, run remotely or pull back locally. Auto-creates cloud env on first run.
**Logan relevance:** Replaces local /plan for 3+ file tasks. Matches CC-007 already in playbook.
**Graduation path:** Already captured in `canonical/claude-code-state.md` → Planning Workflows.

### monitor-loop-team-onboarding-autofix-commands
**Captured:** 2026-04-17 — B-1
**Severity:** HIGH | **Credibility:** OFFICIAL
**Finding:** Week 15 adds Monitor tool (stream background events), `/loop` self-pacing, `/team-onboarding` replayable setup guides, `/autofix-pr` terminal-side PR auto-fix.
**Logan relevance:** `/loop` and `/autofix-pr` fit existing workflows. Monitor already used in autonomous loops.
**Graduation path:** Merge into `canonical/claude-code-state.md` features list on next refresh.

### cowork-context-1m-to-200k
**Captured:** 2026-04-17 — B-4 / D
**Severity:** HIGH | **Credibility:** VERIFIED (GitHub issue filed)
**Finding:** Cowork context silently dropped from 1M → 200K after Claude Desktop v1.1.7714. All new Cowork sessions use claude-opus-4-6 at 200K. Feature flag rollback confirmed.
**Logan relevance:** `learnings/platforms/claude.md` has stale 1M claim — proposal pending (see `open-decisions.md`).
**Graduation path:** Proposal → pending Logan review.

### subagent-model-env-var
**Captured:** 2026-04-17 — B-2
**Severity:** HIGH | **Credibility:** COMMUNITY/VERIFIED
**Finding:** `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6` cuts cost 50–70% on delegated work while preserving main-session quality.
**Logan relevance:** Already deployed in PowerShell `$PROFILE` (2026-04-15). Captured in `canonical/claude-code-state.md`.
**Graduation path:** Done — no action.

### session-checkpointing-before-autonomous-runs
**Captured:** 2026-04-17 — B-2
**Severity:** HIGH | **Credibility:** COMMUNITY
**Finding:** Commit a git checkpoint before any autonomous Claude run; rollback instead of fix-forward if result is wrong. Higher success rate than in-session repair.
**Logan relevance:** Matches `/rewind` usage Logan already has in `~/.claude/CLAUDE.md`. New: explicit commit step before any Routine/Ultraplan run.
**Graduation path:** Candidate for `prompting-rules.md` — pending 2+ more citations (graduation rule).

### skills-auto-save-patterns
**Captured:** 2026-04-17 — B-2
**Severity:** HIGH | **Credibility:** COMMUNITY
**Finding:** Skills save discovered patterns as LLM-optimized docs; Claude auto-creates skill files from debugging sessions, feeds into next session context.
**Logan relevance:** Partially implemented via harvest skill + `/self-eval`. Auto-skill-creation from debug sessions is the gap.
**Graduation path:** Proposal candidate — needs design pass.

### peak-hour-usage-throttle
**Captured:** 2026-04-17 — B-4
**Severity:** HIGH | **Credibility:** VERIFIED
**Finding:** Usage limits tightened during weekday peak hours (8am–2pm ET / 5am–11am PT). Session limits burn faster.
**Logan relevance:** Schedule long Cowork / Routine work off-peak. Relevant to Claudious daily routine timing.
**Graduation path:** Captured in `canonical/claude-state.md` → Logan's Plan.

### max-tokens-300k-batch-api
**Captured:** 2026-04-17 — B-1
**Severity:** MEDIUM | **Credibility:** OFFICIAL
**Finding:** `output-300k-2026-03-24` beta header raises `max_tokens` to 300K on Batch API for Opus 4.6 + Sonnet 4.6.
**Logan relevance:** Only relevant if Logan runs batch API workloads. Currently none.
**Graduation path:** Skip — low priority, revisit if batch API use emerges.

### legacy-sonnet-opus-4-deprecation
**Captured:** 2026-04-17 — B-1
**Severity:** MEDIUM | **Credibility:** OFFICIAL
**Finding:** `claude-sonnet-4-20250514` and `claude-opus-4-20250514` retire 2026-06-15.
**Logan relevance:** Audit pinned versions in scripts and configs.
**Graduation path:** Captured in `canonical/claude-state.md` → Deprecation Schedule.

### ant-cli-launch
**Captured:** 2026-04-17 — B-1
**Severity:** MEDIUM | **Credibility:** OFFICIAL
**Finding:** `ant` CLI launched — command-line Claude API client, native Claude Code integration, YAML file versioning of API resources.
**Logan relevance:** Could replace some Codex / curl workflows. Not yet evaluated.
**Graduation path:** Evaluation candidate.

### azure-mcp-server-2-stable
**Captured:** 2026-04-17 — B-3
**Severity:** MEDIUM | **Credibility:** OFFICIAL
**Finding:** Azure MCP Server 2.0 stable (2026-04-10) — strengthened HTTP auth, injection-pattern safeguards, smaller container images.
**Logan relevance:** Not currently on Azure. Skip unless that changes.
**Graduation path:** Skip.

### caveman-mode-token-reduction
**Captured:** 2026-04-17 — B-6
**Severity:** MEDIUM | **Credibility:** COMMUNITY (10K+ upvotes)
**Finding:** "Caveman mode" — strip Claude to tool-first, result-first, no-explanation responses. Community reports 75% output token reduction.
**Logan relevance:** Already implemented as global `caveman` skill with lite/full/ultra intensity levels.
**Graduation path:** Done — no action.

### rollback-path-windows-tilde-bug
**Captured:** 2026-04-17 — D
**Severity:** MEDIUM | **Credibility:** VERIFIED
**Finding:** `C:\Users\logan\.claude\CLAUDE.md` line 34 references `~/Projects/claudious/scripts/rollback-config.sh` — tilde only resolves in WSL/Linux. PowerShell invocation silently fails.
**Logan relevance:** Emergency rollback could fail silently when most needed.
**Graduation path:** Proposal → pending Logan review (see `open-decisions.md`).

---

## 2026-04-20 Intake (novelty=high, 14 findings)

### [2026-04-20] mcp-500k-result-limit
**Source:** https://code.claude.com/docs/en/whats-new
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** MCP tool result limit raised to 500,000 characters via `_meta["anthropic/maxResultSizeChars"]`. Previously capped lower; large payloads truncated.
**Action:** queued

### [2026-04-20] managed-agents-public-beta
**Source:** https://docs.claude.com/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Claude Managed Agents launched in public beta with the `managed-agents-2026-04-01` beta header. Anthropic-hosted agent runtime.
**Action:** queued

### [2026-04-20] sonnet-1m-context-beta-retirement
**Source:** https://docs.claude.com/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** 1M token context window beta on Sonnet 4.5 and Sonnet 4 retires 2026-04-30. 10-day window; audit Sonnet 4.5/4 pinned callers relying on 1M context.
**Action:** queued

### [2026-04-20] haiku-3-retired
**Source:** https://docs.claude.com/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** `claude-3-haiku-20240307` retired 2026-04-19. Any pinned caller now errors; switch to Haiku 4.5.
**Action:** queued

### [2026-04-20] disable-skill-shell-execution
**Source:** https://code.claude.com/docs/en/whats-new/2026-w14
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** `disableSkillShellExecution` setting blocks inline shell execution inside skills and slash commands. Security hardening when running third-party skills.
**Action:** queued

### [2026-04-20] edit-tool-cat-sed-view
**Source:** https://code.claude.com/docs/en/whats-new/2026-w14
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Edit tool now works on files previously viewed via `cat` or `sed` — no separate Read required.
**Action:** queued

### [2026-04-20] push-notification-tool
**Source:** https://code.claude.com/docs/en/whats-new
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code ships a push-notification tool — mobile push when Remote Control and "Push when Claude decides" are enabled in config.
**Action:** queued

### [2026-04-20] doctor-mcp-scope-warning
**Source:** https://code.claude.com/docs/en/whats-new
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** `/doctor` warns when an MCP server is defined in multiple config scopes with different endpoints.
**Action:** queued

### [2026-04-20] computer-use-cli-preview
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Computer Use reaches the CLI in research preview — Claude opens native apps, clicks UI, and verifies changes from the terminal.
**Action:** queued

### [2026-04-20] computer-use-cowork-max
**Source:** https://releasebot.io/updates/anthropic/claude
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Computer Use available in Cowork and Claude Code for Pro and Max users.
**Action:** queued

### [2026-04-20] persistent-agent-thread-mobile
**Source:** https://releasebot.io/updates/anthropic/claude
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Persistent agent thread for Pro and Max to manage Cowork tasks from mobile and desktop. Rolled to Max first, Pro two days later.
**Action:** queued

### [2026-04-20] cowork-ga-desktop
**Source:** https://claude.com/product/cowork
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude Cowork generally available on macOS and Windows in Claude Desktop. Adds expanded analytics, OpenTelemetry support, RBAC for Enterprise.
**Action:** queued

### [2026-04-20] mcp-spec-oauth-2-1
**Source:** https://use-apify.com/blog/mcp-server-handbook-2026
**Credibility:** VERIFIED
**Type:** TOOL
**Summary:** MCP spec now includes OAuth 2.1 with incremental scope consent (April 2026). Affects authentication for self-hosted MCP servers.
**Action:** queued

### [2026-04-20] operating-model-5-parts
**Source:** https://medium.com/@richardhightower/claude-code-2026-the-daily-operating-system-top-developers-actually-use-d393a2a5186d
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Emerging OS-for-AI-dev framework: (1) keep always-on context small; (2) procedures → skills/commands; (3) protect active sessions from context pollution; (4) parallelize only with supervision + isolation; (5) short focused sessions over marathons.
**Action:** queued

---

## 2026-04-23 Intake (routing-table refresh)

### 2026-04-23-routing-table-refresh
**Source:** Three-way deep research synthesis (Grok DeepSearch, GPT-5.5 Pro, Claude Deep Research)
**Category:** CROSS-PLATFORM
**Credibility:** VERIFIED (3-source convergence, dated official sources)
**Severity:** HIGH
**Summary:** Routing table refreshed post-GPT-5.5 launch. Key routing changes:
- Multi-file refactor stays with Claude Opus 4.7 (64.3% SWE-Bench Pro beats GPT-5.3-Codex 56.8%)
- Terminal/agentic flips to GPT-5.5 / Codex CLI (77.3% Terminal-Bench 2.0 vs Claude 69.4%)
- Code review corrected to cross-model pair mandatory (never same-model review)
- Video generation winner flips to Veo 3.1 — Sora 2 shutdown April 26
- Perplexity Model Council demoted from neutral arbiter to fast convergence check (running stale models)
- ChatGPT Agent wins browser agent routing (68.9% BrowseComp SOTA)
- Knowledge work stays with Claude via Cowork stack (single highest-ROI for Max subscription)
- Three new compounding chains documented (research/synthesis/sentiment, build/review/final, deep research/verification/deliverable)

**Action taken:** Routing table, compounding chains file, and three canonical files updated in commit `claude/routing-table-2026-04-23`.
**Flag:** GPT-5.5 API not yet live; do not update automated routing for API-dependent paths until OpenAI ships API access.

### 2026-05-07-gpt-55-benchmark-reverification
**Source:** Self-scheduled follow-up from 2026-04-23 routing refresh
**Category:** CROSS-PLATFORM
**Credibility:** N/A (forward-looking task)
**Severity:** LOW
**Re-verify:** 2026-05-07
**Summary:** GPT-5.5 wins in terminal/agentic and architecture categories were assigned based on OpenAI launch-day claims + GPT-5.3-Codex benchmarks + inference. Independent benchmarks (Artificial Analysis, SWE-bench, Terminal-Bench, Simon Willison blog) were not yet published. Re-verify these routing calls once third-party measurements land.
**Action:** On May 7, 2026, `web_fetch` independent benchmark sources and compare against current routing table. Adjust if measured GPT-5.5 performance differs materially from launch-day claims.

### 2026-04-23-gpt-55-api-pricing-tbc
**Source:** Source disagreement across three deep research outputs
**Category:** CROSS-PLATFORM
**Credibility:** COMMUNITY (unverified)
**Severity:** LOW
**Summary:** GPT-5.5 API pricing disputed across sources. Grok research cited $5/$30 per MTok. Claude Deep Research cited "unspecified API pricing." OpenAI's help page states GPT-5.5 API access "coming very soon" without dated commitment. Do not commit routing decisions or cost projections dependent on specific GPT-5.5 API rates until OpenAI publishes official pricing.
**Action:** Monitor OpenAI pricing page weekly. Re-verify when API access launches.

### 2026-04-23-claudious-oauth-crackdown-check
**Source:** Claude Deep Research flag (shareuhack Cursor vs Claude Code 2026 article)
**Category:** CLAUDIOUS
**Credibility:** COMMUNITY (unverified direct impact)
**Severity:** LOW
**Summary:** Claude Deep Research flagged "Anthropic OAuth crackdown affecting third-party tools using Claude Code's OAuth flow." Claudious runs scheduled Claude Code routines (Intake 6am, Process 7am, Curate 8pm + weekly Health Check). If these use OAuth, they could be affected.
**Action:** Investigate whether Claudious routines authenticate via OAuth or API key. Document in `canonical/claudious-state.md`. If OAuth-based, check for impact from Anthropic's policy change.

### 2026-04-23-open-decisions-regen-stale
**Source:** manual diagnostic (Session #3, CC prompt Part B)
**Category:** CLAUDIOUS
**Credibility:** OFFICIAL (measured)
**Severity:** MEDIUM
**Summary:** `canonical/open-decisions.md` `Last updated:` stamp was 2026-04-19 as of 2026-04-23. Current proposals dir has 40 entries, but stamped file claimed 28. `git log canonical/open-decisions.md` shows ONLY the original 2026-04-17 seed commit (`cc3fc9d`) — no Process run has ever committed a regen to main. Process on 2026-04-20 completed with `proposals-created: claudemd-200-line-cap, mcp-spec-oauth-2-1, cowork-ga-desktop, operating-model-5-parts` and a `branch-note: developed on claude/intelligent-lamport-oLzsB per task assignment; PR to main to follow` — that PR presumably never merged, so Phase 3's regen never reached main. Session #3 Part B rebuilt the file (249 lines, 40 proposals) and committed it on `claude/preflight-hook-and-diagnostics`.
**Action:** Regen committed this session. Root-cause proposal filed at `archive/proposals/process-open-decisions-regen-not-landing-on-main.md` for routine-side fix. Cross-reference `cc-prompt-03-preflight-hook-and-diagnostics` Part B.

---

## 2026-04-24 Intake (Scout + Config)

### [2026-04-24] cc-2-1-118-release
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.118 released 2026-04-23. Adds vim visual mode (`v`) + visual-line (`V`), merges `/cost`+`/stats` into `/usage`, custom named themes via `/theme`, hooks can invoke MCP tools directly, `DISABLE_UPDATES` env var, WSL inherits Windows-side managed settings.
**Action:** queued

### [2026-04-24] cc-2-1-118-fix-stdio-mcp-and-headless
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.118 fixes stdio MCP servers disconnecting on stray non-JSON stdout lines, corrects headless/SDK session auto-title requests, resolves excessive memory allocation with piped output, fixes `/skills` menu scrolling, patches Remote Control session bugs. Directly relevant to Claudious headless routines + MCP heartbeat.
**Action:** queued

### [2026-04-24] hooks-invoke-mcp-directly
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code hooks can now invoke MCP tools directly (no shell-out intermediary required). Potential cleaner implementation path for Claudious SessionStart preflight/heartbeat.
**Action:** queued

### [2026-04-24] cowork-computer-use-ga
**Source:** https://support.claude.com/en/articles/12138966-release-notes
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Computer Use available in Claude Cowork and Claude Code for Pro/Max subscribers. Claude can open files, run dev tools, click, and navigate the desktop. Previously labeled "research preview" in Claudious state files; scope has expanded.
**Action:** queued

### [2026-04-24] cowork-mobile-control
**Source:** https://support.claude.com/en/articles/12138966-release-notes
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Cowork mobile control — persistent agent thread in Claude Desktop + iOS/Android lets users manage Cowork tasks from phone. Max rollout first, Pro follows over subsequent days.
**Action:** queued

### [2026-04-24] zoom-mcp-connector
**Source:** https://www.nojitter.com/ai-automation/zoom-accelerates-work-with-claude-cowork-and-code
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Zoom + Anthropic released a Zoom MCP connector. Claude Cowork/Code can query Zoom meeting insights, summaries, and action items.
**Action:** queued

### [2026-04-24] cc-removed-from-new-pro
**Source:** https://www.theregister.com/2026/04/22/anthropic_removes_claude_code_pro/
**Credibility:** VERIFIED
**Type:** NEWS
**Summary:** Anthropic removed Claude Code from the Pro plan ($20/mo) for new signups starting 2026-04-21. Existing Pro users retain web-app access. Max plan unaffected. Signal of tier repricing around long-running agents and Cowork.
**Action:** queued

### [2026-04-24] boris-claudemd-prune-aggressively
**Source:** https://code.claude.com/docs/en/best-practices
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Over-specified `CLAUDE.md` causes Claude to ignore parts of it as important rules get lost in noise. Pattern: ruthlessly prune; delete instructions Claude already follows correctly; convert repeatable rules to hooks. Candidate prompting rule — not yet canonical.
**Action:** queued

### [2026-04-24] constitutional-rule-no-hardcoded-entities-in-routines
**Source:** archive/intake/2026-04-24.md § Section D (re-seeded from 2026-04-19 audit)
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** Re-seed of constitutional-rule draft: routine prompts, scans, and pipelines must reference canonical config files rather than inlining people/products/URLs/versions/org state. Exceptions for zero-rot entities (protocol/company names). Quarterly staleness audit across canonical config files. Target `canonical/prompting-rules.md`. IMPACT: H | EFFORT: T | RISK: SAFE.
**Action:** queued

### [2026-04-24] constitutional-rule-verification-prompts-suppress-self-report
**Source:** archive/intake/2026-04-24.md § Section D (re-seeded from 2026-04-19 handoff session)
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** Re-seed of constitutional-rule draft: prompts that request verification outputs (commit SHAs, file contents, git status) must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block, otherwise the self-report overrides the requested literal output. Target `canonical/prompting-rules.md`. IMPACT: H | EFFORT: T | RISK: SAFE.
**Action:** queued

---

## 2026-04-26 Intake (Scout + Config, novelty=high)

### [2026-04-26] cc-2-1-119-release
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.119 (2026-04-23) — `/config` settings persist to `~/.claude/settings.json` with project/local/policy override precedence; `--print` mode honors agent `tools:`/`disallowedTools:` frontmatter; `--agent <name>` honors built-in `permissionMode`; `PostToolUse` + `PostToolUseFailure` hooks include `duration_ms` (excludes permission prompts and PreToolUse); subagent + SDK MCP reconfiguration connects in parallel; OpenTelemetry adds `tool_use_id` and `tool_input_size_bytes`; headless status line stdin JSON includes `effort.level` and `thinking.enabled`.
**Action:** queued

### [2026-04-26] cc-2-1-117-release
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.117 (2026-04-22) — agent frontmatter `mcpServers` loaded for main-thread agent sessions via `--agent`; model selections persist across restarts; concurrent MCP connect now default; `plugin install` installs missing dependencies even when plugin already installed; managed-settings `blockedMarketplaces` + `strictKnownMarketplaces` now enforced on plugin install/update/refresh/autoupdate; OpenTelemetry `user_prompt` events include `command_name` and `command_source`.
**Action:** queued

### [2026-04-26] cc-2-1-116-resume-perf-and-mcp
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.116 (2026-04-20) — `/resume` up to 67% faster on 40MB+ sessions; faster MCP startup with multiple stdio servers (defers `resources/templates/list` to first `@`-mention); thinking spinner inline progress; `/config` search matches option values; `/doctor` opens mid-response; `/reload-plugins` and background plugin auto-update auto-install missing dependencies.
**Action:** queued

### [2026-04-26] april-23-claude-code-postmortem
**Source:** https://www.anthropic.com/engineering/april-23-postmortem
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Anthropic postmortem covers ~month-long Claude Code quality regression with three distinct issues — Claude Code, Agent SDK, and Cowork affected; API not impacted: (1) March 4 default reasoning effort dropped high→medium for UI-freeze mitigation, reverted April 7. (2) March 26 caching change to clear idle-session thinking had a per-turn re-clear bug, fixed April 10. (3) April 16 system prompt verbosity instruction degraded coding quality, reverted April 20 (v2.1.116). Resolution: usage limits reset for all subscribers April 23.
**Action:** queued

### [2026-04-26] claude-charts-diagrams-inline-ga
**Source:** https://claude.com/blog/claude-builds-visuals
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Custom visuals (interactive charts/diagrams/visualizations rendered inline in chat and Cowork) GA on all paid plans 2026-04-22 (announced 2026-03-12 as "Imagine with Claude" preview). Implementation is HTML + SVG (not raster image generation) — interactive, scales cleanly, faster than image-gen. Beta tag remains; web + desktop, chat + Cowork.
**Action:** queued

### [2026-04-26] claude-excel-powerpoint-shared-context-skills
**Source:** https://claude.com/blog/claude-excel-powerpoint-updates
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Claude for Excel and Claude for PowerPoint share full conversation context across all open files as of 2026-04-10 — actions in one app are informed by activity in the other. Skills now usable inside Excel and PowerPoint add-ins on all paid plans. Add-ins available via Amazon Bedrock, Google Cloud Vertex AI, Microsoft Foundry, or LLM gateway (LiteLLM, Portkey, Kong) without a Claude account.
**Action:** queued

### [2026-04-26] mcp-rce-supply-chain-vulnerability
**Source:** https://www.ox.security/blog/the-mother-of-all-ai-supply-chains-critical-systemic-vulnerability-at-the-core-of-the-mcp/
**Credibility:** VERIFIED
**Type:** NEWS
**Summary:** OX Security (April 16-20) disclosed systemic command-injection / RCE vulnerability in MCP protocol affecting >150M downloads. Cursor, VS Code, Windsurf, Claude Code, and Gemini-CLI vulnerable to MCP-based prompt injection / RCE chains. Windsurf zero-interaction CVE-2026-30615. Adversa AI scan: ~38% of 500+ surveyed MCP servers lack authentication. Microsoft separately patched Azure MCP Server SSRF CVE-2026-26118 on March 10 (managed identity token exposure).
**Action:** queued

### [2026-04-26] claude-powerup-interactive-lessons
**Source:** https://claudefa.st/blog/guide/mechanics/claude-powerup
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** `/powerup` released v2.1.90 on 2026-04-01 — first-party in-terminal interactive learning system with animated demonstrations of features. Available all tiers regardless of subscription.
**Action:** queued

### [2026-04-26] claude-buddy-tamagotchi
**Source:** https://claudefa.st/blog/guide/mechanics/claude-buddy
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** `/buddy` released v2.1.89 on 2026-04-01 — terminal Tamagotchi with 18 species, 5 rarity tiers, deterministic per-user via FNV-1a→Mulberry32 PRNG. Pro+ subscription required. Easter-egg / morale feature.
**Action:** queued

### [2026-04-26] anthropic-amazon-25b-investment
**Source:** https://techcrunch.com/2026/04/20/anthropic-takes-5b-from-amazon-and-pledges-100b-in-cloud-spending-in-return/
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Amazon to invest up to additional $25B in Anthropic (on top of $8B prior). Anthropic commits $100B AWS spend over 10 years. Indirect signal that Bedrock + AWS-hosted Claude products may receive priority feature parity.
**Action:** queued

### [2026-04-26] anthropic-broadcom-tpu-3-5gw
**Source:** https://www.cnbc.com/2026/04/06/broadcom-agrees-to-expanded-chip-deals-with-google-anthropic.html
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Anthropic secured 3.5GW next-generation Broadcom TPU capacity, delivery 2027; CoreWeave multi-year NVIDIA GPU cloud capacity deal for Claude production. Capacity story; not immediately actionable.
**Action:** queued

### [2026-04-26] anthropic-revenue-9b-to-30b
**Source:** Multi-source (Releasebot consolidation + Fortune coverage)
**Credibility:** VERIFIED
**Type:** NEWS
**Summary:** Anthropic annual revenue run-rate grew from $9B late 2025 to $30B April 2026; enterprise customers ($1M+/yr) doubled from ~500 to 1000+. Context for likelihood of further pricing/tier shifts (cf. April 21 Pro Claude Code removal).
**Action:** queued

### [2026-04-26] config-learnings-platforms-claude-stale-on-opus-4-7
**Source:** archive/intake/2026-04-26.md § Section D
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** `learnings/platforms/claude.md:8` describes Claude Max as $100/month, lists Opus 4.6 only (not 4.7), references AutoDream, omits Cowork Computer Use + Persistent Agent Thread. Multi-dimensional drift overlap with 2026-04-22 PIONEER mastery-lab v4 staleness alert. Refresh proposed.
**Action:** queued

### [2026-04-26] config-toolchain-stale-scout-additions-description
**Source:** archive/intake/2026-04-26.md § Section D
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** `canonical/toolchain.md:87` describes scout-additions.md as "named watchlist (KAIROS, Chyros, Opus 4.7 updates, AutoDream)". KAIROS / Chyros / AutoDream are RETIRED targets in scout-additions.md. Toolchain description should match the file's actual Active Search Targets.
**Action:** queued

### [2026-04-26] config-scout-additions-hardcoded-mcp-server-list
**Source:** archive/intake/2026-04-26.md § Section D
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** `scheduled-tasks/scout-additions.md:21` hardcodes `Google Drive, Supabase, Stripe, Linear, Cloudflare, Hugging Face` as MCP server search targets — constitutional-rule violation per re-seeded no-hardcoded-entities-in-routines. Extract to canonical config or convert to role-based query referencing `canonical/logan-current-stack.md`.
**Action:** queued

### [2026-04-26] config-routine-prompts-hardcoded-operator-email
**Source:** archive/intake/2026-04-26.md § Section D
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** Three routine prompts (`scheduled-tasks/intake.md:23`, `process.md:21`, `curate.md:21`) hardcode `loganallensf@gmail.com` in `git config user.email`. Constitutional-rule violation; low priority since single email with low rotation rate. Defer until any other operator-identity field surfaces.
**Action:** queued

### [2026-04-26] config-mcp-rce-supply-chain-audit
**Source:** archive/intake/2026-04-26.md § Section D
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** Audit Logan's 12 MCPs (per `canonical/toolchain.md`) for: (a) authentication enabled/disabled per server, (b) marketplace source eligibility for `blockedMarketplaces`/`strictKnownMarketplaces` enforcement (functional in CC 2.1.117). Cross-finding action item from MCP-RCE vulnerability + 2.1.117 release. Schedule dedicated 30-min CC session before next cloud routine run.
**Action:** queued

---

## Graduation Rules

- Finding referenced 3+ times across `learnings/*.md` or confirmed by Logan → promote to `prompting-rules.md` or `antipatterns.md`.
- Finding >7 days old with no graduation path → archive to `archive/intake/`.
- Finding superseded by a newer finding → mark `superseded` and remove on next refresh.
