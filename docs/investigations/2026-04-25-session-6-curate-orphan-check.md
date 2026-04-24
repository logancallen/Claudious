# Session #6 investigation — Curate orphan risk empirical check

**Generated:** 2026-04-24 (overnight queue Phase C3)
**Status:** Read-only investigation. No fixes applied. Recommended next action at end.
**Purpose:** Determine whether Curate needs the same F2/F4-equivalent fix that Session #5 (PR #20) shipped for Process/Intake.

---

## Methodology

Curate's cloud-routine slug prefix is `claude/amazing-carson-*` (observed consistently across 2026-04-17 onward). This investigation enumerates all such branches on `origin`, checks merge status, inspects content, and compares the orphan rate to Process/Intake.

---

## Curate orphan inventory (2026-04-17 → 2026-04-24)

| Branch | Tip date (UTC) | Author | Commit subject | Ancestor-of-main? | PR opened? |
|---|---|---|---|---|---|
| `claude/amazing-carson-slCQE` | 2026-04-20 04:50 | `logancallen` | `curate: skipped, deps not ready — 2026-04-20 04:48` | No | #3 (CLOSED, unmerged) |
| `claude/amazing-carson-e8muI` | 2026-04-20 ~05:31 | `logancallen` | `curate: daily digest 2026-04-20` | **Yes (PR #5 merged)** | #5 (MERGED) |
| `claude/amazing-carson-Ck39v` | 2026-04-21 01:23 | `logancallen` | `curate: skipped, deps not ready (2026-04-21)` | No | **None** |
| `claude/amazing-carson-2drec` | 2026-04-23 01:11 | `logancallen` | `curate: skipped, deps not ready` | No | **None** |
| `claude/amazing-carson-XXLz5` | 2026-04-24 01:04 | `logancallen` | `curate: skipped, deps not ready` | No | **None** |

Summary:
- **5 Curate-slug branches** pushed to origin in the 7-day window
- **1 merged** (PR #5, the 2026-04-20 05:31 deps-ready run)
- **1 explicit close** (PR #3, the 2026-04-20 04:48 deps-not-ready run — PR opened, deliberately closed)
- **3 silent orphans** (deps-not-ready runs, no PR ever opened)

---

## Content inspection — what do the orphans actually contain?

```
$ git show origin/claude/amazing-carson-2drec --stat
archive/runs/2026-04-23.md | 5 +++++
```

```
$ git show origin/claude/amazing-carson-XXLz5 --stat
archive/runs/2026-04-24.md | 5 +++++
```

```
$ git show origin/claude/amazing-carson-Ck39v --format='%B'
curate: skipped, deps not ready (2026-04-21)

Curate ran at 01:21 UTC, before the 6am intake and 7am process windows.
Status: DEPENDENCY_NOT_SATISFIED (intake=missing, process=missing).
BROKEN brief written so email pipeline does not go dark.
```

All three silent orphans contain **only** a 5-line log entry to `archive/runs/YYYY-MM-DD.md` — a dependency-not-satisfied marker. None touch canonical files.

This is in contrast to the Process orphan `761e1ff` (Session #4 smoking gun) which carried a full `canonical/open-decisions.md` regen (28→37 entries) — i.e., real canonical work that never landed.

---

## Authorship pattern — surprising finding

**All Curate branches (orphans and merged) are authored by `logancallen <loganallensf@gmail.com>`, not the `claude` bot.**

Cross-check:
- Process PR #4 commits: authored by `claude <noreply@anthropic.com>` — the cloud routine committed as the bot
- Process orphan `761e1ff`: authored by `logancallen` — a Logan-local invocation, NOT the cloud routine
- Probe commit `50114da`: authored by `Claude` — the cloud routine

**Implication:** Curate's cloud-scheduled 8pm run path may not have run at all in the window 2026-04-20 → 2026-04-24. Every Curate-slug branch in this window appears to be a Logan-local invocation (his laptop fired Curate from a CC terminal, which created the session-slug branch and pushed without opening a PR).

This subtly changes the Session #4 orphan-failure interpretation: at least some of the "orphan branch commits from cloud routines" are actually **orphan branch commits from Logan's local routine invocations.** Same orphan-failure mechanism (commit lands on session branch, no PR opens), but different cause (local CC runtime doesn't call `gh pr create` — same limitation as cloud runtime per the gh-availability probe on 2026-04-24).

---

## Orphan rate comparison

| Routine | Runs in window | Merged to main | Orphaned (silent) | Orphan rate |
|---|---|---|---|---|
| Process | ~5 (estimated from ledger + orphans) | 2 (PR #4, PR #17) | ~2 (761e1ff + at least one Intake-pensive) | ~40% |
| Intake | ~5 (estimated) | 1 (direct-push 2026-04-20) | 2 (pensive-gates-urwlm, -BAetU) | ~40–50% |
| Curate | 5 | 1 (PR #5) + 1 closed-deliberately | 3 silent | ~60% |

Curate's raw orphan rate is highest, BUT **every Curate orphan contains only benign skip-log content**, whereas Process/Intake orphans carry real canonical writes.

---

## Does Curate have the same failure mode as Process/Intake (F2)?

**Yes, structurally** — the same "session branch pushed, no PR opened" mechanism is happening.

**No, operationally** — the blast radius is zero because Curate's Section 0 dependency-check short-circuits the routine's canonical writes before they would have been produced. The runtime gate is:

1. Check `archive/intake/${TODAY}.md` exists + `archive/runs/${TODAY}.md` has a `process [COMPLETE]` entry
2. If either missing → write DEPENDENCY_NOT_SATISFIED entry to `archive/runs/${TODAY}.md` + BROKEN briefing → exit
3. Only if both present → proceed to canonical pruning, digest, prompting-rules/antipatterns graduation

On early-morning local Curate invocations (the only kind currently producing orphans), step 1 fails, step 2 logs the skip, and the routine exits before writing canonical files. The orphan branch only ever contains the step-2 log. No canonical drift accumulates.

---

## Implication for Session #5 reconciler workflow (PR #20)

The reconciler's Guardrail 3 (routine-eligibility — HEAD message `[routine]` OR slug pattern `^claude/[a-z]+-[a-z]+-[A-Za-z0-9]{5}$`) would classify `amazing-carson-*` branches as eligible (slug pattern matches). Guardrail 1 (merge-base age ≤ 2 days) would let recent ones through.

**If Session #5's reconciler clears its guardrail-7 (max-orphans) hurdle, it WILL auto-PR these Curate skip-log orphans.** This would produce squash-merge commits to main that add `archive/runs/YYYY-MM-DD.md` skip entries — harmless but noisy (3 extra commits in the window examined).

Two possible responses:
1. **Accept the noise.** Skip logs on main are useful breadcrumbs — they prove Curate attempted to run.
2. **Add a content filter** to the reconciler: skip branches whose only change is a "skipped, deps not ready" log entry. Adds complexity; value is dubious given 1.

Recommendation: accept the noise. The skip entries are small and carry diagnostic value.

---

## Ranked hypotheses for Curate's high orphan rate

### H1 (highest confidence) — Curate runs are mostly local, not cloud-scheduled

The 8pm CT cloud-scheduled run path is the one that should auto-PR + merge. The `logancallen` authorship on all branches suggests cloud-scheduled Curate runs have not executed in the observed window — only Logan's manual CC-terminal fires. Those use the same runtime that lacks `gh` CLI (proven by the Session #5 probe), so they orphan.

**Supporting evidence:**
- Zero `claude` bot-authored Curate commits in the window
- Logan has demonstrably been in CC sessions daily (per handoff timestamps)
- PR #3 (the 2026-04-20 04:48 manual curate) was deliberately CLOSED, which requires a human act — consistent with Logan manually invoking the routine to clear a local issue

### H2 — Cloud-scheduled Curate IS running but its branches are immediately cleaned up

Low confidence. If cloud Curate ran and auto-merged via PR, we'd see bot-authored commits on main under auto-merge-claude.yml's squash pattern. Nothing in recent main history matches that signature for curate.

### H3 — Curate's `DEPENDENCY_NOT_SATISFIED` path is triggering falsely on cloud runs

If the cloud runtime's 8pm Curate is seeing Intake/Process as "missing" (perhaps due to branch-isolation inside the runtime), it would skip-and-log exactly like we observe. The cloud run would still produce a `claude/amazing-carson-*` branch but its commit would say `curate: skipped, deps not ready` — matching the orphan pattern.

This hypothesis could be confirmed by looking at the author field on a scheduled-cron Curate run, if any exists. We have no such evidence in the window — either cloud Curate never ran, or its runs were manually re-invoked by Logan and the cloud-attempt evidence was overwritten.

---

## Session #6 decision points

1. **Extend Session #5's Option 3b reconciler to auto-merge Curate orphans?** Yes — the mechanism already matches. Just ensure reconciler's MAX_ORPHANS retune (from handoff's Open Issue) lands first.
2. **Investigate whether cloud-scheduled Curate is actually running?** Yes — separate probe. Check the Claude routines UI for the last "succeeded" Curate run timestamp. If the last success is more than a few days old, cloud Curate is silently failing (a distinct F5-class issue, not F2/F4).
3. **Does Curate need the same routine-spec changes Process/Intake will get for F1/F3?** Probably not — Curate's Section 0 dep-check is structurally different from Process's Phase 3 skip pattern. But if the F1/F3 investigation probe uncovers a generic "LLM skips deep sub-steps" root cause, Curate's own sub-steps (graduation to prompting-rules, pruning) may be affected too.

---

## Recommended next probe

**A one-shot cloud-scheduled Curate monitor** — a GitHub Actions workflow or `/schedule` routine that runs at 21:00 CT (after the scheduled 20:00 CT Curate) and checks:

- Did `canonical/briefing-today.md` get rewritten in the last 2 hours?
- Did `archive/digest/YYYY-MM-DD.md` get created?
- Did main receive a commit authored by the `claude` bot with prefix `curate:` in the last 2 hours?

If all three are NO for 3+ consecutive days, cloud Curate is down. That's a Session #7 scope item, not Session #6.
