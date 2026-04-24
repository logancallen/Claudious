# Session #6 investigation — F1: Phase 3 silently skipped in otherwise-successful Process runs

**Generated:** 2026-04-24 (overnight queue Phase C1)
**Status:** Read-only investigation. No fixes applied. Recommended next action at end.
**Builds on:** `docs/investigations/2026-04-24-process-regen-investigation.md` (Session #4) and Session #5 fix in PR #20.

---

## Scope

F1 is defined in the Session #4 investigation as:

> Phase 3 silently skipped in an otherwise successful Process run. Evidence: PR #4 file list omits `canonical/open-decisions.md` despite ledger entry showing `COMPLETE`.

Session #5 shipped a fix for F2/F4 (orphan branches) but explicitly left F1 for Session #6. This investigation reconstructs what happened on the 2026-04-20 04:24 Process run and ranks hypotheses for the silent skip.

---

## Evidence

### 1. Did PR #4's source branch ever touch `canonical/open-decisions.md`?

PR #4 was squash-merged on 2026-04-20T05:07:45Z and the source branch `claude/intelligent-lamport-oLzsB` was auto-deleted by `.github/workflows/auto-merge-claude.yml` (`--delete-branch` flag). The branch no longer exists on origin.

However, the merge commit (`8d31c5e`) preserves the full file manifest. Via `gh pr view 4 --json files`:

| Path | Type | Phase |
|---|---|---|
| `archive/proposals/claudemd-200-line-cap.md` | ADDED | Phase 1 (triage) |
| `archive/proposals/cowork-ga-desktop.md` | ADDED | Phase 1 |
| `archive/proposals/mcp-spec-oauth-2-1.md` | ADDED | Phase 1 |
| `archive/proposals/operating-model-5-parts.md` | ADDED | Phase 1 |
| `archive/queue/deployed.log` | MODIFIED | Phase 2 (deploy) |
| `archive/runs/2026-04-20.md` | MODIFIED | Section 6 (ledger) |
| `learnings/platforms/claude.md` | MODIFIED | Phase 2 (deploy) |
| `learnings/techniques.md` | MODIFIED | Phase 2 (deploy) |

**`canonical/open-decisions.md` is ABSENT from this 8-file list.** No commit on `claude/intelligent-lamport-oLzsB` touched it.

The PR's commit sequence (from `gh pr view 4 --json commits`):
1. `3645b2d` — `process: triage complete — 2 queue, 4 proposals` (Phase 1)
2. `49f10da` — `process: deployed 2 items` (Phase 2)
3. `e4806d7` — `process: 2026-04-20 verify complete` (Phase 4)

**There is no Phase 3 commit between commits 2 and 3.** The routine went Phase 1 → Phase 2 → Phase 4 → Section 5 commit, skipping Phase 3 entirely.

### 2. Comparison: 04:24 run (skipped) vs. 12:01 orphan run (executed)

| Attribute | 04:24 (PR #4, merged) | 12:01 (orphan `761e1ff`) |
|---|---|---|
| Source branch | `claude/intelligent-lamport-oLzsB` | `claude/intelligent-lamport-H43o6` |
| Time of day UTC | 04:28–04:30 (commit window) | 12:01 |
| Phase 1 output | 4 new proposals | 0 new proposals |
| Phase 2 output | 2 deployed | 0 deployed |
| Phase 3 output | **NONE (skipped)** | open-decisions 28→37 entries |
| Phase 4 output | verify 11 items | verify 10 items |
| Ledger emission of `open-decisions-regenerated=<yes\|no>` | NO (field absent) | YES (`=yes`) |
| PR opened | #4 (auto-merged) | None (orphan) |

Both ran on the same `scheduled-tasks/process.md` spec. Both were cloud-runtime routines. The differences:
- **Commit-message prefix:** 04:24 says `process: triage complete — 2 queue, 4 proposals` (work-focused narrative); 12:01 says `process: 2026-04-20 second-pass regen + verify` (phase-focused narrative).
- **Phase-3 adherence:** 04:24 skipped; 12:01 executed.
- **Ledger-field compliance:** the phase-focused run emitted the mandatory output field; the work-focused run omitted it.

This correlation is suggestive but not conclusive on a sample of 2.

### 3. Spec audit — any conditional that could skip Phase 3?

`scheduled-tasks/process.md:197-232` contains the Phase 3 block. The block is an unconditional `cat > "$OPEN"` regen followed by a `for f in archive/proposals/*.md; do ... done` loop. There is **no** `if`, no `continue`, no `[ "$X" = "Y" ] && ...` guard anywhere in Phase 3. The block runs whenever the routine's LLM executes that part of the prompt.

Section 0 (`process.md:23-27`) has the branch-guard abort, and COMPLETE_NO_WORK short-circuits Section 5's commit message, but neither of these touches Phase 3.

**Ruled out:** a conditional that deterministically skips Phase 3 in certain input states.

### 4. Diff-was-empty scenario ruled out

If Phase 3 had run but produced no diff, the commit step `git commit -m "..." || echo "nothing new"` would have gracefully fallen through — and the routine would still have emitted `open-decisions-regenerated=yes` (the diff state is measurable independent of whether a commit was produced).

But Phase 1 of this run ADDED 4 new proposal files. Had Phase 3 executed immediately after, it would have generated 4 new entries in `canonical/open-decisions.md` — a very-non-empty diff. The file would have been in the commit manifest.

**Ruled out:** no-op Phase 3 due to pre-existing file sync.

---

## Ranked hypotheses

### H1 (highest confidence) — LLM-level prompt skip during routine execution

The Process spec is 286+ lines. The cloud-routine LLM reading the spec executed Phase 1 (triage), Phase 2 (deploy), Phase 4 (verify), and Section 5 (commit+push) — but jumped over Phase 3's bash block. The commit messages narrate the work the LLM was aware of (triage, deploy, verify), and Phase 3 simply never entered the LLM's execution context.

**Supporting evidence:**
- Absence of any Phase 3 commit in the 3-commit sequence
- Absence of `open-decisions-regenerated=<yes|no>` field from the ledger (Section 6 of the spec explicitly requires it on every `outputs:` line — its absence is another symptom of the same skip)
- Same routine spec produced Phase 3 output on the 12:01 orphan run — so the LLM IS capable of executing it, just not consistently
- Newer cloud runs exhibit the same omission pattern intermittently (per Session #4 investigation Step (i) ledger-field audit)

**Counter-evidence:** none direct; this is a "silent failure" diagnosis by elimination.

### H2 — Runtime non-determinism / truncation

Cloud routines may have hidden step-budget or context limits. If the LLM approached a budget near Phase 3, the runtime may have truncated or skipped the block. This is a subtype of H1 with a specific cause.

**Supporting evidence:** the Process spec is long; Phase 3 is the longest single block (~36 lines of bash with heredocs and loops).

**Counter-evidence:** the 12:01 orphan run executed from the same spec and reached Phase 3 fine, suggesting budget isn't the universal bottleneck.

### H3 — First-pass vs. second-pass behavior

Ranked low. The investigation doc's reading is that 12:01 was a MANUAL second-pass fix, but there's no evidence 04:24 was a "first-pass that intentionally skips regen." The spec doesn't differentiate.

### H4 — Spec conditional skip

**Ruled out** (see Evidence section 3).

---

## Recommended next probe (do not draft; just name)

**A one-shot instrumentation routine** that runs a dry-run of the Process prompt with Phase-3 execution explicitly logged. The probe would:
- Execute the Process spec verbatim as a routine
- Add a pre-Phase-3 `echo "[PROBE] entering Phase 3"` and post-Phase-3 `echo "[PROBE] Phase 3 complete, wrote $OPEN with $(grep -c "^### " $OPEN) entries"` statement
- Commit the log output to `archive/tests/phase-3-execution-probe-YYYY-MM-DD.md`
- Verify whether the routine's LLM executes the instrumented block

If the probe's output shows `[PROBE] entering Phase 3` but no post-Phase-3 line, the LLM entered and aborted. If neither line appears, the LLM skipped the block entirely. Either result is actionable.

A complementary structural fix (independent of the probe): add an explicit Phase 3 assertion after the bash block:

```bash
COUNT_ON_DISK=$(ls archive/proposals/*.md 2>/dev/null | grep -v '\.gitkeep' | wc -l)
COUNT_IN_FILE=$(grep -c "^### " canonical/open-decisions.md)
if [ "$COUNT_ON_DISK" != "$COUNT_IN_FILE" ]; then
  echo "ERROR: Phase 3 assertion failed: disk=$COUNT_ON_DISK, file=$COUNT_IN_FILE" >&2
  # Emit to active-findings loudly
  exit 2
fi
```

This makes the silent skip loud — the routine's COMPLETE status would be replaced by a FAILED status visible in the ledger and briefing.

---

## Session #6 decision points

1. **Adopt the probe first, or ship the assertion first?** Probe gives root-cause evidence. Assertion is a defensive fix that works regardless of root cause. Recommendation: ship the assertion in Session #6 (cheap), run the probe in parallel (also cheap) to validate which hypothesis is correct.
2. **Scope:** same skip pattern likely affects F3 (mirror step) — bundle F1+F3 assertion fixes together to avoid two rounds on `scheduled-tasks/process.md`.
3. **Ledger-field enforcement:** the Session #4 investigation Step (i) recommendation stands — replace free-form `open-decisions-regenerated=<yes|no>` with a deterministic bash-computed value that is emitted regardless of whether Phase 3 ran. Absent field = guaranteed broken routine.
