# Handoff — Mastery Lab

**Recommended next-chat title:** `2026-04-25 — MASTERY — Session #6 fix draft (F1 + F3 + Curate review)`

**From session:** 2026-04-24 (Session #5 + overnight queue 2026-04-24)
**To session:** 2026-04-25 (Session #6 fix draft)
**Generated:** 2026-04-24 UTC (late — post-overnight-queue)
**Prior handoff archived:** `archive/handoffs/2026-04-25-overnight-queue-closeout.md`

---

## Current focus

Review three Session #6 investigation findings (F1, F3, Curate) already on main, decide fix scope, draft Session #6 fix prompt. A Session #5 fix (Option 3b reconciler) is live and in observation — guardrail-7 retune is the most urgent non-fix-review task.

---

## Completed — Session #5 (2026-04-24 AM)

1. **Probe diagnosis.** Verdict `gh-blocked`. Evidence: probe branch `origin/claude/gh-availability-probe-1777012492`. Diagnosis file on `claude/session-5-fix-diagnosis` (commit `d150540`).
2. **Option 3b reconciler workflow merged.** PR #20 (`7b03b3c`). `.github/workflows/orphan-claude-branch-reconciler.yml`. Hourly cron, 7 guardrails, `GITHUB_TOKEN` via `actions/github-script@v7`.
3. **Manual reconciler verification fire.** Run `24876235029` → guardrail 7 fired (18 > 10 orphans). Tripwire log committed to main as `1cae5f1`. Design issue flagged below in "Session #6 scope".
4. **Surgical backfill merged.** PR #21 (`813905a`). Added `process-open-decisions-regen-not-landing-on-main` entry. Open-decisions header now `41`; matches on-disk proposal count.
5. **Memory-reconciliation canonical note.** `canonical/logan-machine-state.md` direct-committed as `b8f64c9`. Contradicts stale user-memory line claiming `C:\Users\logan\Projects\` is deprecated.
6. **Session #5 handoff.** Committed as `d5d0a62`.

## Completed — Overnight queue (2026-04-24 late)

7. **Phase A gates — all 4 passed.** Handoff present, fix PR merged, memory note present, main clean and at HEAD = origin/main.
8. **Phase B — sync-knowledge.sh DIRS fix merged.** PR #22 (`71ea179`). Updated: `scout/`→`archive/scout/`, `evaluations/`→`archive/evaluations/`, `queue/`→`archive/queue/`, `digest/`→`archive/digest/`, removed non-existent `cross-platform/`, kept both top-level and `archive/` variants for `proposals/` and `retrospectives/`. Dry-run verified.
9. **Phase C — three Session #6 investigation docs merged.** PR #23 (`3c27a04`). Files:
   - `docs/investigations/2026-04-25-session-6-f1-phase-3-silent-skip.md`
   - `docs/investigations/2026-04-25-session-6-f3-auto-deploy-mirror.md`
   - `docs/investigations/2026-04-25-session-6-curate-orphan-check.md`
10. **Phase D — this handoff.** Commit pending.

---

## In-flight — Session #5 observation period

- **Reconciler hourly cron** is engaged, but will fail-closed on guardrail 7 every run until either (a) branches are pruned from origin to bring the count below 10, or (b) the guardrail-7 retune lands. Watch `archive/reconciler-log/` for daily rollup entries.
- **Day 0** of observation complete (2026-04-24). 6+ reconciler runs expected overnight — all will FAIL until Session #6 acts.

---

## Session #6 scope — review + decide

### Priority A (urgent — unblocks reconciler)

**A1. Guardrail-7 retune.** Reconciler's `MAX_ORPHANS` counts candidates BEFORE applying hand-named exclusion, guardrail 1 (age), and guardrail 3 (routine-eligibility). Fix: move candidate filtering to run before counting. Branch: small surgical edit to `.github/workflows/orphan-claude-branch-reconciler.yml`. Estimated effort: 30 min. Estimated risk: LOW.

### Priority B (investigation review + fix decision)

**B1. F1 — Phase 3 silently skipped.** Read `docs/investigations/2026-04-25-session-6-f1-phase-3-silent-skip.md`. Decide:
  - Ship defensive fix (deterministic `open-decisions-regenerated=<yes|no>` ledger emission + post-Phase-3 assertion) now, OR
  - Run root-cause probe routine first (`[PROBE] entering Phase 3` / `[PROBE] Phase 3 complete` instrumentation)
  - Recommendation from doc: ship the defensive fix, run the probe in parallel — both are cheap.

**B2. F3 — Auto-deploy mirror never fires.** Read `docs/investigations/2026-04-25-session-6-f3-auto-deploy-mirror.md`. Decide:
  - Bundle with F1 fix (same `scheduled-tasks/process.md` touch) — strongly recommended, avoids two round-trips
  - Include a queue-file-format lint requiring `Type:` header (auditing suggests most queue files omit it, causing Process's type-switch to fall through to no-mirror)
  - Consolidate ownership: delete Curate 4.3 graduation OR demote to reconciliation pass only

**B3. Curate — extend reconciler?** Read `docs/investigations/2026-04-25-session-6-curate-orphan-check.md`. Decide:
  - Extend Session #5 reconciler to `amazing-carson-*` branches (already matches slug pattern, will auto-include once guardrail-7 retune ships)
  - Accept the skip-log noise on main (3 extra commits in 7-day window)
  - Separately probe whether cloud-scheduled 8pm Curate is running at all (all observed Curate branches are Logan-local-authored — cloud path may be silently dead). This is likely Session #7 scope.

### Priority C (deferred)

**C1. F5 — routines not running on some days.** Ledger-absence detection workflow. Out of scope for Session #6 unless bundled with A1.

---

## Decisions made autonomously during overnight queue

1. **Reconciler cadence = hourly, not 6h.** Session #5 prompt proposed 6h; investigation doc Step (g) recommended "Every 1h (or finer)". Per "doc wins" authority rule, selected hourly. Documented in PR #20 body.
2. **Session #5 guardrail-7 fire treated as Session #6 scope, not silent-retry.** Per Session #5 prompt's halt rule. Surfaced in Session #5 handoff and this handoff for Logan's decision.
3. **Pre-flight dirty-tree files stashed, not committed.** `stash@{0}: session-5-preflight-stash` preserves `alerts.md`, `archive/queue/deployed.log`, `learnings/techniques.md` — uncommitted routine-output that predated Session #5. Deferred to Session #6 — decide whether to commit them (they represent real routine work) or drop the stash (if already superseded by later commits).
4. **sync-knowledge.sh fix kept both top-level and archive/ variants for `proposals/` and `retrospectives/`.** Both paths exist with different content — including both preserves sync correctness for both. Documented in PR #22.
5. **Did not run `sync-knowledge.sh` live.** Per overnight queue Phase B instruction — live run would touch secondary synced git folders; deferred to manual session.

---

## Pending for Session #6 (in priority order)

1. **A1 guardrail-7 retune** — unblocks reconciler (~30 min)
2. **B1+B2 bundled F1+F3 fix** — touches `scheduled-tasks/process.md` once (~2 hours)
3. **B3 Curate inclusion decision** — mostly passive (just ships with A1)
4. **Optional F1 probe** — independent investigation routine, parallelizable with B1+B2
5. **Preflight stash cleanup** — decide commit-or-drop for 3 preserved files

---

## Deferred items (carry-forward)

1. **Hook-not-firing-cross-chat** (Session #4 Question 0). No `🫀 lama` or `[HB] lama` preflight line observed. Separate investigation slot.
2. **ASF PR #1 merge decision.** Routes through ASF handoff.
3. **Mastery Lab project spec update** (7 Projects UI action).
4. **Scout routing clarification** (standalone vs folded into Intake/Process).
5. **PWA implementation for ASF Graphics** (staged chat).
6. **Cloud-scheduled Curate liveness probe** — did cloud Curate actually run in the observed window? All branches are logancallen-authored, suggesting cloud path may be dead. Session #7+ scope.

---

## Frustration signals / lessons

1. **"Count before filter" guardrail design is fragile.** Reconciler guardrail 7 triggered on first run because hand-named + old-merge-base branches inflated the candidate pool. Design lesson for future safety caps: filter first, count after.
2. **Shared write-authority often = no-ownership.** F3's root cause plausibly includes the CLAUDE.md Write-Authority Matrix giving BOTH Process and Curate write authority over the mirror files. Neither routine internalized it as "mine." Lesson: single-owner-per-file, with explicit read-only references for other routines.
3. **`logancallen` authorship on `claude/<slug>` branches = local invocation, not cloud.** This pattern is diagnostic — all curate orphans and the Session #4 smoking-gun are Logan-local, not cloud. Previously conflated in F2/F4 analysis. Future investigations should check author explicitly.
4. **One-shot cloud probe routines reproduce their own failure modes.** The 2026-04-24 gh-availability probe pushed to an orphan branch without a PR — the exact pattern Session #5 was testing for. Probes that need PR/merge signal should use GitHub Actions dispatch, not cloud routines.

---

## User Preferences changes pending

- **`userMemories.recent_updates` PC-paths line.** See `canonical/logan-machine-state.md`. CC cannot edit user memory directly; Logan must edit in a Mastery Lab chat. The current line claims `C:\Users\logan\Projects\` is deprecated; reality is Claudious canonical still lives there.

---

## Context snapshot

- **Main branch tip:** (will be this handoff's commit — pending)
- **Open PRs this session:** none open; all 4 (PR #20, #21, #22, #23) merged
- **Open-decisions.md entry count:** 41 (matches header)
- **New workflow active:** `orphan-claude-branch-reconciler` (hourly, will fail-closed on guardrail 7 until retune)
- **Preserved stash:** `stash@{0}: On main: session-5-preflight-stash` (3 files)
- **Cloud routines active:** intake (6am CT), process (7am CT), curate (8pm CT — but possibly silently non-running — see deferred item 6), weekly health check (Sunday 8am CT)
- **Retired routine:** `gh-availability-test` probe (one-shot, completed 2026-04-24 06:35Z)

---

## Session #6 opening move

1. Read this handoff.
2. Read the three Session #6 investigation docs on main (F1, F3, Curate).
3. Read `archive/reconciler-log/` for 1+ day of tripwire entries — how often is guardrail 7 firing?
4. Decide Priority A (guardrail-7 retune) — ship first.
5. Decide Priority B (F1 + F3 bundle) — draft fix for `scheduled-tasks/process.md`.
6. Decide Priority C (Curate extension vs defer).
