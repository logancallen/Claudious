# Claudious Drift Report — 2026-04-22

**Run:** Drift Detector (automated, scheduled task)
**Scope:** Internal consistency within the Claudious repo. Cross-repo drift (asf-graphics-app, courtside-pro) out of scope — flagged below as MANUAL CHECK NEEDED.
**Previous report:** none (first run under new report filename). All findings below are NEW.

---

## Summary

| Severity | Count |
|---|---|
| CRITICAL | 1 |
| HIGH | 6 |
| MEDIUM | 5 |
| MANUAL CHECK NEEDED | 1 |

Headline: `mastery-lab/logan-current-setup-v4.md` has diverged hard from canonical since its last update on 2026-04-14. It still advertises Claude Code v2.1.104 on Opus 4.6, 4 active Claude.ai MCP integrations, and 7 Claude.ai skills — all contradicted by `canonical/`. Fixing v4 (or retiring it) is the single highest-leverage drift cleanup in this run.

---

## CRITICAL

### CRIT-1 — alerts.md carries unresolved ASF migrations 026-028 breakage (>7 days, no resolution path inside Claudious)
- **File:** `alerts.md` line 10
- **Entry:** `2026-04-14 CRITICAL ASF-GRAPHICS Migrations 026-028 broke employee permissions. Root cause unidentified. Do NOT run new migrations until resolved. Dedicated audit session required.`
- **Why critical:** Alert has sat for 8 days. It blocks all new ASF migrations per its own instruction. Root cause requires asf-graphics-app repo access that this task cannot reach.
- **Drift angle:** `mastery-lab/logan-current-setup-v4.md` Gap #1 mirrors the same CRITICAL unresolved state from April 12, so the two sources agree — but neither has moved. Documentation is consistent; execution is stalled.
- **Action:** MANUAL CHECK NEEDED — see section at bottom. Appending to alerts.md per routine instructions.

---

## HIGH

### H-1 — `mastery-lab/logan-current-setup-v4.md` is stale on Claude Code version and default model
- **File:** `mastery-lab/logan-current-setup-v4.md` lines 13-16
- **Claims:** "Claude Code: v2.1.104, Opus 4.6, 1M context" and "Models available: Opus 4.6, Sonnet 4.6, Haiku 4.5"
- **Canonical says:** `canonical/claude-code-state.md` — v2.1.113, default Opus 4.7. `canonical/claude-state.md` — Opus 4.7 is flagship; Opus 4.6 retained only for cloud Ultraplan.
- **Gap:** 9 point releases behind (2.1.105 → 2.1.113 of visible features missing from v4). No mention of Opus 4.7 at all in v4.
- **Fix:** Rewrite the "Subscription & Access" block in v4 OR mark the file superseded by `canonical/logan-current-stack.md` and point to it.

### H-2 — `mastery-lab/logan-current-setup-v4.md` contradicts canonical on Claude.ai MCP integrations
- **File:** `mastery-lab/logan-current-setup-v4.md` "MCP Integrations" table (lines ~124-142)
- **Claims:** 4 active Claude.ai MCPs (Google Drive, Supabase, Stripe, Netlify); 6 disconnected April 12 (Gmail, Canva, Jotform, Linear, Figma, Clarify).
- **Canonical says:** `canonical/toolchain.md` lists 12 active: Google Drive, Gmail, Supabase, Stripe, Netlify, Figma, Linear, Canva, QuickBooks, Context7, Cloudflare, Hugging Face. `canonical/logan-current-stack.md` agrees (12 MCP Integrations Connected).
- **Severity rationale:** HIGH because Pioneer / Grok scan references v4 to filter "already deployed" from "new" — if v4 says Gmail/Linear/Figma/Canva are disconnected, scans will keep proposing them.
- **Fix:** Update v4's MCP table to match canonical, or delete the table and link to `canonical/toolchain.md`.

