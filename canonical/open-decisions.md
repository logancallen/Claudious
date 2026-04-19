# Open Decisions — Proposals Awaiting Logan

**Last updated:** 2026-04-19
**Scope:** Every proposal in `proposals/` that needs Logan's judgment (can't auto-deploy as SAFE+HIGH+TRIVIAL).
**Refresh:** Maintained by the `process` routine — proposals added on triage, removed on approve/reject/prune.

---

## Format per decision

```
### <kebab-id>
**Summary:** <1 sentence>
**Why a proposal:** <what makes it non-auto-deployable>
**Logan action needed:** <specific decision or step>
```

---

## Active — 28 proposals

### agent-skills-spec-cross-platform
**Summary:** Adopt Agent Skills Spec (codified Skills metadata) across Codex CLI + ChatGPT alongside Claude Code.
**Why a proposal:** Requires cross-platform changes and judgment on portability vs Claude-native fidelity.
**Logan action needed:** Decide whether to port 8+ custom skills to the spec. Review benefit vs lock-in.

### background-monitor-plugin-manifest
**Summary:** Add `background-monitor` manifest key to relevant plugins to surface long-running processes via Monitor tool.
**Why a proposal:** Plugin-by-plugin manifest edits; benefit depends on which plugins Logan runs long tasks with.
**Logan action needed:** Pick which plugins (typescript-lsp, pyright-lsp, Codex?) get the manifest key.

### bash-permission-bypass-patch
**Summary:** Update Claude Code to v2.1.98+ to close the backslash-escaped-flag bypass.
**Why a proposal:** Security update — verify current version first, then confirm upgrade.
**Logan action needed:** Check `claude --version`; update if <2.1.98. (Likely already done: running 2.1.113 per `canonical/claude-code-state.md` — this may be auto-resolvable.)

### compile-time-feature-flags-radar
**Summary:** Monitor Anthropic's GrowthBook / tengu_* runtime flags for roadmap signal — Anthropic can remote-kill features (Agent Teams, Fast Mode) without user notice.
**Why a proposal:** Requires building a monitoring script + weekly review cadence.
**Logan action needed:** Decide whether to build the radar, or rely on community Discord signal.

### context-mode-mcp-plugin
**Summary:** Install `context-mode` MCP plugin (github.com/mksglu/context-mode) — claimed 50–90% token reduction for MCP-heavy sessions.
**Why a proposal:** Third-party plugin; requires testing vs Logan's 12-MCP setup before rollout.
**Logan action needed:** 1-session test. High priority given 12 connected servers.

