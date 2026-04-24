# Open Decisions — Proposals Awaiting Logan

**Last updated:** 2026-04-24
**Total open:** 48

Proposals are improvements that cannot auto-deploy (TEST-FIRST, REVIEW-REQUIRED, CONFLICT, or larger than TRIVIAL). Each entry points to the full proposal file in archive/proposals/.

---

### 1m-context-rollback-investigation
**File:** archive/proposals/1m-context-rollback-investigation.md
**Summary:** (see file)
**Why proposal:** Routing reason:** COMMUNITY source needs verification; EFFORT=L (not TRIVIAL) → PROPOSE
**Logan action:** review + approve/reject

### agent-skills-spec-cross-platform
**File:** archive/proposals/agent-skills-spec-cross-platform.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### archive-redundant-v2-1-x-command-proposal
**File:** archive/proposals/archive-redundant-v2-1-x-command-proposal.md
**Summary:** (see file)
**Why proposal:** Routing:** SAFE + T + md-only-within-Claudious → QUEUE
**Logan action:** review + approve/reject

### audit-autodream-status
**File:** archive/proposals/audit-autodream-status.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=L → PROPOSE
**Logan action:** review + approve/reject

### background-monitor-plugin-manifest
**File:** archive/proposals/background-monitor-plugin-manifest.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### bash-permission-bypass-patch
**File:** archive/proposals/bash-permission-bypass-patch.md
**Summary:** (see file)
**Why proposal:** Priority:** HIGH — Security
**Logan action:** review + approve/reject

### cc-removed-from-new-pro-monitor
**File:** archive/proposals/cc-removed-from-new-pro-monitor.md
**Summary:** Anthropic removed Claude Code from the Pro plan ($20/mo) for new signups starting 2026-04-21. Existing Pro users retain web-app access. Max plan is unaffected. Signal: Anthropic is repricing around long-running agents and Cowork usage; expe
**Why proposal:** - NEWS type, not a prompting rule or antipattern — doesn't fit canonical/prompting-rules.md or canonical/antipatterns.md.
**Logan action:** Option A: Archive with "monitor-only; revisit if Max plan is touched."

### clarify-rollback-script-windows
**File:** archive/proposals/clarify-rollback-script-windows.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=L → PROPOSE
**Logan action:** review + approve/reject

### claudemd-prune-aggressively-rule
**File:** archive/proposals/claudemd-prune-aggressively-rule.md
**Summary:** Over-specified `CLAUDE.md` causes Claude to ignore parts of it because important rules get lost in noise. Recommended pattern: ruthlessly prune; delete instructions Claude already follows correctly; convert repeatable rules to hooks. Aligns
**Why proposal:** - Credibility is COMMUNITY (Boris Cherny is authoritative for CC, but the specific rule wording is community-restated). Auto-queue demands the rule be safe to mirror to `canonical/prompting-rules.md` verbatim — COMMUNITY credibility falls
**Logan action:** Decide:

### clear-resolved-bash-permission-alert
**File:** archive/proposals/clear-resolved-bash-permission-alert.md
**Summary:** (see file)
**Why proposal:** Routing:** SAFE + M + md-only → QUEUE
**Logan action:** review + approve/reject

### close-bash-permission-bypass-proposal
**File:** archive/proposals/close-bash-permission-bypass-proposal.md
**Summary:** (see file)
**Why proposal:** Routing reason:** Judgment call — Logan should confirm the resolution before the proposal is archived (version verification on BOTH machines matters for a security patch) → PROPOSAL
**Logan action:** review + approve/reject

### compile-time-feature-flags-radar
**File:** archive/proposals/compile-time-feature-flags-radar.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### computer-use-stale-research-preview-label
**File:** archive/proposals/computer-use-stale-research-preview-label.md
**Summary:** `canonical/claude-code-state.md:44` reads:
**Why proposal:** `canonical/claude-code-state.md` is intake-only per the Write-Authority Matrix. Process cannot edit it directly. This proposal surfaces the miss so the next intake run (or Logan) updates the label.
**Logan action:** Option A: let tomorrow's intake catch it (add an explicit instruction to scout-additions.md if it keeps being missed).

