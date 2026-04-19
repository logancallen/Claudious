# Active Findings — Last 7 Days

**Last updated:** 2026-04-19
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

## Graduation Rules

- Finding referenced 3+ times across `learnings/*.md` or confirmed by Logan → promote to `prompting-rules.md` or `antipatterns.md`.
- Finding >7 days old with no graduation path → archive to `archive/intake/`.
- Finding superseded by a newer finding → mark `superseded` and remove on next refresh.
