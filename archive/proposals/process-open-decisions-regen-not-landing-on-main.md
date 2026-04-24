# Proposal — Process Phase 3 regen of open-decisions.md never lands on main

**Source:** Session #3 Part B diagnostic; `canonical/active-findings.md` 2026-04-23-open-decisions-regen-stale
**Impact:** MEDIUM (phone-readable briefing + Logan's weekly review pipeline are blind to proposals added after 2026-04-17 until manual patch)
**Effort:** M (need to audit the Process routine's branch/PR workflow in cloud execution)
**Risk:** TEST-FIRST
**Routing reason:** Changes routine behavior around branch/PR handling; not a SAFE+HIGH+TRIVIAL md-only change → PROPOSAL

## Finding

Between 2026-04-17 seed commit (`cc3fc9d`) and 2026-04-23:
- `archive/proposals/*.md` grew from ~28 to 40 entries.
- Multiple Process runs completed with `process [COMPLETE]` status.
- `canonical/open-decisions.md` was never re-written on main. `git log canonical/open-decisions.md` returns a single commit (the seed).
- 2026-04-20 ledger explicitly says `branch-note: developed on claude/intelligent-lamport-oLzsB per task assignment; PR to main to follow`. No follow-up merge commit on main touches `canonical/open-decisions.md`.
- Ledger `outputs:` line for Process does not include the spec-required `open-decisions-regenerated=<yes|no>` field, so this bug was invisible to self-audit.

## Hypothesis

One of:
1. **PR never merged.** Routine pushes to a per-session `claude/<slug>` branch and opens a PR; the auto-merge workflow wasn't wired at the time (or required human merge); regen rots on the branch.
2. **Phase 3 skipped when triage added no new queue items.** Phase 3 is a full regen from `archive/proposals/*.md`, so it should run regardless of queue churn — but a guard may be short-circuiting it.
3. **Commit step doesn't `git add canonical/` when the only change was in that directory.** Less likely given `git add -A` is the pattern.

## Proposed action

1. Audit a real cloud Process run (next scheduled 07:00) end-to-end:
   - Capture the PR URL/branch name the routine opens.
   - Confirm the auto-merge workflow merges it to main.
   - Confirm the merge commit touches `canonical/open-decisions.md`.
2. If (1) fails, fix the routine:
   - Add an explicit `open-decisions-regenerated=yes|no` field to the ledger `outputs:` line so the bug becomes self-evident.
   - Verify `.github/workflows/auto-merge-claude.yml` covers the branch pattern the Process routine uses. (We know `claude/` prefix is covered; confirm the routine actually prefixes.)
3. Manually run the regen via CC on-demand between audits so the briefing stays honest until the routine-side fix lands.

## Verification after deploy

Next Process run after the fix should: produce a `process [COMPLETE]` ledger entry with `open-decisions-regenerated=yes`, AND `git log -1 canonical/open-decisions.md` should show a fresh commit dated that day's Process run.

## Rollback

No code change yet — proposal only. When the fix ships, rollback is `git revert <sha>` of the routine-prompt edit.
