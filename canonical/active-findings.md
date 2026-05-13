# Active Findings

Last updated: 2026-05-13

Queue of findings from daily intake. Process triages → graduate to `canonical/prompting-rules.md` or `canonical/antipatterns.md`, propose to Logan, or archive.

Action values:
- `queued` — default, awaiting process
- `proposed` — needs Logan review
- `graduated` — promoted to canonical rules/antipatterns
- `archived` — merged to archive only

Intake only sets `queued`. Process/curate update the rest.

---

### [2026-05-13] cc-goal-command
**Source:** https://code.claude.com/docs/en/goal
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code adds `/goal` slash command. Sets a completion condition; Claude keeps working across turns until it's met. Works in interactive, `-p`, and Remote Control modes.
**Action:** queued

### [2026-05-13] cc-agent-view
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code adds agent view (Research Preview): `claude agents` lists every session — running, blocked on you, or done.
**Action:** queued

### [2026-05-13] cc-xhigh-effort
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code adds `xhigh` effort level for Opus 4.7, sitting between `high` and `max`.
**Action:** queued

### [2026-05-13] cc-routines-feature
**Source:** https://releasebot.io/updates/anthropic/claude
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code Routines now ship with access to repos and connectors; package automations and run on a schedule or trigger. First-party alternative to user-built cron+MCP pipelines.
**Action:** queued

### [2026-05-13] cc-resume-67pct-faster
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** `/resume` on large sessions is up to 67% faster and offers to summarize stale large sessions before re-reading them.
**Action:** queued

### [2026-05-13] cc-opus47-context-fix
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Fixed Opus 4.7 sessions showing inflated `/context` percentages and autocompacting too early.
**Action:** queued

### [2026-05-13] cc-limits-doubled-spacex
**Source:** https://www.pcworld.com/article/3132997/anthropic-doubles-claude-code-limits-thanks-to-a-deal-with-spacex.html
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Anthropic doubled Claude Code's 5-hour rate limits across Pro, Max, Team, and Enterprise; removed peak-hours reduction. Backed by 300+ MW SpaceX Colossus 1 compute partnership.
**Action:** queued

### [2026-05-13] automatic-cache-control
**Source:** https://docs.claude.com/en/release-notes/overview
**Credibility:** OFFICIAL
**Type:** MODEL-STATE
**Summary:** Messages API adds automatic caching via a single `cache_control` field that auto-caches the last cacheable block.
**Action:** queued

### [2026-05-13] claude-desktop-remote-mcp-oauth
**Source:** https://www.mcpbundles.com/blog/state-of-mcp-clients
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Desktop now supports remote MCP servers as Custom Connectors with native OAuth.
**Action:** queued

### [2026-05-13] claude-platform-aws-ga
**Source:** https://aws.amazon.com/blogs/machine-learning/introducing-claude-platform-on-aws-anthropics-native-platform-through-your-aws-account/
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude Platform on AWS launched — Anthropic-managed Claude API via AWS account, AWS billing + IAM, full Messages/Files/Batches/Managed-Agents/Skills/tool-use.
**Action:** queued

### [2026-05-13] aws-mcp-server-ga
**Source:** https://aws.amazon.com/about-aws/whats-new/2026/05/aws-mcp-server/
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** AWS MCP Server GA (May 6, 2026). Single tool calls any AWS API; sandboxed Python execution for multi-step ops.
**Action:** queued

### [2026-05-13] mcp-stdio-cve-may2026
**Source:** https://adversa.ai/blog/top-mcp-security-resources-may-2026/
**Credibility:** ANECDOTAL
**Type:** NEWS
**Summary:** Single source reports two interpretations: STDIO transport vulnerability "exposing hundreds of thousands of servers," and a "critical CVSS 9.8 flaw in NGINX integrations." Second source needed before crediting either claim as VERIFIED.
**Action:** queued

