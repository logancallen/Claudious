# Handoff — Mastery Lab

**Recommended next-chat title:** `2026-04-24 — MASTERY — Process Fix Session 5`

**From session:** 2026-04-23 PM (Session #4, Process regen investigation)
**To session:** 2026-04-24 (Session #5, fix implementation)
**Generated:** 2026-04-24 UTC
**Prior handoff archived:** archive/handoffs/2026-04-24-0611-mastery-pre-session-4.md

---

## Current focus

Closing the Process regen silent-failure loop identified in Session #4. Investigation (PR #19, commit 7fdad89 on main) documented the hypothesis, confirmed it, and expanded scope to 4 canonical files + Intake. A runtime probe (routine `gh-availability-test`, trigger `trig_013rpTZodtU27KemLFsUCXut`) was fired just before this handoff generated to decide Session #5's fix path: Option 2 (routine self-PRs in Section 5) vs Option 3b (orphan-branch reconciler workflow).

**Session #5's job:** read probe verdict + paste F1–F5 taxonomy and Step (g)/(h) details from the investigation doc, then draft the fix prompt matching the verdict.

---

## Completed items

1. **Session #4 investigation PR #19 merged.** Branch `claude/process-regen-investigation`, squash commit `7fdad89`. Doc at `docs/investigations/2026-04-24-process-regen-investigation.md`, 495 lines.
2. **Hypothesis confirmed and expanded.** Five distinct failure modes (F1–F5) cataloged. Blast radius is 4 canonical files (`open-decisions.md`, `active-findings.md`, `claude-state.md`, `claude-code-state.md`), not 1. Intake shares the failure mode — fix cannot be Process-specific.
3. **Option 2 rejected in investigation doc based on 2026-04-20 "gh blocked" evidence.** Pre-mortem in Session #4 chat flagged this rejection as 4-day-old data and needed retest.
4. **Probe routine created (gh-availability-test, trig_013rpTZodtU27KemLFsUCXut).** Fires 2026-04-24T06:13:00Z, Opus 4.7, Default env matching Intake/Process/Curate, no connectors, `allow_unrestricted_git_push: true` matched to production routines. Link: https://claude.ai/code/routines/trig_013rpTZodtU27KemLFsUCXut
5. **Backfill CC prompt drafted** at `/mnt/user-data/outputs/cc-prompt-05b-manual-phase3-regen-backfill.md` (unsent). Fix-independent. Not executed. Delta pre-run expected: 1 missing entry (`process-open-decisions-regen-not-landing-on-main`). Delta gate: abort if >3 missing entries found at runtime.
6. **Drift already partially healed by PR #18 (2026-04-23).** Current delta reduced from 12 → 1 entry.

---

## In-flight items

1. **Probe execution.** Fires ~06:13Z 2026-04-24. Results will populate `archive/tests/gh-availability-2026-04-24.md` and a PR. Verdict block is the primary artifact — `verdict=option-2-viable` or `verdict=option-3b-required`.
2. **Handoff generation.** This file.

---

## Pending items (for Session #5, in order)

### Immediate next actions for Session #5

1. **Read probe verdict.** Fetch `archive/tests/gh-availability-2026-04-24.md` from main. Parse the verdict block. Branch from there.
2. **Ask Logan for three investigation-doc excerpts** (still not in project knowledge via RAG as of Session #4 close):
   - F1–F5 taxonomy with full definitions
   - Step (g) Option 3b detail (cron interval, PR creation mechanism, labels/checks, handling of branches older than N days)
   - Step (h) revised surgical backfill plan (exact missing-entry identity and regen approach)
3. **Memory path decision.** `userMemories` says canonical Windows path is `Documents\GitHub\Claudious`. Session #4 CC confirmed actual path is `Projects\Claudious`. Either update memory or commit to a migration session. Don't silently keep both.
4. **Draft Session #5 fix CC prompt** matching probe verdict (see "Skeletons" below).
5. **Decide on 5B backfill prompt timing.** Safe to run now (fix-independent) or hold until fix lands. Recommend run after fix ships — cleaner audit trail.

### Session #5 prompt skeletons (draft mode only — fill in at session time)

**If `verdict=option-2-viable`:**
- ~150-line CC prompt
- Edits `scheduled-tasks/process.md` Section 5 to add `gh pr create` + `gh pr merge --auto --squash` after the current `git push origin main` flow
- Mirrors same edit to `scheduled-tasks/intake.md`
- Adds ledger field `open-decisions-regenerated=<yes|no>` enforcement note
- Tests with one manual routine fire per routine
- Branch: `claude/process-and-intake-self-pr`
- Risk: Curate may need the same treatment — investigate whether Curate also silently orphans

**If `verdict=option-3b-required`:**
- ~300-line CC prompt
- Creates `.github/workflows/orphan-claude-branch-reconciler.yml`
- Cron: every 6 hours (not the earlier 4-hour guess — no basis)
- Seven guardrails from Session #4 pre-mortem:
  1. Merge-base age bound (skip branches where merge-base with origin/main > 2 days old)
  2. Diff regression check (skip branches that would revert any file touched since branch was cut)
  3. Routine-eligibility tag (only PR branches with `[routine]` commit-message marker)
  4. Tripwire status marker (writes WORKING / FAILED to `archive/reconciler-log/YYYY-MM-DD.md`)
  5. PR description template with audit trail
  6. Daily summary to `canonical/briefing-today.md` if any orphans processed
  7. Cap at max 10 orphans per run (prevents runaway merges if detection logic misfires)
- Branch: `claude/orphan-reconciler-workflow`
- Risk: workflow itself becomes an automation that can fail silently — tripwire is the counter

### Session #6 (deferred — do not draft in Session #5)

**Scope:** Failure mode #2 from Session #4 investigation — Process's merged runs silently skipping Phase 3 entirely (PR #4 merged but skipped regen; orphan 761e1ff did the work).

Neither Option 2 nor Option 3b addresses this. Needs a post-condition check or execution-verification step inside Process's spec. Schedule after Session #5 fix lands + 1 week of reconciler/self-PR observation data.

---

## Deferred items

1. **Hook-not-firing-cross-chat (Session #4 Question 0).** No `🫀 lama` or `[HB] lama` preflight line observed at Session #4 start. Separate investigation slot — not folded into Process regen work. Owner: TBD.
2. **ASF PR #1 merge decision.** Mentioned in Session #4 kickoff, unresolved. Routes through ASF handoff, not Mastery.
3. **Mastery Lab project spec update (7 Projects).** 30-second UI action still pending from prior sessions.
4. **Scout routing clarification** (standalone vs folded into Intake/Process).
5. **PWA implementation for ASF Graphics** (`2026-04-20 — ASF — PWA Implementation` staged chat).

---

## Unresolved questions

1. Does probe step 3 (MCP github tools introspection) return a real count or `unknown`? If `unknown`, don't treat as failure — verdict depends on gh + git lines only.
2. Does the probe's `git push origin HEAD` succeed to a non-claude-prefixed branch because of `allow_unrestricted_git_push: true`? If yes, the auto-merge-claude.yml prefix assumption needs revisiting.
3. Does `/schedule` in CC CLI accept a clean one-off-in-future timestamp, or does it require recurring cadence + manual delete after? Low-value question; answered for this probe regardless.

---

## Decisions made this session

1. **Retest Option 2 before committing to 3b.** Pre-mortem caught a 4-day-old rejection being accepted without retest. Confidence HIGH. Probe fires 06:13Z.
2. **Two-prompt Session #5 structure (5A probe, 5B backfill) rather than one monolithic fix prompt.** Probe and backfill are independent and parallel-safe. Confidence HIGH.
3. **Session #6 explicitly carved out for Phase-3-silently-skipped failure mode.** Neither Session #5 fix option addresses it. Don't merge into #5 scope. Confidence HIGH.
4. **Model: Opus 4.7 for probe** (not Sonnet 4.6). Probe's verdict block needs literalism Sonnet may paraphrase. Confidence MED-HIGH (educated guess; Sonnet would likely have worked).
5. **Env: Default** matching production routines. Confirmed by CC before firing. Confidence HIGH.
6. **Cron interval for hypothetical 3b workflow: every 6 hours** (not 4 as earlier sketch). Aligns with routine cadence — Process runs daily, orphans can't accumulate faster than that. Confidence MED.

---

## Files recently changed this session

Session #4 investigation branch (merged to main):
- `7fdad89` — investigation: process regen silent-failure diagnosis (squash merge of PR #19 / `claude/process-regen-investigation` / investigation doc SHA `ba0c5a2` on branch)

Session #4 drafted but unsent (live at `/mnt/user-data/outputs/` on the chat):
- `routine-05a-gh-availability-probe.md` — probe body, superseded by inline paste into `/schedule` creation flow
- `cc-prompt-05b-manual-phase3-regen-backfill.md` — surgical backfill prompt, unsent

Routine created (external to repo):
- `gh-availability-test` / `trig_013rpTZodtU27KemLFsUCXut` — one-shot, fires 06:13Z 2026-04-24

Expected commits in next ~30 min (probe-driven):
- `archive/tests/gh-availability-2026-04-24.md` — probe output
- Probe PR (auto-merge if gh works, left as evidence if gh blocked)

---

## Frustration signals (do not repeat)

1. **Pattern-matched on CC's recommendation without retest.** Session #4 chat accepted the "Option 2 rejected" finding based on 4-day-old handoff evidence. Should have flagged for retest immediately, not caught in pre-mortem. Rule for Session #5: when CC rejects an option, check the age of the rejection evidence before propagating.
2. **Answered "no, CC can't create routines" based on pattern-matching.** Reality: `/schedule` in CC CLI creates routines conversationally. Same class of error as #1. Rule: before answering a CC-capability question confidently, verify against current docs (Claude Code docs, routines page).
3. **Referenced file "05A probe body" by name instead of pasting contents.** CC correctly refused to guess. Rule: when handing CC a prompt body, paste literal text, never a filename reference.
4. **Probe prompt initially called for routine name setup via web UI, updated mid-session to /schedule.** Version discipline — don't leave stale instructions in context when revised.

---

## User Preferences changes pending

None from this session. Noted earlier (not added): possible new rule about "re-test rejections older than N days before propagating" — but this is adequately covered by "State the strongest counterargument before any recommendation." No preference edit needed.

---

## Context snapshot

- Mastery Lab chat context at Session #4 close: ~68% used.
- Claudious main branch tip: 7fdad89 at Session #4 investigation merge; may have advanced by probe run time.
- Open-decisions.md total-open header: still shows pre-backfill count (1-entry delta unresolved; backfill prompt unsent).
- Routines active: intake (6am CT), process (7am CT), curate (8pm CT), weekly health check (Sunday 8am CT), gh-availability-test (one-shot 06:13Z 2026-04-24).

---

## Session #5 opening move

1. Read this handoff.
2. Fetch `archive/tests/gh-availability-2026-04-24.md` from main. If not present, the probe hasn't fired or failed — diagnose before drafting fix.
3. Ask Logan for F1–F5 taxonomy + Step (g)/(h) excerpts from investigation doc.
4. Ask Logan for memory-path decision.
5. Draft fix prompt per verdict branch (skeletons above).
6. Draft 5B backfill prompt for parallel execution (already ~90% drafted at `/mnt/user-data/outputs/cc-prompt-05b-manual-phase3-regen-backfill.md`).
