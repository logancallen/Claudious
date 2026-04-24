# Handoff — Mastery Lab

**Recommended next-chat title:** `2026-04-25 — MASTERY — Post-fix observation + Session #6 scope`

**From session:** 2026-04-24 (Session #5, Option 3b reconciler fix shipped)
**To session:** 2026-04-25 (Session #6, F1/F3 + Curate review or guardrail-7 retune)
**Generated:** 2026-04-24 UTC
**Prior handoff archived:** `archive/handoffs/2026-04-24-session-5-closeout.md`

---

## Current focus

Observation period for the Option 3b reconciler workflow (merged in PR #20). Decide Session #6 scope after 1 week of reconciler data: F1 (Phase 3 silently skipped), F3 (auto-deploy mirror never fires), Curate orphan risk, and the guardrail-7 retune flagged below. An overnight queue (2026-04-24) runs Phases A–D autonomously and may pre-stage Session #6 investigation docs.

---

## Completed items (Session #5)

1. **Phase 1 — probe diagnosis.** Verdict: `gh-blocked`. Evidence: probe branch `origin/claude/gh-availability-probe-1777012492` commit `50114da` shows `gh: command not found` on every gh invocation; `git push` works, but gh CLI is entirely absent from the routine runtime. Diagnosis file: `archive/tests/gh-availability-2026-04-24-diagnosis.md` (commit `d150540` on branch `claude/session-5-fix-diagnosis`).
2. **Phase 3 — Option 3b reconciler workflow merged.** PR #20, squash commit `7b03b3c`. File: `.github/workflows/orphan-claude-branch-reconciler.yml`. Seven guardrails implemented per prompt; cadence hourly (`0 * * * *`) per investigation doc Step (g) — prompt's 6h proposal overridden by "doc wins" rule.
3. **Phase 3 — manual verification fire.** Run `24876235029` completed with guardrail 7 firing: detected 18 orphan candidates > max 10. Tripwire logged FAILED to `archive/reconciler-log/2026-04-24.md` (commit `1cae5f1`). See "Open issue" section below.
4. **Phase 4 — surgical backfill merged.** PR #21, squash commit `813905a`. Added `process-open-decisions-regen-not-landing-on-main` entry (41st) to `canonical/open-decisions.md`. Header bumped 40→41, last-updated 2026-04-23→2026-04-24. Delta matched pre-run expectation of 1.
5. **Phase 5 — memory-reconciliation canonical note.** `canonical/logan-machine-state.md` committed directly to main as `b8f64c9`. Documents PC canonical path as `C:\Users\logan\Projects\Claudious` (contradicts stale user-memory entry claiming that path is deprecated). Next Mastery Lab chat needs to edit `userMemories.recent_updates` to match.
6. **Phase 6 — this handoff.** Commit pending.

**Pre-flight side note:** Stash `session-5-preflight-stash` (stash@{0}) preserves three files that were dirty on session start (`alerts.md`, `archive/queue/deployed.log`, `learnings/techniques.md`) — benign routine-output that was never committed. Investigate whether these belong on main and commit them, or drop the stash as superseded.

---

## Open issue — guardrail-7 retune (Session #6 or earlier)

The reconciler's first manual run hit guardrail 7 (`max 10 orphans per run`) because 18 `claude/*` branches are ahead of main. **The count is inflated by branches that would have been filtered later in the pipeline:**

- Hand-named branches (`canonical-restructure`, `gh-availability-probe-*`, `handoff-*`, `process-regen-investigation`, `session-5-fix-diagnosis`) — 5 of 18. Would skip via HAND_NAMED_PREFIXES check.
- Cloud-slug branches with merge-base > 2 days old — would skip via guardrail 1.
- Cloud-slug branches without `[routine]` marker (most current ones) — would skip via guardrail 3 if the slug pattern didn't match, but the slug pattern is broad so these would pass.

**Design fix (for Session #6 decision):** apply hand-named exclusion, guardrail 1 (age), and guardrail 3 (routine-eligibility) BEFORE counting toward MAX_ORPHANS. Count only the candidates that could actually become PRs.

**Why this wasn't fixed this session:** Per the Session #5 prompt, "if the first manual run fails any guardrail, STOP and report. Don't fix-and-retry silently — the failure is the signal." So the fix is surfaced for Logan's review rather than patched silently.

**Risk of leaving as-is:** while 18 candidates exist on origin, the workflow will fail-closed every hour. That's safe (no runaway merges) but noisy. Recommended action: prune merged-but-undeleted `claude/*` branches on origin to bring the raw count under 10, which unblocks the reconciler until the pre-filter redesign ships.

---

## In-flight items

1. **Session #5 reconciler observation period.** 1 week of data needed before Session #6 decision on guardrail-7 retune + Curate extension. Watch `archive/reconciler-log/` for daily entries and `canonical/briefing-today.md` for "Orphan reconciliation" appends. Monitor: does the hourly schedule fire? does it consistently fail-closed on the same 18 orphans, or do new orphans accumulate?
2. **Overnight queue 2026-04-24 (Phases A–D).** Runs after Session #5 close. Gates Session #5 completion, fixes sync-knowledge.sh DIRS if bugged, investigates F1/F3/Curate read-only. Expected output: 3 investigation docs + updated handoff.

---

## Pending for Session #6 (in priority order)

1. **F1 fix — Phase 3 silently skipped inside routine.** Per Session #4 investigation Step (g): ledger field `open-decisions-regenerated=<yes|no>` must be emitted deterministically; absent field on a COMPLETE run with `deployed>0 OR proposals>0` should be an ERROR. Requires editing `scheduled-tasks/process.md` Section 3/6. **Session #5 did not touch this.** Overnight queue Phase C1 will pre-stage an investigation doc.
2. **F3 fix — auto-deploy mirror to `prompting-rules.md` / `antipatterns.md` never runs.** Zero commits to these files on any branch since seed despite deploy work. Fix: similar ledger field (`canonical-mirrors-written=<list>`) + post-Phase-2 assert, and figure out why the mirror step isn't executing. Overnight queue Phase C2 will pre-stage an investigation doc.
3. **Curate coverage decision.** Session #5 explicitly did not touch `scheduled-tasks/curate.md`. The reconciler handles Curate orphans forward-looking, but Curate may need the same ledger-field hygiene as Process/Intake. Overnight queue Phase C3 checks Curate's orphan rate empirically.
4. **Guardrail-7 retune** (see "Open issue" above). Small surgical edit to the workflow's candidate-counting logic.
5. **F5 — routines not running at all on some days.** Ledger absence detection via a second Actions cron workflow. Out of scope for #6 unless Logan bundles.

---

## Deferred items (carried from prior handoff)

1. **Hook-not-firing-cross-chat (Session #4 Question 0).** No `🫀 lama` or `[HB] lama` preflight line observed at Session #4 start. Separate investigation slot — not folded into Process regen work.
2. **ASF PR #1 merge decision.** Mentioned in Session #4 kickoff, unresolved. Routes through ASF handoff, not Mastery.
3. **Mastery Lab project spec update (7 Projects).** 30-second UI action still pending from prior sessions.
4. **Scout routing clarification** (standalone vs folded into Intake/Process).
5. **PWA implementation for ASF Graphics** (staged chat `2026-04-20 — ASF — PWA Implementation`).

---

## Frustration signals / lessons

1. **"One-shot routine reliability is now in question."** The 2026-04-24T06:13Z gh-availability probe routine DID fire (branch pushed at 06:35Z) — but produced an orphan branch rather than a PR, because the probe script ran inside the same cloud-routine runtime that lacks gh CLI. This is useful data (the probe ran), but it proves that one-shot routines can silently reproduce the exact F2 failure mode they're testing for. Future probes that need a PR/merge signal should use `workflow_dispatch` of a GitHub Actions workflow, not a `/schedule` cloud routine.
2. **Probe evidence was 4 days old in Session #4.** Lesson absorbed: before propagating a blocker, check evidence age.
3. **Guardrail 7 design collided with real repo state on first run.** Count-before-filter is the wrong shape when branches are long-lived. Design lesson: for safety caps on filterable sets, count after filters, not before.

---

## User Preferences changes pending

- **`userMemories.recent_updates` line is wrong about PC paths.** See `canonical/logan-machine-state.md`. Needs Logan to edit in a Mastery Lab chat — CC cannot edit user memory directly. Current text claims `C:\Users\logan\Projects\` is deprecated; reality is Claudious canonical still lives there.

---

## Context snapshot

- Mastery Lab context at Session #5 close: ~70% used (rough).
- Claudious main branch tip at handoff time: `b8f64c9` (post-Phase 5 memory note).
- Open-decisions.md entry count: **41** (matches header).
- `canonical/logan-machine-state.md`: present.
- `.github/workflows/orphan-claude-branch-reconciler.yml`: present, active, hourly schedule engaged.
- Existing stash: `stash@{0}: On main: session-5-preflight-stash` (3 files, routine-output residue).
- Routines active: intake (6am CT), process (7am CT), curate (8pm CT), weekly health check (Sunday 8am CT). One-shot gh-availability-test probe has completed.
- New workflow active: orphan-claude-branch-reconciler (hourly).

---

## Session #6 opening move

1. Read this handoff.
2. Read the three overnight-queue investigation docs (if Phase C completed): `docs/investigations/2026-04-25-session-6-f1-phase-3-silent-skip.md`, `docs/investigations/2026-04-25-session-6-f3-auto-deploy-mirror.md`, `docs/investigations/2026-04-25-session-6-curate-orphan-check.md`.
3. Check `archive/reconciler-log/` for 7 days of tripwire entries. Is guardrail 7 still firing? Did orphan counts change?
4. Decide fix scope: F1 alone, F1+F3, or bundle with guardrail-7 retune + Curate extension.
5. Draft Session #6 fix prompt.