### confirm-onedrive-mirror-retired
**File:** archive/proposals/confirm-onedrive-mirror-retired.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=M (not HIGH) → PROPOSE
**Logan action:** review + approve/reject

### context-mode-mcp-plugin
**File:** archive/proposals/context-mode-mcp-plugin.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### cowork-ga-desktop
**File:** archive/proposals/cowork-ga-desktop.md
**Summary:** Claude Cowork is now GA on macOS + Windows in Claude Desktop. Adds expanded analytics, OpenTelemetry support, and RBAC for Enterprise. Does NOT resolve the 1M → 200K Cowork regression tracked in 04-17 findings. Source: https://claude.com/
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### env-var-trio-effort-teams-thinking
**File:** archive/proposals/env-var-trio-effort-teams-thinking.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### exclude-dynamic-prompt-sections-flag
**File:** archive/proposals/exclude-dynamic-prompt-sections-flag.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### frontend-design-skill-official
**File:** archive/proposals/frontend-design-skill-official.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### graduate-crlf-gitattributes
**File:** archive/proposals/graduate-crlf-gitattributes.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=M → PROPOSE; also graduation (non-trivial routing)
**Logan action:** review + approve/reject

### growthbook-tengu-feature-gates
**File:** archive/proposals/growthbook-tengu-feature-gates.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### hook-session-title-output
**File:** archive/proposals/hook-session-title-output.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### implement-handoff-directive
**File:** archive/proposals/implement-handoff-directive.md
**Summary:** (see file)
**Why proposal:** ## The Problem
**Logan action:** review + approve/reject

### mcp-allowlist-env-security-hardening
**File:** archive/proposals/mcp-allowlist-env-security-hardening.md
**Summary:** (see file)
**Why proposal:** ## Why Proposed (not queued)
**Logan action:** review + approve/reject

### mcp-circuit-breaker-pattern
**File:** archive/proposals/mcp-circuit-breaker-pattern.md
**Summary:** Wrap MCP tool invocations in retry-with-jitter + circuit breaker. Config: 50% failure rate over 10s sliding window opens the breaker; 30s cooldown → half-open test. Exponential backoff with full jitter, 3-5 retries max.
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-gateway-pattern
**File:** archive/proposals/mcp-gateway-pattern.md
**Summary:** Production enterprise pattern: insert a lightweight proxy between Claude Code and MCP servers that enforces per-identity tool visibility, auth, rate limits, and structured logging. Buildable in ~200 LOC.
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-stateless-redis-sessions
**File:** archive/proposals/mcp-stateless-redis-sessions.md
**Summary:** Production MCP servers should be stateless with session state in Redis, 10-20 connections per instance, deployed behind NGINX `ip_hash` or ALB sticky sessions. Solves the "MCP server crashes lose all session state" problem and enables horiz
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### multi-property-design-tokens
**File:** archive/proposals/multi-property-design-tokens.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=M → PROPOSE
**Logan action:** review + approve/reject

### perplexity-comet-grok-deep-search
**File:** archive/proposals/perplexity-comet-grok-deep-search.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### perplexity-session-memory-pages
**File:** archive/proposals/perplexity-session-memory-pages.md
**Summary:** Perplexity added (a) cross-session memory (remembers prior research context) and (b) Pages (shareable, citation-rich published research documents). Both on Pro/Max tiers. Makes Perplexity more viable for multi-session research projects.
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### plan-v2-agent-count
**File:** archive/proposals/plan-v2-agent-count.md
**Summary:** (see file)
**Why proposal:** ## What It Does
**Logan action:** review + approve/reject

### plugin-hooks-yaml-fix
**File:** archive/proposals/plugin-hooks-yaml-fix.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### precompact-hook-blocking
**File:** archive/proposals/precompact-hook-blocking.md
**Summary:** (see file)
**Why proposal:** ## What It Does
**Logan action:** review + approve/reject