### env-var-trio-effort-teams-thinking
**Summary:** Set `CLAUDE_CODE_EFFORT_LEVEL`, `CLAUDE_CODE_MAX_THINKING_TOKENS`, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` as a coordinated trio.
**Why a proposal:** Interaction effects between the three; values depend on Logan's preferred defaults.
**Logan action needed:** Pick values per env var; add to PowerShell `$PROFILE`.

### exclude-dynamic-prompt-sections-flag
**Summary:** Add `--exclude-dynamic-system-prompt-sections` flag to print-mode / CI invocations for reproducibility.
**Why a proposal:** Changes CI output surface; needs validation CI doesn't rely on excluded sections.
**Logan action needed:** Verify no CI workflows read excluded sections; add flag to relevant scripts.

### frontend-design-skill-official
**Summary:** Install Anthropic's official Frontend-Design skill (277K+ installs).
**Why a proposal:** Requires manual `claude skills add` in CLI; may conflict with existing skills.
**Logan action needed:** Install and audit trigger overlap with current design skills.

### growthbook-tengu-feature-gates
**Summary:** Treat GrowthBook runtime gates (tengu_*) as remote kill-switch awareness — add "check remote gate status" as step 0 in feature-break triage.
**Why a proposal:** Behavioral change to triage process; needs integration into MCP-break / feature-break runbooks.
**Logan action needed:** Approve rule; integrate into relevant skills.

### hook-session-title-output
**Summary:** `UserPromptSubmit` hook can emit `hookSpecificOutput.sessionTitle` to rename the Claude Code tab.
**Why a proposal:** Requires hook code + testing; benefit is convenience only.
**Logan action needed:** Low priority — approve/defer.

### implement-handoff-directive
**Summary:** Implement `SessionEnd` / `SessionStart` handoff directive in global CLAUDE.md — auto-write `.claude/handoff.md` at session end, auto-read at start.
**Why a proposal:** Already partially in `~/.claude/CLAUDE.md` Session Lifecycle section. This formalizes as a hook rather than instruction.
**Logan action needed:** Decide: hook-enforced vs instruction-based. Both exist now.

### mcp-allowlist-env-security-hardening
**Summary:** Set `CLAUDE_CODE_MCP_ALLOWLIST_ENV` to restrict env inheritance to MCP servers.
**Why a proposal:** Security hardening given 12 active MCP servers. Requires curating the allowlist.
**Logan action needed:** Define the allowlist; set env var.

### mcp-circuit-breaker-pattern
**Summary:** Add circuit breaker (50%/30s) to MCP calls to prevent cascade failures when one server misbehaves.
**Why a proposal:** Requires implementation at MCP client layer; upstream feature request.
**Logan action needed:** Defer until Anthropic-side support or user-level library emerges.

### mcp-gateway-pattern
**Summary:** Run MCP behind a gateway for tool visibility + auth enforcement.
**Why a proposal:** Infrastructure addition; benefit at team scale, marginal solo.
**Logan action needed:** Defer — not worth complexity for 1 user.

### mcp-stateless-redis-sessions
**Summary:** Stateless MCP session design backed by Redis for horizontal scale.
**Why a proposal:** Relevant only for team / multi-device MCP scenarios.
**Logan action needed:** Defer — not needed for current setup.

### perplexity-comet-grok-deep-search
**Summary:** Add Perplexity Comet Browser + Grok Deep Search to research routing.
**Why a proposal:** Updates task-routing-table.md; requires testing actual quality.
**Logan action needed:** Run 2–3 test queries on each; decide on routing.

### perplexity-session-memory-pages
**Summary:** Use Perplexity Session Memory + Pages for cross-platform research persistence.
**Why a proposal:** Changes research workflow; needs habit shift.
**Logan action needed:** Evaluate after 1 week of use.

### plan-v2-agent-count
**Summary:** Tune `CLAUDE_CODE_PLAN_V2_AGENT_COUNT` env var to control plan mode parallelism.
**Why a proposal:** Value depends on Logan's typical plan complexity; defaults may suffice.
**Logan action needed:** Test values 2 / 4 / 6 on 3 plans; pick best.

### plugin-hooks-yaml-fix
**Summary:** Plugin hooks YAML frontmatter bug fix (requires manual `claude update`).
**Why a proposal:** Already moved to proposals 2026-04-12 as MOVED-TO-PROPOSALS (manual CLI action).
**Logan action needed:** Run `claude update` in next CLI session.

### precompact-hook-blocking
**Summary:** PreCompact hook can block compaction (v2.1.105+). Use to preserve critical context before compact.
**Why a proposal:** Requires hook implementation + criteria for when to block.
**Logan action needed:** Write the hook or skip — depends on whether manual compact protocol suffices.

### skill-claudemd-optimizer
**Summary:** New skill `claudemd-optimizer` — runs Arize prompt-learning loop on CLAUDE.md files.
**Why a proposal:** Graduation from technique to skill; needs skill file authored.
**Logan action needed:** Approve skill creation or defer.

### skill-description-1536-chars-audit
**Summary:** Expand all 15+ custom skill descriptions to use the new 1,536-char limit (was 250).
**Why a proposal:** Requires per-skill rewrite. HIGH priority per alerts.md 2026-04-13.
**Logan action needed:** Audit + rewrite session (~45 min).

### skill-knowledge-sync-setup
**Summary:** New skill `knowledge-sync-setup` — wire docs/ knowledge-sync pattern in a new repo.
**Why a proposal:** Graduation candidate; needs skill authored.
**Logan action needed:** Approve skill creation.

### skill-skill-triggering-guide
**Summary:** New skill `skill-triggering-guide` — authoring guide for future skills (description patterns, exclusion phrases, semantic matching rules).
**Why a proposal:** Meta-skill; affects skill authoring going forward.
**Logan action needed:** Approve skill creation.

### subagent-invocation-quality-framework
**Summary:** 4 required components for quality subagent invocation (context, task, format, cap).
**Why a proposal:** Behavioral framework; graduates to prompting-rules.md once validated across 3+ uses.
**Logan action needed:** Approve and promote to `canonical/prompting-rules.md` after next use.

### user-preferences-adaptive-thinking-bypass
**Summary:** Add `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1` guidance to User Preferences.
**Why a proposal:** Affects User Preferences (restricted surface per process.md scope).
**Logan action needed:** Paste into User Preferences in Settings > Profile.

### v2-1-x-command-awareness
**Summary:** Awareness pack for v2.1.x slash commands (`/ultraplan`, `/less-permission-prompts`, `/ultrareview`, `/autofix-pr`, `/team-onboarding`).
**Why a proposal:** Cross-surface awareness doc; needs placement decision.
**Logan action needed:** Already covered in `canonical/claude-code-state.md`; this proposal is now redundant.

---

## Summary

- **Total active:** 28 (seeded from `proposals/*.md` as of 2026-04-19).
- **Security-critical:** `bash-permission-bypass-patch` (likely resolved by version upgrade), `mcp-allowlist-env-security-hardening`.
- **High-leverage quick wins:** `skill-description-1536-chars-audit`, `context-mode-mcp-plugin`, `user-preferences-adaptive-thinking-bypass`.
- **Candidates to defer / close:** `mcp-circuit-breaker-pattern`, `mcp-gateway-pattern`, `mcp-stateless-redis-sessions`, `v2-1-x-command-awareness` (redundant).
