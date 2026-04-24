# Open Decisions — Proposals Awaiting Logan

**Last updated:** 2026-04-23
**Total open:** 40

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

### clarify-rollback-script-windows
**File:** archive/proposals/clarify-rollback-script-windows.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=L → PROPOSE
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
**Summary:** Claude Cowork is now GA on macOS + Windows in Claude Desktop. Adds expanded analytics, OpenTelemetry support, and RBAC for Enterprise. Does NOT resolve the 1M → 200K Cowork regression tracked in 04-
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
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-allowlist-env-security-hardening
**File:** archive/proposals/mcp-allowlist-env-security-hardening.md
**Summary:** Current setup inherits the full parent-process environment into every MCP server. Logan runs 5+ MCP servers (Playwright, TranscriptAPI, GitHub + Supabase/Stripe/Netlify from Claude.ai). Any secret in 
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-circuit-breaker-pattern
**File:** archive/proposals/mcp-circuit-breaker-pattern.md
**Summary:** Wrap MCP tool invocations in retry-with-jitter + circuit breaker. Config: 50% failure rate over 10s sliding window opens the breaker; 30s cooldown → half-open test. Exponential backoff with full jit
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-gateway-pattern
**File:** archive/proposals/mcp-gateway-pattern.md
**Summary:** Production enterprise pattern: insert a lightweight proxy between Claude Code and MCP servers that enforces per-identity tool visibility, auth, rate limits, and structured logging. Buildable in ~200 L
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### mcp-stateless-redis-sessions
**File:** archive/proposals/mcp-stateless-redis-sessions.md
**Summary:** Production MCP servers should be stateless with session state in Redis, 10-20 connections per instance, deployed behind NGINX `ip_hash` or ALB sticky sessions. Solves the "MCP server crashes lose all 
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
**Summary:** Perplexity added (a) cross-session memory (remembers prior research context) and (b) Pages (shareable, citation-rich published research documents). Both on Pro/Max tiers. Makes Perplexity more viable 
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### plan-v2-agent-count
**File:** archive/proposals/plan-v2-agent-count.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### plugin-hooks-yaml-fix
**File:** archive/proposals/plugin-hooks-yaml-fix.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### precompact-hook-blocking
**File:** archive/proposals/precompact-hook-blocking.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### process-claudeignore-antipatterns
**File:** archive/proposals/process-claudeignore-antipatterns.md
**Summary:** (see file)
**Why proposal:** Routing reason:** IMPACT=L; requires manual action (scope exclusion in queue processor)
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
**Why proposal:** (see file)
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
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### superpowers-trial-log
**File:** archive/proposals/superpowers-trial-log.md
**Summary:** (see file)
**Why proposal:** (see file)
**Logan action:** review + approve/reject

### user-preferences-adaptive-thinking-bypass
**File:** archive/proposals/user-preferences-adaptive-thinking-bypass.md
**Summary:** Anthropic shipped an adaptive thinking throttle in early April 2026 that reduces reasoning depth on tasks the model classifies as routine. The Claude Code fix is the env var `CLAUDE_CODE_DISABLE_ADAPT
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

