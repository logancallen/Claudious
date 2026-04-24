# Process Regen Investigation — 2026-04-24

**Hypothesis:** Process routine's Phase 3 canonical regen writes land on unmerged `claude/<slug>` session branches, causing silent main-branch drift on `canonical/open-decisions.md` and related files.

**Investigation branch:** `claude/process-regen-investigation`
**Starting main SHA:** `344c7530eb2f71bf3b42f14c49244d5bb1eb1298`
**Investigator:** Claude Code (Session #4)
**Note:** Repo canonical path on this machine is `C:\Users\logan\Projects\Claudious` (not `Documents\GitHub\Claudious` as the prompt stated).

---

## Executive Summary (read-this-first)

**Hypothesis verdict: CONFIRMED** at the main-branch level, with nuance.

- Between the 2026-04-17 seed and the 2026-04-24 manual PR #18, **zero** Process-routine commits reached `canonical/open-decisions.md` on `origin/main`.
- The smoking gun is orphan commit `761e1ffaac71e789532c34d1cef09d99673d084e` on `origin/claude/intelligent-lamport-H43o6`, which executed a full Phase 3 regen (28→37 entries) and committed `canonical/open-decisions.md` — but was never PR'd, so it never reached main.
- A separate Process run on 2026-04-20 DID merge (PR #4, squash `8d31c5e`) but **skipped Phase 3 entirely** — its file list contains no `canonical/open-decisions.md`.

**The drift has multiple root causes, not one:**

| ID | Failure mode | Evidence |
|---|---|---|
| F1 | Phase 3 silently skipped in otherwise-successful Process runs | PR #4 file list has no `canonical/open-decisions.md` despite COMPLETE status |
| F2 | Phase 3 runs but commits to an unmerged `claude/<slug>` session branch | Orphan `761e1ff` on `claude/intelligent-lamport-H43o6` |
| F3 | Auto-deploy mirror to `canonical/prompting-rules.md` / `canonical/antipatterns.md` never runs | Zero commits to these files on any branch since seed, despite deploy work |
| F4 | Intake suffers from F2 too — orphans on `claude/pensive-gates-*` | 2026-04-21 and 2026-04-22 intakes exist only on session branches |
| F5 | Routines don't run at all on some days | No ledger file for 2026-04-21 or 2026-04-23 |

**Blast radius:** 4 canonical files have orphaned updates (not just `open-decisions.md`). Also affected: `canonical/active-findings.md`, `canonical/claude-state.md`, `canonical/claude-code-state.md`.

**Recommended fix (Session #5):** Option 3 variant — implement orphan-branch reconciliation as a **scheduled GitHub Actions workflow** (`.github/workflows/auto-pr-stale-claude.yml`, hourly, uses `GITHUB_TOKEN`). Rejected: Option 1 (spec can't bypass cloud-runtime session branching), Option 2 (`gh pr create` is blocked in the cloud-routine runtime per 2026-04-20 handoff).

**Backfill:** PR #18 already closed most of the drift gap. Current delta is 1 proposal file (`process-open-decisions-regen-not-landing-on-main`) missing from `canonical/open-decisions.md`. A surgical backfill (one entry append + header bump) suffices.

---

## Step (a) — Process spec Section 5 verbatim

### Section 5 body (from `scheduled-tasks/process.md:248-262`)

```bash
git add -A
git commit -m "process: ${TODAY} verify + canonical regen" || echo "nothing new"
git push origin main

STATUS="COMPLETE"
if [ "$TRIAGED" = "0" ] && [ "$DEPLOYED" = "0" ] && [ "$VERIFIED" = "0" ]; then
  STATUS="COMPLETE_NO_WORK"
fi

END=$(date +%s)
DUR=$((END - START))
```

### Relevant Section 0 preamble (`process.md:23-27`)

```bash
CURRENT_BRANCH=$(git branch --show-current)
[ "$CURRENT_BRANCH" != "main" ] && { echo "ABORT: not on main"; exit 1; }
[ -n "$(git status --porcelain)" ] && { echo "ABORT: dirty tree"; exit 1; }

git pull origin main --ff-only || { echo "ABORT: pull failed"; exit 1; }
```

### Spec read-out

| Question | Answer |
|---|---|
| Does spec say `git push origin main`? | **YES** — verbatim on `process.md:253` |
| Does spec say `git push origin claude/<slug>`? | No |
| Does spec mention `gh pr create`? | No |
| Does spec mention `gh pr merge` or `--auto`? | No |
| Does Section 0 enforce `CURRENT_BRANCH == main`? | Yes — hard abort if not on main |

**Interpretation:** The spec is **main-direct**. It explicitly asserts the session starts on `main`, and pushes back to `main`. The spec contains zero affordance for the cloud-routine-imposed `claude/<slug>` session-branch reality documented in `archive/handoffs/2026-04-20-1534.md`. This is a spec↔runtime mismatch, not an ambiguous spec.

---

## Step (b) — Process ledger entries (last 7 days)

### Ledger file inventory (past 7 calendar days, 2026-04-17 through 2026-04-23)

| Date | Ledger file present? | Process entry present? |
|---|---|---|
| 2026-04-17 | Yes | **No** (seed day — intake only) |
| 2026-04-18 | Yes | Yes — DEPENDENCY_NOT_SATISFIED only |
| 2026-04-19 | Yes | Yes — two entries (12:02 COMPLETE, 19:19 COMPLETE_NO_WORK) |
| 2026-04-20 | Yes | Yes — one entry (04:24 COMPLETE) |
| 2026-04-21 | **MISSING** | — (no ledger file created at all) |
| 2026-04-22 | Yes | **No** (01:09 curate DEPENDENCY_NOT_SATISFIED only; no intake/process for the day) |
| 2026-04-23 | **MISSING** | — (no ledger file created at all) |

**Finding B-0:** In the 7-day window, only **2 days** had an actual Process COMPLETE run that did non-trivial work (2026-04-19 @ 12:02, 2026-04-20 @ 04:24). Three of seven days have no ledger file at all (17 is seed, 21 and 23 are silent gaps). Whatever Process did or didn't do to canonical files over the 6+ day drift window, the vast majority of the window had no Process run at all.

### Process entry details

| File | Timestamp | Status | Commit SHA | Branch mentioned | `open-decisions-regenerated` field |
|---|---|---|---|---|---|
| 2026-04-18 | 12:04 | DEPENDENCY_NOT_SATISFIED | — (commit for skip) | — | FIELD_MISSING (skipped path, no regen) |
| 2026-04-19 | 12:02 | COMPLETE | `8b0e1d9` | none (pre-cloud-routine era likely) | **FIELD_MISSING** |
| 2026-04-19 | 19:19 | COMPLETE_NO_WORK | — | none | **FIELD_MISSING** |
| 2026-04-20 | 04:24 | COMPLETE | `9bc262adaab59a96ee27d4e24c3207ef384ebaf1` | **`claude/intelligent-lamport-oLzsB`** (explicit branch-note, "PR to main to follow") | **FIELD_MISSING** |

### Branch-based runs detected

**2026-04-20 @ 04:24** (`archive/runs/2026-04-20.md:24`) states verbatim:

> branch-note: developed on `claude/intelligent-lamport-oLzsB` per task assignment; PR to main to follow

This is the smoking gun confirming the cloud routine created a session branch rather than letting the Process spec push to `main`. The same day's curate entry (`archive/runs/2026-04-20.md:31`) shows the identical pattern on `claude/amazing-carson-e8muI`. Per `archive/handoffs/2026-04-20-1534.md`, the PR for that branch required manual intervention (PR #4, gh CLI blocked, MCP github tools unavailable at the time) to merge.

**2026-04-19 @ 12:02** has no branch-note. Possibilities: (1) that run was invoked from a local/non-cloud CC session where Section 0's `[ "$CURRENT_BRANCH" != "main" ] && ABORT` actually held, and it really did push to `main`; (2) the routine ran on a session branch but the author of the ledger entry didn't note it. Step (d) will resolve which is true by checking whether SHA `8b0e1d9` is on `origin/main`'s first-parent history.

### Sub-finding B-1: Process ledger entries consistently omit the `open-decisions-regenerated=<yes|no>` field

Every single Process entry above is missing the `outputs: ... open-decisions-regenerated=<yes|no>` field that Section 6 of `scheduled-tasks/process.md:270` mandates. This is a Phase-4-side implementation gap: the routines are not following their own output contract. This evidence is expanded in Step (i).

---

## Step (c) — Claude-authored PR inventory

### Authorship note

No PRs are authored by `app/claude` — **all 18 PRs are authored by `logancallen`** (the routines commit via `git config user.name "logancallen"` in `process.md:20`). The prompt's `author:app/claude` filter would have returned zero; I'm reporting against the branch-name pattern `claude/*` instead, which is the reliable signal for "cloud routine ran under a session branch".

### Aggregate counts (full PR history, 18 PRs total)

| State | Count |
|---|---|
| MERGED | 17 |
| OPEN | 0 |
| CLOSED (unmerged) | 1 |

### OPEN PRs

None. Every cloud-routine `claude/*` session branch that was pushed has been either merged or closed.

### CLOSED-unmerged PRs

| # | Branch | Title | Created |
|---|---|---|---|
| 3 | `claude/amazing-carson-slCQE` | curate: 2026-04-20 04:48 skipped — deps not ready | 2026-04-20 04:51 |

This is a skipped curate (intake+process not ready at 04:48), closed without merging by design. Not a silent-failure orphan.

### PRs with `claude/*` head branches (cloud routine session branches)

Six PRs with `claude/*` branch heads that are **distinctly cloud-routine slugs** (i.e., `claude/<adj>-<name>-<random>`):

| # | Branch | Title | Merged? |
|---|---|---|---|
| 3 | `claude/amazing-carson-slCQE` | curate skipped | **No (closed)** |
| 4 | `claude/intelligent-lamport-oLzsB` | Archive intake findings from 2026-04-20 and deploy two techniques | Yes — 2026-04-20T05:07:45Z |
| 5 | `claude/amazing-carson-e8muI` | Populate briefing and digest for 2026-04-20 curate run | Yes — 2026-04-20T05:31:29Z |

(The other `claude/*` branches — `claude/handoff-...`, `claude/reject-...`, `claude/grok-scan-pipeline-v1`, etc. — are hand-named by Logan, not cloud-routine-slug format.)

### Sub-finding C-1: Branch-based routine runs DID merge

Contrary to the worst-case hypothesis, PR #4 (the 2026-04-20 Process run on `claude/intelligent-lamport-oLzsB`) and PR #5 (the same day's Curate run on `claude/amazing-carson-e8muI`) were both merged. **The cloud-routine-branch pattern is not producing orphan PRs** in the ordinary case.

### Sub-finding C-2: The hypothesis needs revision

If cloud-routine PRs are merging, then the drift on `canonical/open-decisions.md` is not caused by unmerged branches. Candidate revised hypotheses:

1. **Phase 3 regen never ran inside the 2026-04-20 Process session** (the ledger output line lacks `open-decisions-regenerated=yes` — it could be silently `no` or the phase was skipped entirely).
2. **Process didn't run on 2026-04-21 through 2026-04-23**, so any drift that accumulated after the 2026-04-20 run has no scheduled mechanism to clear. Ledger absence (per Step B-0) corroborates this.
3. **Combination:** Phase 3 may or may not have run on 2026-04-20; separately, the absence of runs for 3 subsequent days guarantees drift.

Step (d) distinguishes between these.

---

## Step (d) — `canonical/open-decisions.md` write history

### All commits touching the file since 2026-04-17 (across all refs)

```
e165577 feat(nervous-system): pre-session doctor hook + open-decisions diagnostic + ps1 exit fix (#18)   [on main]
ec8e5bf feat(nervous-system): pre-session doctor hook + open-decisions diagnostic + ps1 exit fix          [PR source, superseded by squash]
761e1ff process: 2026-04-20 second-pass regen + verify                                                    [ORPHAN on origin/claude/intelligent-lamport-H43o6]
cc3fc9d canonical: seed 9 signal-dense files from existing sources                                        [on main]
b4b2a3b canonical: seed 9 signal-dense files from existing sources                                        [PR source, superseded by squash]
```

### On `origin/main --first-parent` only

```
e165577 feat(nervous-system): pre-session doctor hook + open-decisions diagnostic + ps1 exit fix (#18)    2026-04-24T00:52
cc3fc9d canonical: seed 9 signal-dense files from existing sources                                        2026-04-17 (seed)
```

### The orphan: `761e1ff` — smoking gun

| Property | Value |
|---|---|
| SHA | `761e1ffaac71e789532c34d1cef09d99673d084e` |
| Commit time | 2026-04-20 12:04:53 +0000 |
| Author | `logancallen <loganallensf@gmail.com>` |
| Message | `process: 2026-04-20 second-pass regen + verify` |
| Body | "Open-decisions regenerated 28→37 entries (sync-up after earlier 04:24 run added 4 proposals). Evidence loop: 10 W / 0 B / 0 R across 2026-04-13..2026-04-19 deploys. No new triage or deploys this pass — intake dispositions from prior run intact, queue empty." |
| Files changed | `archive/runs/2026-04-20.md` (+7), `canonical/open-decisions.md` (+176 / −102, i.e., full regen) |
| Reachable from | `origin/claude/intelligent-lamport-H43o6` only |
| Reachable from origin/main? | **NO** |
| PR created for it? | **NO** (per Step (c) PR inventory — only `-oLzsB` had PR #4, not `-H43o6`) |

### The companion merged-but-incomplete PR — PR #4

The 2026-04-20 **first-pass** Process run at 04:24 local landed on `claude/intelligent-lamport-oLzsB` and was merged via PR #4 (squash commit `8d31c5e`). Critically, PR #4's file list (per `gh pr view 4 --json files`) is:

```
archive/proposals/claudemd-200-line-cap.md
archive/proposals/cowork-ga-desktop.md
archive/proposals/mcp-spec-oauth-2-1.md
archive/proposals/operating-model-5-parts.md
archive/queue/deployed.log
archive/runs/2026-04-20.md
learnings/platforms/claude.md
learnings/techniques.md
```

`canonical/open-decisions.md` is **absent** from PR #4's diff. The 04:24 Process run completed Phases 1 and 2 (triage + deploy) but never wrote the Phase 3 canonical regen. A follow-up session attempted the regen at 12:04 UTC (the `761e1ff` orphan), committed to `claude/intelligent-lamport-H43o6`, but no PR was ever created.

### Interpretation

**Hypothesis CONFIRMED** at the main-branch level:

- Between the seed (`cc3fc9d`, 2026-04-17) and yesterday's PR #18 (`e165577`, 2026-04-24), **zero** Process-routine commits touched `canonical/open-decisions.md` on `origin/main`.
- The Process regen that DID happen on 2026-04-20 (`761e1ff`, 28→37) is trapped on an unmerged `claude/<slug>` session branch.
- The Process run that DID merge via PR (#4) never executed Phase 3 at all — its file list contains no canonical regen output.

The drift is therefore driven by **two distinct failure modes acting together**:

1. **F1 — Phase 3 skipped silently.** The 04:24 Process run on 2026-04-20 merged via PR #4 without regenerating `canonical/open-decisions.md`. Ledger entry does not emit `open-decisions-regenerated=<yes|no>` (Section 6 contract unimplemented), so the skip was invisible.
2. **F2 — Phase 3 runs but is orphaned.** The 12:04 Process retry on 2026-04-20 did regenerate the file but committed to a cloud-routine session branch that was never PR'd to main.

PR #18 (2026-04-24, Logan's manual pre-session doctor hook work) did a manual regen that brought main from 28 → 40 entries. That closed most of the drift gap, leaving only a 1-file delta (41 on disk, 40 in file) on the current tip.

---

## Step (e) — Blast radius across Process-written canonical files

Process's write authority per `CLAUDE.md`: `canonical/open-decisions.md` (full regen), `canonical/prompting-rules.md` (auto-deploy mirror), `canonical/antipatterns.md` (auto-deploy mirror), `canonical/active-findings.md` (Action field). Intake writes `canonical/claude-state.md`, `canonical/claude-code-state.md` (OFFICIAL only), and `canonical/active-findings.md` (append).

### Per-file breakdown (since 2026-04-17 seed)

| File | Main-branch commits | All-refs commits | Orphan count | Orphan SHAs | Orphan source |
|---|---|---|---|---|---|
| `canonical/open-decisions.md` | 2 (seed `cc3fc9d`, PR#18 `e165577`) | 3 | **1** | `761e1ff` | Process 2026-04-20 second-pass (branch `claude/intelligent-lamport-H43o6`) |
| `canonical/active-findings.md` | 4 (seed, `e9a7c9a` 04-20 intake direct-push, PR#16, PR#18) | 6 | **2** | `d9fb936`, `e06633f` | Intake 2026-04-21 (branch `claude/pensive-gates-urwlm`), Intake 2026-04-22 (branch `claude/pensive-gates-BAetU`) |
| `canonical/prompting-rules.md` | 2 (seed, PR#16) | 2 | 0 | — | — |
| `canonical/antipatterns.md` | 2 (seed, PR#16) | 2 | 0 | — | — |
| `canonical/claude-state.md` | 3 (seed, `e9a7c9a` 04-20 intake, PR#16) | 4 | **1** | `d9fb936` | Intake 2026-04-21 (branch `claude/pensive-gates-urwlm`) |
| `canonical/claude-code-state.md` | 3 (seed, `e9a7c9a` 04-20 intake, PR#16) | 5 | **2** | `d9fb936`, `e06633f` | Intake 2026-04-21, Intake 2026-04-22 |

### Key observations

**O-1 — `canonical/prompting-rules.md` and `canonical/antipatterns.md` have received ZERO Process commits in the 7-day window, on any branch.**
This is consistent with the ledger: the only Process COMPLETE runs that did real deploy work (2026-04-19 @ 12:02, 2026-04-20 @ 04:24) wrote to `learnings/*.md` via auto-deploy. Per the spec, they SHOULD also have mirrored those to `prompting-rules.md` / `antipatterns.md`. The fact that no commit exists — not even on an orphan branch — means the **mirror step silently didn't execute**. This is a third failure mode distinct from F1/F2.

**O-2 — Intake shares the same orphan-branch failure mode as Process.**
The 2026-04-20 intake direct-pushed to main (`e9a7c9a`, not a PR merge). The 2026-04-21 and 2026-04-22 intakes landed on `claude/pensive-gates-*` session branches and were never merged. So main is missing the Intake canonical updates from 04-21 and 04-22.

**O-3 — 2026-04-23 intake is not represented on any branch.**
No `intake: 2026-04-23 …` commit exists on any ref. Consistent with the ledger-absence pattern from Step B-0.

**O-4 — Flag: `canonical/open-decisions.md` is not the only drifting canonical file.**
`canonical/active-findings.md`, `canonical/claude-state.md`, and `canonical/claude-code-state.md` are all missing at least one Intake pass's worth of updates. The drift blast radius is 4 files, not 1.

### Updated failure-mode catalog

| ID | Description | Evidence |
|---|---|---|
| **F1** | Phase 3 (open-decisions regen) silently skipped in an otherwise successful Process run. | PR #4 file list omits `canonical/open-decisions.md` despite ledger entry showing `COMPLETE`. |
| **F2** | Phase 3 runs but commits to an unmerged cloud-routine session branch. | Orphan `761e1ff` on `claude/intelligent-lamport-H43o6`. |
| **F3** | Auto-deploy mirror step to `prompting-rules.md` / `antipatterns.md` never runs. | Zero commits to these files on any branch despite Process runs with deployed items. |
| **F4** | Intake's canonical updates also orphan onto `claude/<slug>` branches without a PR. | Orphans `d9fb936`, `e06633f` on `pensive-gates-*` branches. |
| **F5** | Intake and Process do not run at all on some days (no ledger file created). | 2026-04-21 and 2026-04-23 have no `archive/runs/<date>.md` file. |

---

## Step (f) — Intake behavior

### Intake spec (Section 6 of `scheduled-tasks/intake.md:300-313`)

```bash
git add -A
git commit -m "intake: ${TODAY} output + canonical updates" || echo "nothing new"
git push origin main
```

Intake's spec is **identical** to Process's — same `git push origin main` literal, no PR step. Section 0 also asserts `CURRENT_BRANCH == main` (confirmed by structure inspection).

### Intake file landing by date

| Intake date | File on main? | File on orphan branch? | Where? |
|---|---|---|---|
| 2026-04-17 | Yes (via bulk archive commit `626e082`) | Yes (`6d08b0c` duplicate on branch) | Intake itself ran, file made it to main |
| 2026-04-19 | Yes (via bulk archive `626e082`) | — | On main |
| 2026-04-20 | **Yes — direct push** (`e9a7c9a`, intake-authored) | — | **Intake actually pushed to main** |
| 2026-04-21 | **No** | Yes — `0c2d92a`, `d9fb936` | `origin/claude/pensive-gates-urwlm` (orphan) |
| 2026-04-22 | **No** | Yes — `e06633f` | `origin/claude/pensive-gates-BAetU` (orphan) |
| 2026-04-23 | **No** | **No** (doesn't exist anywhere) | Intake didn't run at all |

### Interpretation

**F-1 — Intake's behavior is inconsistent across days.**
The 2026-04-20 intake run produced commit `e9a7c9a` which is a direct (non-squash-merge) commit on `origin/main` — meaning that session really did `git push origin main` successfully. The 2026-04-21 and 2026-04-22 intake runs produced commits that landed on `claude/pensive-gates-*` session branches instead. Same spec, same Section 0 guard, different outcome.

**F-2 — The likely reason for the inconsistency is the invocation mode.**
The 2026-04-20 intake commit is authored by `logancallen` with no cloud-slug branch. This most likely was invoked from a local CC session (probably by Logan manually running the routine in a terminal, where `CURRENT_BRANCH == main` was actually true). The 2026-04-21 and 2026-04-22 runs carry cloud-slug branch names (`pensive-gates-urwlm`, `pensive-gates-BAetU`) which is the signature of Anthropic's cloud-routine runtime creating a session branch before checking Section 0's guard.

**F-3 — Section 0's `[ "$CURRENT_BRANCH" != "main" ] && ABORT` guard is being bypassed or ignored in cloud runs.**
Per the spec, `intake.md:24-25` (same pattern as process.md) should have aborted the 2026-04-21 and 2026-04-22 runs when they started on a session branch. The commits exist anyway, which implies either (a) the cloud runtime is checking-out main, running the routine, but pushing from a session-branch HEAD; or (b) the runtime is silently replacing `git push origin main` with `git push origin <session-branch>` post-hoc, after the routine commits; or (c) Section 0 isn't being executed literally (e.g., the runtime interprets `ABORT` as a warning).

Either way: **Intake shares Process's failure mode F2 (orphan session-branch commits).** The fix, whatever it is, must apply to both routines — not just Process.

**F-4 — No intake files exist anywhere for 2026-04-23.**
Consistent with Step B-0: cloud routines failed to run at all on 2026-04-23.

### Fix-choice implication

Step (g) cannot choose **Option 1 (direct-push-to-main)** as the fix for Process, because Intake demonstrably can land on main via direct push *sometimes* but not reliably. The same mechanism that gives Intake's 2026-04-20 run a main-direct commit is not the cloud runtime — it's local invocation. Under the cloud runtime, *both* routines orphan. So the fix must work under the cloud runtime.

---

## Step (g) — Fix recommendation

### Recommendation: Option 3 — reconciliation pass, implemented as a **scheduled GitHub Actions workflow** rather than as a Curate prompt step.

**Confidence:** HIGH on the approach direction. MEDIUM on the specific Actions-workflow implementation detail vs. extending Curate — the evidence strongly favors Actions, but both can work.

### Why Option 1 is rejected

Option 1 (change the spec to commit-to-main via some mechanism that actually works in cloud routines) is rejected because:

- The cloud-routine runtime is an Anthropic-side constraint, not repository-side. We have no interface to force a routine's `git push origin main` to actually push to main when the runtime insists on a session branch.
- Intake's 2026-04-20 run did direct-push to main, but only because it ran locally, not from the cloud-routine runtime. That evidence is not reproducible under the cloud routine. 2026-04-21 and 2026-04-22 intakes (both cloud) orphaned identically to Process.
- Asking Anthropic to expose a "bypass session branch" flag is a cross-team dependency with unknown timeline. Cannot be the default plan.

### Why Option 2 is rejected

Option 2 (add `gh pr create && gh pr merge --auto --squash` to the routine's Section 5) is rejected because of a **hard prerequisite failure** documented in `archive/handoffs/2026-04-20-1534.md:30`:

> "Process (04:24 on claude/intelligent-lamport-oLzsB feature branch) → **failed to open PR from Grok UI session (MCP github tools unavailable, gh CLI blocked)**. Manually created PR #4, auto-merged as squash commit 8d31c5e."

The exact commands Option 2 requires — `gh pr create` and `gh pr merge` — have been empirically shown to be blocked in the cloud-routine runtime. Until that changes on Anthropic's side, any Option-2 implementation would silently no-op the same way the current spec does. The failure would just shift from "push to main" to "create PR", without producing visible commits on main.

If Anthropic enables `gh` in cloud routines in the future, Option 2 becomes viable and is in fact preferable (it keeps routine-authorship semantics and avoids a separate reconciliation pass). But it is not a safe fix to ship today.

### Why Option 3 is selected — and why implemented as Actions rather than Curate

Option 3 accepts the cloud-runtime reality: routines will create orphan `claude/<slug>` branches regardless of their spec. A reconciliation mechanism watches for those orphans and merges them. This mechanism can be implemented in two places:

| Variant | Runs where | Cadence | gh/auth mechanism | Impact on Curate prompt | Drift window |
|---|---|---|---|---|---|
| 3a — Curate step | Inside Curate cloud routine (8pm CT) | 1×/day | gh CLI (blocked in cloud runtime per 2026-04-20 handoff) | Adds ~30 lines to already-dense Curate prompt; shares the same gh-blocked failure mode | Up to 13 hours (Process 7am → Curate 8pm) |
| 3b — Actions cron workflow | GitHub Actions runner | Every 1h (or finer) | `GITHUB_TOKEN` — always present, never blocked | None | 1 hour worst case |

**3b is strictly better.** It uses the same `GITHUB_TOKEN`-based pattern that the existing `.github/workflows/auto-merge-claude.yml` uses successfully today. It does not depend on the cloud-routine runtime state. It does not bloat Curate's prompt. It closes the drift window 13× tighter than 3a.

### Pre-requisites before Session #5 fix implementation

1. **Confirm existing `auto-merge-claude.yml` behavior.** Verify that when a PR is opened against main on a `claude/*` head branch, the workflow auto-merges it. Existing PRs #4, #5, #17, #18 show this works. No change needed.
2. **Confirm `GITHUB_TOKEN` permissions.** The new workflow needs `pull-requests: write` and `contents: read`. Same as `auto-merge-claude.yml`.
3. **Decide on stale-branch threshold.** Recommendation: open a PR for any `claude/*` branch with unmerged commits older than **30 minutes** — short enough to avoid racing a manual PR, long enough that transient routine failures can settle before auto-merge engages.
4. **Decide on canonical-only filtering (optional).** Option A: auto-PR every orphan `claude/*` branch (simpler, broader). Option B: auto-PR only orphans that touch `canonical/` (narrower blast radius). Recommendation: Option A — the existing auto-merge-claude.yml already constrains the blast radius by only triggering on `claude/` prefix, and orphan branches that don't touch canonical are still dead branches worth collecting.

### High-level order of operations for Session #5 (the fix prompt)

1. Author `.github/workflows/auto-pr-stale-claude.yml`: cron-triggered (hourly), uses `gh` + `GITHUB_TOKEN`, enumerates `claude/*` remote branches, filters to those with commits not on main AND no open PR AND tip older than 30 minutes, opens a PR per orphan. The existing auto-merge-claude.yml then takes over and squashes it.
2. Test-fire the new workflow manually via `workflow_dispatch` against the currently-orphan branches listed in Step (e).
3. Verify main receives the canonical regen from `761e1ff` specifically (that's the smoking gun).
4. Decide separately whether to additionally implement Option 2 once Anthropic enables `gh` in cloud routines (defer).

### Parallel fix — address failure modes F1, F3, F5 as well

The reconciliation workflow fixes F2 and F4 (orphan branches). It does NOT fix:

- **F1** — Phase 3 silently skipped inside the routine. Fix: enforce ledger emission of `open-decisions-regenerated=<yes|no>` (Section 6 contract) and add an assert at end of Phase 3. If the file wasn't rewritten, the routine logs `open-decisions-regenerated=no` loudly.
- **F3** — Auto-deploy mirror to `prompting-rules.md` / `antipatterns.md` never runs. Fix: similar ledger field, e.g., `canonical-mirrors-written=<list>`, plus a post-Phase-2 assert.
- **F5** — Routines don't run at all on some days. Fix: a second Actions cron workflow that checks `archive/runs/<today>.md` for expected entries and pages loud if absent by a deadline. Out of scope for Session #5 unless Logan wants it bundled.

F1/F3 fixes require editing `scheduled-tasks/process.md` itself, which is also out-of-scope for this investigation but should be in Session #5 alongside the Actions workflow.

---

## Step (h) — Backfill plan (DO NOT EXECUTE)

### Current delta vs. prompt's assumption

The prompt was written against `docs/drift-report.md M-3` which cited a **9-file delta** (28 in open-decisions, 37 on disk). PR #18 (`e165577`, merged 2026-04-24T00:52Z — i.e., yesterday's manual session) already regenerated open-decisions.md and closed the bulk of that delta. As measured on investigation-branch tip:

| Metric | Value |
|---|---|
| Proposals on disk (`archive/proposals/*.md`, minus `.gitkeep`) | 41 |
| `### ` entries in `canonical/open-decisions.md` | 40 |
| `**Total open:**` header value | 40 |
| Entries in file without a matching proposal file | 0 |
| Proposal files without a matching entry | **1** |

### Missing proposal (forward direction)

| Proposal file | Status |
|---|---|
| `archive/proposals/process-open-decisions-regen-not-landing-on-main.md` | On disk but absent from `canonical/open-decisions.md` |

This is the single remaining orphan. It's the proposal describing the very bug this investigation documents — fitting, and small.

### Recommended backfill path (for Session #5 or a simpler manual task)

Because the delta is 1 file, the full manual Process-cycle regen described in the prompt is overkill. A minimal, surgical backfill is sufficient:

1. Fresh CC session, branch `claude/process-opendec-backfill-2026-04-24` off current `origin/main`.
2. Read `archive/proposals/process-open-decisions-regen-not-landing-on-main.md` to extract its `Summary`, `Why proposal`, and `Logan action` fields.
3. Append a new `### process-open-decisions-regen-not-landing-on-main` block to `canonical/open-decisions.md`, matching the existing 4-line entry format (File / Summary / Why proposal / Logan action).
4. Bump the header `**Total open:** 40` → `41`. Bump `**Last updated:** 2026-04-23` → `2026-04-24`.
5. PR with title `backfill: open-decisions entry for process-open-decisions-regen-not-landing-on-main`. Auto-merge via existing `auto-merge-claude.yml`.
6. Estimated runtime: < 5 minutes. Auto-merge window: seconds (same workflow that handled PR #18).

**Alternative (larger-scope backfill)** — if Session #5 decides to regenerate the entire file from scratch to canonicalize ordering / format:

1. Branch `claude/process-manual-backfill-2026-04-24`.
2. Execute `cat > canonical/open-decisions.md <<HEADER ... HEADER` then loop over `archive/proposals/*.md` to rebuild.
3. Use Section 4 Phase 3 regen block in `scheduled-tasks/process.md` as the reference.
4. PR, auto-merge. Estimated runtime: ~15 minutes.

### Do not execute in this investigation

This session only diagnoses. The actual backfill (whichever variant) is Session #5's deliverable.

---

## Step (i) — Ledger field audit: `open-decisions-regenerated=<yes|no>`

### Spec (Section 6 of `scheduled-tasks/process.md:270`)

```
- outputs: queue=+X, proposals=+X, deployed=X, verified=X, canonical-mirrors=X, open-decisions-regenerated=<yes|no>
```

### Observed in actual Process ledger entries

| Ledger entry | `open-decisions-regenerated` field present? | Value |
|---|---|---|
| `2026-04-18 12:04` DEPENDENCY_NOT_SATISFIED | No — skipped-path output structure | n/a |
| `2026-04-19 12:02` COMPLETE | **No** | — |
| `2026-04-19 19:19` COMPLETE_NO_WORK | **No** | — |
| `2026-04-20 04:24` COMPLETE | **No** | — |

Also checked: the orphan Process commit `761e1ff` DID append a Process ledger entry to `archive/runs/2026-04-20.md` — that entry was in the second-pass regen. Let me read the orphan ledger content to confirm whether IT emitted the field.

### Orphan-branch ledger content (the second-pass Process entry)

The orphan commit `761e1ff` added this entry to `archive/runs/2026-04-20.md`:

```
### 12:01 process [COMPLETE]
- start: 2026-04-20T12:01:00
- inputs: archive/intake/2026-04-20.md, archive/queue/, archive/queue/deployed.log, archive/proposals/
- outputs: queue=+0, proposals=+0, deployed=0, verified=10, canonical-mirrors=0, open-decisions-regenerated=yes
- summary: Triage 0 new (intake dispositions from 04:24 run intact; all 19 findings accounted). Deploy 0 (queue empty). Open-decisions regenerated 28→37 entries (sync-up after 04:24 added 4 proposals). Verify 10 W / 0 B / 0 R across 2026-04-13..2026-04-19 deploys. Today's 04-20 deploys skipped per same-day rule.
- branch-note: developed on `claude/intelligent-lamport-H43o6` per task assignment; PR to main to follow
```

**The second-pass entry DID emit the field correctly: `open-decisions-regenerated=yes`.** It also emitted `canonical-mirrors=0`. This entry follows Section 6 literally — but the commit it lives on is an orphan, so the ledger entry itself is only visible on `claude/intelligent-lamport-H43o6`, not on main's `archive/runs/2026-04-20.md`.

### Corrected interpretation

The field IS being emitted — by the routine runs that follow Section 6 literally. The pattern:

- **First-pass Process @ 04:24** (the run that merged via PR #4) — did NOT emit the field. Did NOT execute Phase 3 (no open-decisions.md in PR). Looser spec adherence.
- **Second-pass Process @ 12:01** (orphan, the `761e1ff` commit) — DID emit the field. DID execute Phase 3 (regenerated 28→37). Literal spec adherence.

So the Section 6 spec is being followed by the runs that actually do Phase 3, and is being silently violated by the runs that skip Phase 3. The field's absence is itself a signal that Phase 3 was skipped. **This is actionable: a main-branch reader of `archive/runs/<date>.md` can tell which Process runs executed Phase 3 by checking whether the field is present.**

### Findings and recommendations

| Finding | Value |
|---|---|
| Is the field present in recent ledger entries? | **Sometimes** — present when Phase 3 ran, absent when Phase 3 skipped |
| When present, what value? | `yes` (the only observed instance, from the orphan) |
| Is this a spec gap? | **No** — spec is correct |
| Is this a runtime gap? | Yes — runtime inconsistently follows Section 6 |

**Spec change required:** None — the Section 6 contract is correct as written.

**Runtime change recommended** (for Session #5, not this one):

1. Move the `open-decisions-regenerated` determination from a free-form output-line value to a **phase-end assert** in `scheduled-tasks/process.md`. After Phase 3, compute `test -n "$(git diff HEAD -- canonical/open-decisions.md)"` and stamp `yes` / `no` into a bash variable that is interpolated into the ledger template. This makes emission mandatory rather than discretionary.
2. Treat `open-decisions-regenerated=no` on a COMPLETE run where `deployed>0 OR proposals>0` (i.e., Phase 1 or 2 had new items that should have flowed into open-decisions) as an ERROR-level entry. Surface loudly via `canonical/active-findings.md` Action field and/or daily briefing.
3. Consider adding the same deterministic-emission pattern for `canonical-mirrors=<count>` to close failure mode F3 (prompting-rules/antipatterns mirror never executing).