### preflight-hook-refactor-to-direct-mcp
**File:** archive/proposals/preflight-hook-refactor-to-direct-mcp.md
**Summary:** Claude Code 2.1.118 lets hooks invoke MCP tools directly, removing the shell-out intermediary. Claudious's SessionStart preflight currently shells out to `scripts/update-heartbeat.sh` (or `.ps1`). A direct-MCP path would collapse that to an
**Why proposal:** Touches production hook infrastructure across 3 tracked repos (Claudious, asf-graphics-app, courtside-pro). Requires:
**Logan action:** 1. Decide whether to invest in this refactor or leave the bash/ps1 wrapper as-is (it works and is fail-open).

### process-claudeignore-antipatterns
**File:** archive/proposals/process-claudeignore-antipatterns.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=L; requires manual action (scope exclusion in queue processor)
**Logan action:** review + approve/reject

### process-open-decisions-regen-not-landing-on-main
**File:** archive/proposals/process-open-decisions-regen-not-landing-on-main.md
**Summary:** Between 2026-04-17 seed commit (`cc3fc9d`) and 2026-04-23:
**Why proposal:** Routing reason:** Changes routine behavior around branch/PR handling; not a SAFE+HIGH+TRIVIAL md-only change → PROPOSAL
**Logan action:** review + approve/reject

### reconcile-mcp-count-inconsistency
**File:** archive/proposals/reconcile-mcp-count-inconsistency.md
**Summary:** (see file)
**Why proposal:** Routing reason:** Needs Logan to confirm the authoritative number via `/mcp` on both machines → PROPOSAL
**Logan action:** review + approve/reject

### refresh-current-setup-v5
**File:** archive/proposals/refresh-current-setup-v5.md
**Summary:** (see file)
**Why proposal:** Routing reason:** EFFORT=M + requires cross-machine manual verification → PROPOSAL (not queue)
**Logan action:** review + approve/reject

### skill-claudemd-optimizer
**File:** archive/proposals/skill-claudemd-optimizer.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### skill-description-1536-chars-audit
**File:** archive/proposals/skill-description-1536-chars-audit.md
**Summary:** (see file)
**Why proposal:** ## What It Does
**Logan action:** review + approve/reject

### skill-knowledge-sync-setup
**File:** archive/proposals/skill-knowledge-sync-setup.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### skill-skill-triggering-guide
**File:** archive/proposals/skill-skill-triggering-guide.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### subagent-invocation-quality-framework
**File:** archive/proposals/subagent-invocation-quality-framework.md
**Summary:** (see file)
**Why proposal:** ## What It Does
**Logan action:** review + approve/reject

### superpowers-trial-log
**File:** archive/proposals/superpowers-trial-log.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### user-preferences-adaptive-thinking-bypass
**File:** archive/proposals/user-preferences-adaptive-thinking-bypass.md
**Summary:** Anthropic shipped an adaptive thinking throttle in early April 2026 that reduces reasoning depth on tasks the model classifies as routine. The Claude Code fix is the env var `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1`. That env var does not a
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### v2-1-x-command-awareness
**File:** archive/proposals/v2-1-x-command-awareness.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### vite-vs-esbuild-decision-framework
**File:** archive/proposals/vite-vs-esbuild-decision-framework.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=M; domain-specific decision → PROPOSE for Logan to validate scope
**Logan action:** review + approve/reject

### zoom-mcp-connector-toolchain-note
**File:** archive/proposals/zoom-mcp-connector-toolchain-note.md
**Summary:** Zoom + Anthropic released a Zoom MCP connector. Claude Cowork/Code can query Zoom meeting insights, summaries, and action items. Logan is not currently a heavy Zoom user in Claudious-tracked workflows, but courtside-pro / asf engagements oc
**Why proposal:** - Target file would be `canonical/toolchain.md`, which is manual-only per the Write-Authority Matrix (process cannot append).
**Logan action:** Decide whether to add a `Zoom MCP` row under toolchain.md's "connectors not yet enabled" list:

