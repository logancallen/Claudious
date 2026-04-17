# Claudious v2 — Scheduled Tasks (CC Routines)

3-task daily system replacing the v1 Cowork 8-task setup. Runs in Claude Code Routines with real filesystem + auto-merged PRs.

## Tasks

| Task | Schedule | File |
|---|---|---|
| Intake | Daily 6:00 AM | `intake.md` |
| Process | Daily 7:00 AM | `process.md` |
| Curate | Daily 8:00 PM | `curate.md` |

Dependencies: Process requires Intake `COMPLETE` or `COMPLETE_NO_WORK`. Curate requires both.

## Deployment

1. Open `claude.ai/code/routines`
2. Click "Create routine" for each task
3. Paste contents of the respective `.md` file as the routine prompt
4. Set schedule (daily at the time above)
5. Attach the Claudious repo
6. Enable the GitHub connector

PRs on branches starting with `claude/` auto-merge via `.github/workflows/auto-merge-claude.yml`.

## First-run validation

### Day 1 (first daily cycle)
- `runs/YYYY-MM-DD.md` has 3 entries (intake, process, curate)
- All 3 show `COMPLETE` or `COMPLETE_NO_WORK`

### First Sunday
- Curate writes `Status: DEFERRED - bootstrapping` in the retrospective (< 7 days of ledger history)

### Week 2 Sunday
- Real retrospective with graduations, prunes, and grade

## Status taxonomy

Every task returns one of:
- `COMPLETE` — work completed successfully
- `COMPLETE_NO_WORK` — nothing to do (no findings, already ran, empty intake)
- `DEPENDENCY_NOT_SATISFIED` — upstream task didn't finish
- `ABORT` — environment invariant violated (dirty tree, wrong branch, pull failed)
- `IN_PROGRESS` — written first, replaced on completion; if left in place, indicates mid-run timeout