### H-3 — `mastery-lab/logan-current-setup-v4.md` lists wrong skill set vs canonical
- **File:** `mastery-lab/logan-current-setup-v4.md` "Custom Skills" block (lines ~54-83)
- **Claims:** 7 Claude.ai Skills: operating-system, logan-os, financial-modeler, legal-scanner, asf-ux-design, ux-reviewer, harvest.
- **Canonical says:** `canonical/logan-current-stack.md` and `canonical/toolchain.md` agree on 8: logan-os, operating-system, financial-modeler, legal-scanner, negotiation-playbook, health-optimizer, macro-intelligence, harvest.
- **Delta:** v4 missing negotiation-playbook, health-optimizer, macro-intelligence. v4 has asf-ux-design and ux-reviewer that canonical does not list (possibly retired; possibly still on disk but not tracked).
- **Fix:** Decide whether asf-ux-design / ux-reviewer are still live. If retired, strike from v4. If live, add to `canonical/logan-current-stack.md`. Either way, reconcile to a single list.

### H-4 — `skills/index.md` drifts from canonical and from `mastery-lab/logan-current-setup-v4.md`
- **File:** `skills/index.md`
- **What's there:** 4 global skills (harvest, pioneer, project-router, caveman), 3 ASF skills (deploy-checklist, schema-migration, component-build), 3 Courtside Pro skills (deploy, schema-migration, knowledge-sync).
- **Drift vs v4:** v4 claims ASF has 4 project skills (adds `parallel-build.md`) and Courtside Pro has 2 including `deploy.md` — neither rendered identically to skills/index.md. v4 also lists 3 health/macro/negotiation skills as Claude Code Global skills; skills/index.md does not.
- **Drift vs canonical:** canonical/toolchain.md lists 8 Custom Claude.ai skills. skills/index.md does not include any of them (reasonable if it only tracks Claude Code scope, but that boundary is not stated in the file).
- **Fix:** (a) add a scope banner to `skills/index.md` clarifying "Claude Code skills only — for Claude.ai custom skills see `canonical/toolchain.md`", and (b) reconcile the ASF/Courtside project-skill lists with the actual `.claude/skills/` contents of those repos (MANUAL CHECK NEEDED — out of scope for this run).

### H-5 — Environment variable list drifts between canonical and v4
- **File A:** `canonical/claude-code-state.md` — 5 env vars: CLAUDE_CODE_SUBAGENT_MODEL, CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING, MCP_SERVER_CONNECTION_BATCH_SIZE, MCP_CONNECTION_NONBLOCKING, ENABLE_PROMPT_CACHING_1H.
- **File B:** `mastery-lab/logan-current-setup-v4.md` — 10 env vars, including CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1, CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000, CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true, CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1, CLAUDE_CODE_PLAN_V2_AGENT_COUNT=3.
- **Impact:** Either canonical is under-documenting 5 live env vars, or v4 is carrying zombies. Both states are bad: canonical-as-source-of-truth breaks if it's not authoritative.
- **Fix:** Dump the actual PC `$PROFILE` and reconcile. Update `canonical/claude-code-state.md` to list every set env var, and delete the obsolete rows from v4 (or mark v4 as archived).

### H-6 — alerts.md contains a resolved alert (bash permission bypass) that should have been cleared
- **File:** `alerts.md` line 6
- **Entry:** `2026-04-13 HIGH SCOUT Bash tool permission bypass patched in v2.1.98 — backslash-escaped flags could bypass safety checks. Update immediately if below v2.1.98.`
- **Why resolved:** `canonical/claude-code-state.md` states Logan is on v2.1.113 as of 2026-04-17. The matching proposal `bash-permission-bypass-patch.md` self-notes "may be auto-resolvable" and `canonical/claude-code-state.md` already lists the patch under "Features Shipped".
- **Fix:** Delete line 6 from alerts.md. Delete `archive/proposals/bash-permission-bypass-patch.md` or mark it resolved. Remove the matching entry from `canonical/open-decisions.md`.

---

## MEDIUM

