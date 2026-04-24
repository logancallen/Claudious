# Handoff — 2026-04-23 PM (Nervous System Layers 1+2 Shipped, Process Regen Bug Surfaced)

**Recommended next-chat title:** `2026-04-24 — MASTERY — Process Regen Silent-Failure Investigation`

---

## Current focus

Investigate and fix the Process routine silent failure where daily Process runs mark `[COMPLETE]` in the ledger but their canonical regen output never lands on main. Evidence from Session #3 Part B: `canonical/open-decisions.md` last committed to main on 2026-04-17 (seed commit `cc3fc9d`) despite 6 daily Process runs since then. Fresh manual regen produced 40 proposals vs 28 stamped — 6 days of stale canonical state.

**Hypothesis (evidence-strong, unproven):** Process runs on a per-session `claude/<slug>` branch, opens a PR, PR never auto-merges, regen output dies on the branch. Secondary: the spec-required `open-decisions-regenerated=<yes|no>` field is entirely absent from Process ledger output, so self-audit was blind to the failure.

**Likely scope (unverified):** `canonical/active-findings.md`, `canonical/claude-state.md`, `canonical/claude-code-state.md` may have the same silent-failure pattern when written by Process (Intake writes to some of these directly on main via its own commit step — unclear if Intake is affected too).

---

## Completed this session

### Session #1 (2026-04-23 AM)
- **Layer 1 Heartbeat shipped.** Claudious PR #17 merged SHA `36f8f43`. `.claudious-heartbeat/lama.json` live on main. `scripts/update-heartbeat.sh` + `.ps1` functional on both platforms.
- **Implementer scope fix shipped.** `scheduled-tasks/process.md` now allows auto-deploy to `learnings/antipatterns.md`. `archive/proposals/expand-implementer-scope-to-antipatterns.md` moved to `archive/proposals-closed/` with 2026-04-23 resolution note.
- **Intake Phase 0.5 added.** Reads `.claudious-heartbeat/*.json`, emits STALE_MACHINE / REPO_BEHIND / STALE_WIP findings.
- **Curate briefing patched.** New Machines section.

### Session #3 (2026-04-23 PM)
- **Layer 2 Pre-Session Doctor shipped.** Claudious PR #18 merged. `scripts/update-heartbeat.sh --preflight` mode functional. `.claude/hooks/preflight.sh` + `.ps1` wrappers in Claudious. `.claude/settings.json` hook registered.
- **ASF PR #1 open.** awaiting Logan's manual merge (ASF constitution requires human SHIP approval). Zero code-path impact on production — pure hook wrapper addition.
- **Courtside preflight install SKIPPED.** Working tree dirty (4 modified files + untracked log) and 15 commits behind origin/main. Would immediately halt on preflight install. Pending WIP resolution session.
- **Open-decisions.md regen diagnostic — Case 2 confirmed.** Fresh regen committed (249 lines, 40 proposals) in PR #18. Routine-side fix filed as `archive/proposals/process-open-decisions-regen-not-landing-on-main.md`.
- **PS1 exit 255 resolved.** Root cause: broken-pipe artifact from `| Select-Object -First N` pipeline consumption + UTF-8-no-BOM emoji mis-decode on PowerShell 5.1 (same class as em-dash gotcha `66b021c`). Fix: `.ps1` switched to ASCII-only symbols. `.sh` keeps emoji. Logged to `learnings/gotchas.md`.

---

## In-flight

1. **ASF PR #1** — https://github.com/logancallen/asf-graphics-app/pull/1 — awaiting Logan's manual merge. Claude's recommendation: merge (HIGH confidence, zero production code-path impact).
2. **Hook E2E verification** — no action needed beyond opening a fresh CC session in Claudious tomorrow morning. Status line prints or it doesn't.
3. **Courtside-pro hook install** — pending WIP resolution. Needs dedicated courtside-only session after `git pull` + stash/commit cycle.

---

## Pending (queued, by priority)