### [2026-05-13] cowork-mcp-action-restriction
**Source:** https://releasebot.io/updates/anthropic/claude
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Cowork admins can restrict MCP connector actions per organization (e.g. allow read, disable write).
**Action:** queued

### [2026-05-13] cowork-ga-org-controls
**Source:** https://www.anthropic.com/product/claude-cowork
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Claude Cowork generally available on all paid plans with role-based access, group spend limits, OpenTelemetry, Zoom connector, and SIEM-compatible event emission.
**Action:** queued

### [2026-05-13] cc-plan-mode-default
**Source:** https://x.com/bcherny/status/2017742741636321619
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Boris Cherny (Claude Code creator) reports: start most sessions in Plan mode and iterate until the plan is good, then switch to auto-accept edits; Claude usually one-shots the PR.
**Action:** queued

### [2026-05-13] cc-slash-commands-inner-loop
**Source:** https://x.com/bcherny/status/2017742741636321619
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Boris Cherny reports: use slash commands for every inner-loop workflow done many times a day; check them into `.claude/commands/`. Example given: `/commit-push-pr`.
**Action:** queued

### [2026-05-13] claude-md-prune-ruthlessly
**Source:** https://x.com/bcherny/status/2017742741636321619
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Boris Cherny reports: avoid over-specified `CLAUDE.md` where important rules drown in noise. Ruthlessly prune; delete rules CC already follows or convert them to hooks.
**Action:** queued

### [2026-05-13] cc-verification-2-3x
**Source:** https://code.claude.com/docs/en/best-practices
**Credibility:** COMMUNITY
**Type:** TECHNIQUE
**Summary:** Giving Claude a way to verify its work can 2-3x the quality of the final result (also echoed in official best-practices).
**Action:** queued

### [2026-05-13] canonical-schema-mismatch
**Source:** archive/intake/2026-05-13.md Section D
**Credibility:** OFFICIAL (internal observation)
**Type:** BEHAVIOR
**Summary:** Intake routine references canonical files that don't exist (claude-state.md, claude-code-state.md, active-findings.md, pipeline-flags.md, logan-current-stack.md, grok-scan-sources.md, prompting-rules.md, antipatterns.md, open-decisions.md, briefing-today.md). Current repo has only state.md, playbook.md, changelog.md, hooks/.
**Action:** queued

### [2026-05-13] harness-branch-vs-routine-main
**Source:** archive/intake/2026-05-13.md Section D
**Credibility:** OFFICIAL (internal observation)
**Type:** BEHAVIOR
**Summary:** Section 0 preflight aborts when not on main, but the cloud harness designates a feature branch and forbids pushing to other branches. Conflict requires explicit resolution.
**Action:** queued

### [2026-05-13] no-hardcoded-entities-in-routines (re-seed)
**Source:** 2026-04-19 Grok pipeline adaptability audit (via task description)
**Credibility:** OFFICIAL (internal rule seed)
**Type:** TECHNIQUE
**Summary:** Routine prompts, scans, automated pipelines targeting people/products/URLs/versions/org-state must reference a canonical config file by URL, not inline the list. Exceptions: zero-rot entities. Quarterly staleness-audit.
**Action:** queued

### [2026-05-13] verification-prompts-suppress-self-report (re-seed)
**Source:** 2026-04-19 handoff generation session (via task description)
**Credibility:** OFFICIAL (internal rule seed)
**Type:** TECHNIQUE
**Summary:** Prompts that request verification outputs (commit SHAs, file contents, git status) must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block. Otherwise the self-report overrides the requested verification, forcing re-run.
**Action:** queued

### [2026-05-13] grok-pipeline-flag-missing
**Source:** archive/intake/2026-05-13.md Section D
**Credibility:** OFFICIAL (internal observation)
**Type:** BEHAVIOR
**Summary:** `canonical/pipeline-flags.md` does not exist. B.0 treats this as "skip entirely" with no state recorded. Either expected during bootstrap (fine) or a config gap to fill.
**Action:** queued