### M-1 — AutoDream status contradicts itself across files
- **File A:** `learnings/platforms/claude.md` line 8 — "AutoDream: server-side rollout, not yet on all accounts — check /memory for toggle."
- **File B:** `mastery-lab/logan-current-setup-v4.md` line 17 + line 95 — "AutoDream: ✅ LIVE — Auto-memory: on, confirmed April 12, 2026".
- **File C:** `archive/proposals/audit-autodream-status.md` — flags the contradiction and asks Logan to confirm.
- **Fix:** Logan to verify AutoDream status in Claude.ai account once, then update both files to the confirmed answer. Proposal already exists; this is a knock-on to it resolving.

### M-2 — `learnings/platforms/claude.md` has stale Claude Max pricing
- **File:** `learnings/platforms/claude.md` line 8
- **Stale claim:** "Claude Max ($100/month)"
- **Canonical:** $200/month (`canonical/claude-state.md` "Logan's Plan" section).
- **Fix:** Edit the one-liner. Also strip "Opus 4.6" from the same sentence — the entry reads as if 4.6 is the only Opus tier on Max, which is no longer accurate post-4.7 GA.

### M-3 — `canonical/open-decisions.md` claims 28 active proposals but `archive/proposals/` has 37 files
- **Delta:** 9 files on disk that aren't represented in open-decisions.md.
- **Possibilities:** (a) Process routine hasn't regenerated open-decisions.md recently; (b) 9 proposal files are stale / already resolved / duplicates of queue items; (c) header count is stale copy.
- **Fix:** Run the process routine once so `open-decisions.md` regenerates against current `archive/proposals/` contents, OR audit `archive/proposals/` and prune stubs that no longer apply.

### M-4 — v4 "Known Gaps" table is stale vs deployed.log
- **File:** `mastery-lab/logan-current-setup-v4.md` lines 214-227
- **Examples:**
  - Gap #5 "Claudious not connected as knowledge source to remaining 5 projects — Pending". Deployed.log and CLAUDE.md's "every canonical edit propagates to all 8 Claude Projects on next sync" wording both suggest this is no longer pending.
  - Gap #7 "Mac Studio env vars not set — Pending — do when at office". No verification in this audit; may still be true.
- **Fix:** Re-audit the gap list next time Logan is in front of the PC; move resolved items to `mastery-lab/implementation-log-v4.md`.

### M-5 — `archive/queue/` contains only `deployed.log`; no active queue items present
- **Observation:** Not necessarily drift — it's valid for the queue to be empty after a successful process run. Flagged as MEDIUM because the queue is the auto-deploy surface and an empty queue for multiple runs suggests either (a) process routine is silently failing to populate, or (b) intake is not producing SAFE+HIGH+TRIVIAL items.
- **Fix:** Check the last 3 intake runs (`archive/intake/`) for any findings tagged SAFE+HIGH+TRIVIAL that should have been queued but weren't.

---

## MANUAL CHECK NEEDED

- **ASF Graphics migration drift** — alert CRIT-1 above requires reading from `asf-graphics-app` repo. This scheduled task is scoped to Claudious only. Logan should run a full drift audit via Claude Code against `asf-graphics-app` to investigate migrations 026-028 and either resolve or confirm the blocker is still live.
- **Project-skill reconciliation** — `skills/index.md` lists ASF and Courtside Pro project skills that need cross-checked against each repo's `.claude/skills/` directory. Out of scope for this task.

---

## Recommended cleanup order (next Claude Code session)

1. Clear alerts.md line 6 (H-6 — resolved bash bypass alert) — 30s edit.
2. Edit `learnings/platforms/claude.md` line 8 ($100 → $200, add Opus 4.7) — 1 min edit (M-2).
3. Either rewrite `mastery-lab/logan-current-setup-v4.md` against canonical (H-1/H-2/H-3/H-5), or mark it archived and redirect readers to `canonical/logan-current-stack.md`. One-hour effort at most; unblocks Pioneer/Grok-scan reliability.
4. Run process routine to regenerate `canonical/open-decisions.md` (M-3).
5. Re-check ASF migrations 026-028 (CRIT-1) in a dedicated Claude Code session on `asf-graphics-app`.
