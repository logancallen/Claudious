# Active Findings — Last 7 Days

**Last updated:** 2026-04-21
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

## 2026-04-21 Intake (novelty=high, 16 findings)

### [2026-04-21] claude-code-2-1-116-release
**Source:** https://raw.githubusercontent.com/anthropics/claude-code/refs/heads/main/CHANGELOG.md
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code 2.1.116 ships `/resume` perf for 40MB+ sessions, faster MCP startup via deferred `resources/templates/list`, inline thinking-spinner progress, `/config` value search, `/doctor` mid-response, plugin auto-update installs missing deps, dangerous-path rm/rmdir safety, Bash GitHub rate-limit hints, zero-delay Usage tab metrics, agent frontmatter `hooks:` in main-thread mode.
**Action:** queued

### [2026-04-21] claude-code-2-1-113-new-details
**Source:** https://raw.githubusercontent.com/anthropics/claude-code/refs/heads/main/CHANGELOG.md
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** v2.1.113 also added `sandbox.network.deniedDomains` setting, logical-line `Ctrl+A`/`Ctrl+E` in multiline input, Windows `Ctrl+Backspace` deletes previous word, `/loop` Esc-cancel wakeups, `/extra-usage` from Remote Control, parallelized `/ultrareview` with diffstat, subagent 10-min timeout surface, `Bash(find:*)` no longer auto-approve `find -exec`, bash deny rules match `env`/`sudo`/`watch` wrappers, macOS `/private/{etc,var,tmp,home}` dangerous-for-`rm`.
**Action:** queued

### [2026-04-21] claude-opus-4-7-launch-official
**Source:** https://platform.claude.com/docs/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Claude Opus 4.7 launched April 16, 2026 at $5/$25 per MTok (same as 4.6). API breaking changes vs 4.6 documented. Already in canonical/claude-state.md — this is the OFFICIAL launch-date source confirmation.
**Action:** queued

### [2026-04-21] advisor-tool-public-beta
**Source:** https://platform.claude.com/docs/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Advisor tool public beta (April 9, 2026, header `advisor-tool-2026-03-01`). Pairs a faster executor model with a higher-intelligence advisor model providing strategic guidance mid-generation — long-horizon agentic workloads approach advisor-solo quality at executor-model token rates.
**Action:** queued

### [2026-04-21] bedrock-open-to-all-customers
**Source:** https://platform.claude.com/docs/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude in Amazon Bedrock now open to all Bedrock customers (April 16, 2026). Opus 4.7 and Haiku 4.5 self-serve via `/anthropic/v1/messages` in 27 AWS regions. Logan relevance: LOW (not on Bedrock).
**Action:** queued

### [2026-04-21] claude-mythos-glasswing-preview
**Source:** https://platform.claude.com/docs/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude Mythos Preview (April 7, 2026) — gated research preview for defensive cybersecurity under Project Glasswing. Invitation-only access. Logan relevance: LOW.
**Action:** queued

### [2026-04-21] anthropic-desktop-parallel-agents-announcement
**Source:** https://www.anthropic.com/news (April 14, 2026)
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** OFFICIAL announcement of Claude Code desktop redesign enabling parallel agents side-by-side in the sidebar. Feature already listed in canonical/claude-code-state.md; this is the dated announcement anchor.
**Action:** queued

### [2026-04-21] cowork-schedule-recurring-tasks
**Source:** https://claude.com/product/cowork
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude Cowork adds the ability to create and schedule recurring and on-demand tasks from Claude Desktop.
**Action:** queued

### [2026-04-21] customize-section-claude-desktop
**Source:** https://claude.com/product/cowork
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Desktop adds a "Customize" section grouping skills, plugins, and connectors in one place.
**Action:** queued

### [2026-04-21] peak-hour-session-limit-adjustment
**Source:** https://releasebot.io/updates/anthropic/claude
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Anthropic adjusted 5-hour session limits during peak hours for Free/Pro/Max. Weekday 5am–11am PT / 1pm–7pm GMT, session limits burn faster. Weekly limits unchanged. Refines prior peak-hour finding with the exact window + session-vs-weekly clarification.
**Action:** queued

### [2026-04-21] boris-cherny-vanilla-setup
**Source:** https://x.com/bcherny/status/2017742741636321619
**Credibility:** OFFICIAL
**Type:** TECHNIQUE
**Summary:** CC creator's team uses a single checked-in CLAUDE.md with multiple team contributions per week — updated whenever Claude does something incorrectly. Most sessions start in Plan mode; switch to auto-accept edits once plan approved.
**Action:** queued

### [2026-04-21] claude-md-ruthless-pruning
**Source:** https://alirezarezvani.medium.com/boris-chernys-claude-code-tips-are-now-a-skill-here-is-what-the-complete-collection-reveals-b410a942636b
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** If CLAUDE.md is too long, Claude ignores half of it because important rules get lost in the noise — prune ruthlessly. Always provide verification (tests, scripts, screenshots); if you can't verify, don't ship.
**Action:** queued

### [2026-04-21] session-checkpoint-rollback-third-citation
**Source:** https://www.aitooldiscovery.com/guides/claude-code-reddit
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Reddit consensus: commit a git checkpoint before autonomous runs; rollback instead of fix-forward when result is wrong. Third independent citation for prior `session-checkpointing-before-autonomous-runs` — clears 3-citation graduation threshold for `canonical/prompting-rules.md`.
**Action:** queued

### [2026-04-21] config-proposal-stale-max-price-in-learnings
**Source:** learnings/platforms/claude.md:8
**Credibility:** VERIFIED
**Type:** BEHAVIOR
**Summary:** `learnings/platforms/claude.md` line 8 says Claude Max is $100/month; canonical/logan-current-stack.md says $200/month. Stale reference — safe pointer fix.
**Action:** queued

### [2026-04-21] config-proposal-toolchain-retired-names
**Source:** canonical/toolchain.md:74
**Credibility:** VERIFIED
**Type:** BEHAVIOR
**Summary:** `canonical/toolchain.md` line 74 names KAIROS, Chyros, AutoDream as watchlist items; scheduled-tasks/scout-additions.md has retired all three. toolchain.md is manual-only per write-authority matrix — flagged for Logan update.
**Action:** queued

### [2026-04-21] config-proposal-scout-additions-hardcoded-mcp-list
**Source:** scheduled-tasks/scout-additions.md:21
**Credibility:** VERIFIED
**Type:** BEHAVIOR
**Summary:** scout-additions.md line 21 hardcodes Logan's MCP integration list (Google Drive, Supabase, Stripe, Linear, Cloudflare, Hugging Face). Violates no-hardcoded-entities-in-routines rule — should point to canonical/logan-current-stack.md instead.
**Action:** queued

---

## Graduation Rules

- Finding referenced 3+ times across `learnings/*.md` or confirmed by Logan → promote to `prompting-rules.md` or `antipatterns.md`.
- Finding >7 days old with no graduation path → archive to `archive/intake/`.
- Finding superseded by a newer finding → mark `superseded` and remove on next refresh.
