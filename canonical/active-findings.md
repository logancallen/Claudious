# Active Findings

**Last updated:** 2026-05-09

Append-only log of Scout / Drift / Config findings produced by intake. Entries default `Action: queued` — process triages from there. Curate is the only role that may delete from this file.

Action values: `queued` | `proposed` | `graduated` | `archived`.

---

### [2026-05-09] cc-version-2-1-138-current
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** Claude Code latest version is 2.1.138 (May 9, 2026). canonical/state.md L75 still pins 2.1.118 (Apr 23). Intervening releases: 2.1.129, 2.1.131–2.1.133, 2.1.136–2.1.138.
**Action:** queued

### [2026-05-09] cc-plugin-url-flag
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** v2.1.129 added `--plugin-url` flag to fetch plugins from URLs and `CLAUDE_CODE_PACKAGE_MANAGER_AUTO_UPDATE` env var for auto-updating installations.
**Action:** queued

### [2026-05-09] cc-session-id-env-var
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** v2.1.132 added a session-ID env var and an alternate-screen-renderer toggle.
**Action:** queued

### [2026-05-09] cc-worktree-baseref-sandbox-paths
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** v2.1.133 added worktree base-ref settings and sandbox path configuration.
**Action:** queued

### [2026-05-09] cc-2-1-136-automode-hard-deny
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** v2.1.136 (May 8) introduced `settings.autoMode.hard_deny` (unconditional auto-mode block), `CLAUDE_CODE_ENABLE_FEEDBACK_SURVEY_FOR_OTEL`, MCP server handling improvements after `/clear`, WSL2 image-paste PowerShell fallback. Fixed MCP OAuth refresh-token loss with concurrent servers, plan-mode file-write blocking with Edit allow rules, extended-thinking redacted-block API errors.
**Action:** queued

### [2026-05-09] cc-may-4-multi-feature-batch
**Source:** https://code.claude.com/docs/en/changelog
**Credibility:** OFFICIAL
**Type:** CC-STATE
**Summary:** May 4 batch — bare `/color` command, `/mcp` shows tool count for connected servers, `--plugin-dir` accepts `.zip` plugin archives, improved model picker, PostToolUse hooks can replace tool output for all tools, scrollable dialogs, `claude project purge` command, `/model` lists models from gateway endpoints.
**Action:** queued

### [2026-05-09] aws-mcp-server-ga
**Source:** https://aws.amazon.com/blogs/aws/the-aws-mcp-server-is-now-generally-available/
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** AWS MCP Server reached general availability May 6, 2026. Single-tool access to any AWS API, sandboxed Python execution, IAM context-key support, no charge for the server itself. Logan's stack is Cloudflare-centric — relevant if cross-cloud work appears.
**Action:** queued

### [2026-05-09] moodys-mcp
**Source:** https://aimaker.substack.com/p/anthropic-claude-updates-q1-2026-guide
**Credibility:** VERIFIED
**Type:** TOOL
**Summary:** Moody's launched an MCP app exposing proprietary credit ratings and 600M+ company records for compliance, credit analysis, and business development. Outside Logan's current domains.
**Action:** queued

### [2026-05-09] claude-code-limits-doubled-spacex-deal
**Source:** https://www.anthropic.com/news/higher-limits-spacex (cited via PCWorld + MakeUseOf — direct fetch returned 403 from this environment)
**Credibility:** VERIFIED
**Type:** NEWS
**Summary:** Anthropic doubled Claude Code 5-hour rate limits across Pro / Max / Team / seat-based Enterprise plans, citing a SpaceX Colossus 1 GPU compute partnership. CONFLICT with canonical/state.md L29–34 — unclear whether the 15/day routines quota is also doubled. Hold for direct-source confirmation.
**Action:** queued

### [2026-05-09] peak-hour-throttling-removed
**Source:** aimaker.substack.com / makeuseof.com (secondary)
**Credibility:** ANECDOTAL
**Type:** BEHAVIOR
**Summary:** Reports that peak-hour throttling on Claude Code has been removed for Pro and Max accounts. CONFLICT with canonical/state.md L34. No direct anthropic.com confirmation captured this cycle — ANECDOTAL until a second OFFICIAL source is found.
**Action:** queued

### [2026-05-09] blackstone-hf-goldman-enterprise-jv
**Source:** anthropic.com/news (May 4, 2026 announcement)
**Credibility:** OFFICIAL
**Type:** NEWS
**Summary:** Anthropic announced an enterprise-AI-services partnership with Blackstone, Hellman & Friedman, and Goldman Sachs. No direct effect on Logan's stack — corporate-strategy news only.
**Action:** queued

### [2026-05-09] claude-finance-agent-templates
**Source:** aimaker.substack.com (Anthropic announcement aggregation)
**Credibility:** VERIFIED
**Type:** TOOL
**Summary:** Anthropic released ten ready-to-run finance agent templates (pitchbooks, KYC screening, month-end close) shipping as Claude Cowork plugins, Claude Code plugins, and Claude Managed Agents cookbooks. Pitchbook + month-end-close templates may apply to ASF Graphics + Courtside Pro work — review before adopting.
**Action:** queued

### [2026-05-09] claude-for-outlook-coming
**Source:** aimaker.substack.com / anthropic.com (secondary)
**Credibility:** OFFICIAL
**Type:** TOOL
**Summary:** Claude add-ins for Microsoft 365 — Excel, PowerPoint, Word live; Outlook coming soon, with cross-app context auto-carry. Outlook is the additive update vs canonical/state.md §3 (which already lists Excel + PowerPoint + Word).
**Action:** queued

### [2026-05-09] no-hardcoded-entities-in-routines
**Source:** 2026-04-19 Grok pipeline adaptability audit (re-seeded from intake spec)
**Credibility:** VERIFIED
**Type:** TECHNIQUE
**Summary:** Constitutional rule seed for canonical/playbook.md. Routine prompts, scans, and automated pipelines targeting people, products, URLs, versions, or organizational state must reference a canonical config file by URL — not inline the list. Exceptions: zero-rot-risk entities (protocol names, company names). Quarterly staleness audit. IMPACT: H | EFFORT: T | RISK: SAFE.
**Action:** queued

### [2026-05-09] verification-prompts-suppress-self-report
**Source:** 2026-04-19 handoff generation session (re-seeded from intake spec)
**Credibility:** VERIFIED
**Type:** TECHNIQUE
**Summary:** Constitutional rule seed for canonical/playbook.md. Prompts requesting verification outputs (commit SHAs, file contents, git status) must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block — otherwise self-report overrides requested output and forces re-run. IMPACT: H | EFFORT: T | RISK: SAFE.
**Action:** queued

### [2026-05-09] pipeline-structure-reconciliation
**Source:** archive/intake/2026-05-09.md §D.5
**Credibility:** OFFICIAL (internal repo state)
**Type:** BEHAVIOR
**Summary:** Task spec assumes a richer pipeline (active-findings, claude-state, claude-code-state, prompting-rules, antipatterns, scheduled-tasks/, learnings/, archive/scan-inbox/, archive/queue/, archive/proposals/) than the post-2026-04-26-v2-Reset repo provides. CLAUDE.md L29 prohibits scripts writing to canonical/. process and curate ledger entries on May 6–7 already attempted to run but failed DEPENDENCY_NOT_SATISFIED. Logan must decide: restore the prohibition and stop the pipeline, or update CLAUDE.md + canonical layout to match the spec. IMPACT: H | EFFORT: M | RISK: REVIEW-REQUIRED.
**Action:** queued