### Session #4 — Process regen silent-failure investigation (HIGHEST PRIORITY)
Scope:
1. Confirm branch-PR hypothesis. Check last 7 Process ledger entries + GitHub PR history for `claude/process-*` branches. Count: created / opened as PR / merged to main. If zero merges, hypothesis proven.
2. Determine whether Intake has the same silent-failure pattern. Intake commits directly to main per its prompt (`git add -A && git commit && git push origin main` in Section 6). But the finding appends to `canonical/active-findings.md` may not be landing if there's a similar bug somewhere. Check: does `canonical/active-findings.md` on main receive daily appends, or do new findings only show up in the fresh regen?
3. Scope other canonical files Process writes to: `canonical/prompting-rules.md`, `canonical/antipatterns.md`, `canonical/open-decisions.md`. Check each's main-branch commit log for Process-authored commits.
4. Fix: either ensure Process auto-merges its own PR (if claude/* auto-merge workflow isn't catching it for some reason), OR restructure Process to commit directly to main like Intake does, OR add a Curate-side reconciliation pass.
5. Backfill: after fix, run one manual Process cycle to land 6 days of accumulated canonical drift.
6. Add `open-decisions-regenerated=yes|no` to the ledger output per spec.

### Session #5 — Courtside-pro hook install (LOW PRIORITY)
After Logan resolves courtside WIP. Dedicated courtside CC session, identical hook install pattern to asf. Manual PR merge (same constitution pattern as ASF).

### Mac Studio session follow-up
Verify hook E2E fires on Mac. Register `mac-studio` heartbeat. Zero manual steps — opening CC in any of the 3 repos on Mac handles it.

### Ongoing from prior handoffs
- **PC path migration** — `Projects/Claudious` → `Documents/GitHub/Claudious`. Deferred. Heartbeat fallback handles both paths gracefully, so not blocking.
- **Mac Studio canonical path verification** — confirm `~/Documents/GitHub/Claudious` is the active clone.
- **April 26, 2026 (3 days)** — Sora 2 shutdown confirm; no Logan workflows depend on it per 2026-04-23 AM handoff.
- **April 29, 2026** — Superpowers trial Day-7 verdict. EXTEND / SELECTIVE / ROLLBACK decision. Trial log at `archive/proposals/superpowers-trial-log.md`.
- **May 7, 2026** — GPT-5.5 benchmark re-verify (Artificial Analysis, SWE-bench, Simon Willison).
- **~2026-05-22** — `clear-git-locks.ps1` 30-day soak complete; evaluate wiring as CC pre-flight hook.
- **Claudious OAuth crackdown impact check** — investigate whether routines are affected by Anthropic OAuth policy change.
- **`sync-knowledge.sh` missing-dir defensive skip patch** — DIRS list references top-level directories that moved under `archive/`.

---

## Unresolved questions

1. Does Process actually create PRs for its canonical regens, or does it commit+push to a branch and stop? Ledger shows `git add -A && git commit && git push origin main` is the Process spec, but the claude/<slug> branch-note from 2026-04-20 ledger hints otherwise. Resolve by reading current scheduled-tasks/process.md Section 5 verbatim.
2. Is Intake's canonical/active-findings.md append-to-main working? Last commit SHA on that file + diff against fresh regen expected from heartbeat data would answer.
3. When Process's `claude/<slug>` PR opens, does auto-merge fire or not? Check GitHub PR history.
4. How many cumulative canonical updates have been lost over 6 days? If Process writes to multiple canonical files per run and none landed, this is a significant backfill.

---

## Frustration signals (do not repeat)

- **Manual cross-machine steps.** "I don't want to have to do this shit, I want automation not manual things like this to have to scrape back through chat history." Layer 2 hook resolved the Mac sync case; preserve this principle for all future design. No "run this command on the other machine" instructions.
- **Deviations that don't improve the project.** "I don't want deviations unless it improves our system." CC deviations must either fix a real problem (PC has no python3 → use node) or add a capability; cosmetic deviations are rejected.
- **Pasting long prompts inline in chat instead of generating downloadable md files.** From prior handoff. Session #1 and #3 both generated CC prompts as downloadable artifacts via outputs/ — continue this pattern.
- **Not using project_knowledge_search when available.** From prior handoff. This session used it 5x at init.

---

## Decisions made with reasoning

- **Layer 2 as hook not directive.** Hooks are deterministic; directives require Claude to remember. Logan's explicit ask was automation. Per-repo scope (.claude/settings.json in 3 repos only) prevents overhead in unrelated sessions.
- **Fail-open on infrastructure errors.** Preflight hook exits 0 when Claudious is unreachable, git fetch fails, or scripts missing. Only halts on actual drift data. CC stays reachable even when nervous system wobbles.
- **Heartbeat auto-commit to main.** Session-start commits create noise in git log. Accepted — metadata IS the signal. If it becomes a real problem, move to dedicated heartbeat branch with cron-pull.
- **Node.js over python3/jq for JSON parsing.** PC environmental reality: python/python3 resolve to MS Store stubs. jq not on PATH. Node is on PATH on both machines.
- **ASCII-only for `.ps1`.** Windows PowerShell 5.1 mis-decodes UTF-8-no-BOM emoji. Logged as gotcha, permanent design constraint for any .ps1 under Claudious.
- **Courtside skipped, not patched.** Installing preflight on a 15-behind dirty tree would halt the next session instantly. Wait for WIP resolution, then dedicated install session.
- **Superpowers Day-0 enablement committed in Claudious settings.json.** Prompt said "commit normally"; Logan can `git revert` the single-field change before Day-7 verdict if purity matters. Not blocking.

---

## Files changed this session

### Claudious
- PR #17 merged SHA `36f8f43` — Session #1: heartbeat layer + Implementer scope fix
  - `.claudious-heartbeat/` (new dir) + `SCHEMA.md` + `lama.json`
  - `scripts/update-heartbeat.sh` + `.ps1` (new)
  - `scheduled-tasks/intake.md` (Phase 0.5 added)
  - `scheduled-tasks/curate.md` (Machines section)
  - `scheduled-tasks/process.md` (antipatterns scope)
  - `archive/proposals-closed/expand-implementer-scope-to-antipatterns.md` (moved)
  - `CLAUDE.md` + `README.md` updates
  - `learnings/techniques.md` entry
- PR #18 merged — Session #3: preflight hook + regen diagnostic + PS1 fix
  - `scripts/update-heartbeat.sh` + `.ps1` (--preflight mode added)
  - `.claude/hooks/preflight.sh` + `.ps1` (new)
  - `.claude/settings.json` (new, includes superpowers Day-0 enablement alongside hook)
  - `CLAUDE.md` (Layer 2 documented)
  - `canonical/open-decisions.md` (fresh regen, 249 lines, 40 proposals)
  - `canonical/active-findings.md` (open-decisions-regen-stale-2026-04-23 finding)
  - `archive/proposals/process-open-decisions-regen-not-landing-on-main.md` (new proposal)
  - `learnings/techniques.md` + `learnings/gotchas.md` entries

### asf-graphics-app
- PR #1 open — Session #3: hook wrapper only
  - `.claude/hooks/preflight.sh` + `.ps1` (new, CURRENT_REPO=asf-graphics-app)
  - `.claude/settings.json` (merged SessionStart entry, preserves existing trial state)

### courtside-pro
- No changes. Pending WIP resolution.

---

## User Preferences changes pending

None from this session.

---

## Immediate next actions for new chat

1. **Read this handoff BEFORE responding to anything else.**
2. **Verify hook fired on this session.** When the new chat starts, the preflight hook should have run during session init. Look at terminal output for `🫀 lama | ...` or `[HB] lama | ...` status line. If absent, hook isn't firing → add to Session #4 scope.
3. **Confirm ASF PR #1 status.** If Logan merged it, note the merge SHA. If still open, surface the merge recommendation again.
4. **Scope Session #4 investigation CC prompt.** Four primary questions to answer in order:
   a. Does Process actually open a PR or just push to a branch and exit?
   b. If PR opens, does claude/* auto-merge fire on it?
   c. Is Intake's direct-to-main commit working, or is canonical/active-findings.md also rotting?
   d. Which other canonical files have the same silent-failure pattern?
5. **Draft and save Session #4 CC prompt** to `/mnt/user-data/outputs/cc-prompt-03-process-regen-investigation.md`.
6. **Surface pending decisions** (ASF merge, superpowers field, hook E2E) if unresolved.

---

## System state reference

- **Claudious PC clone:** `C:\Users\logan\Projects\Claudious` (still pending migration to `Documents/GitHub/`)
- **Claudious Mac clone:** `~/Documents/GitHub/Claudious` (unverified this session, claimed by prior handoff)
- **Current branch on PC:** main, clean after this handoff push
- **Active heartbeats:** `lama.json` only (mac-studio.json registers on next Mac CC session)
- **3 daily routines on Opus 4.7:** Intake 6am, Process 7am, Curate 8pm CT (UI-confirmed)
- **Next Process run that may surface the regen bug in action:** 2026-04-24 07:00 CT
- **Auto-merge workflow:** `.github/workflows/auto-merge-claude.yml` active for `claude/*` branches (verified by PR #17 and #18 both auto-merging cleanly)
- **Context at chat close:** ~78% used

## END OF HANDOFF
