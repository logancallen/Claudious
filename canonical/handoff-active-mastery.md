# Handoff — Mastery Lab

**Recommended next-chat title:** `2026-04-26 — MASTERY — Sunday Curate checkpoint + Session #7 scoping`

**From session:** 2026-04-25 (Session #6 fix draft + fix execution)
**To session:** 2026-04-26 (Sunday checkpoint + Session #7 scoping) → 2026-04-27 (Session #7 probe)
**Generated:** 2026-04-25 UTC (post Session #6 merges + observation start)
**Prior handoff archived:** `archive/handoffs/2026-04-25-MASTERY-session-6-fix-execution-complete.md`

---

## Current focus

Observation period for Session #6 fixes (4 merges + 1 observation commit landed 2026-04-25). Next chat = Sunday Curate checkpoint + Session #7 scoping. Session #7 proper (empirical probe of whether cloud-scheduled 8pm CT Curate is firing) fires Monday 2026-04-27, after one repo-settings action and the Sunday observation checkpoint.

---

## Completed — Session #6 (2026-04-25)

1. **Phase A — Guardrail-7 retune.** PR #25, merged `af995e0`. `.github/workflows/orphan-claude-branch-reconciler.yml`: MAX_ORPHANS now counts branches AFTER filtering (hand-named exclusion + merge-base age + routine-eligibility + regression check), not raw candidates. Manual verification run `24898422594` passed: 19 examined, 0 fail-close on guardrail 7.
2. **Phase B — Phase Z assertions + deterministic ledger.** PR #26, merged `51f9d34`. `scheduled-tasks/process.md` + `scheduled-tasks/intake.md`: Phase Z post-run assertion block added; `open-decisions-regenerated` and `canonical-mirrors` now deterministically bash-computed and emitted; commit+push gated on `status=COMPLETE`; Phase Z failures write loudly to `canonical/active-findings.md` instead of silently skipping.
3. **Phase C — Ownership consolidation.** PR #27, merged `e8b9e84`. `CLAUDE.md` Write-Authority Matrix: Curate is sole owner of `canonical/prompting-rules.md` and `canonical/antipatterns.md`. Process mirror sub-step removed from `scheduled-tasks/process.md`. Curate 4.3 citation definition tightened (three distinct entries across learnings files; same-file redeploys count as one).
4. **Phase D — Curate orphan absorption.** No edits, per session fence. Post-Phase-A reconciler confirmed to filter Curate `amazing-carson-*` branches correctly via guardrail 3.
5. **Session summary.** Observation start logged to `archive/runs/2026-04-24.md`, commit `d583eb9`.

**Phase Z assertion mirror to `scheduled-tasks/curate.md`:** ABSENT

---

## In-flight — Session #6 observation period

**Day 0 = 2026-04-25.** Watch over 7 days:

1. **Reconciler hourly runs stay clean.** No guardrail-7 fail-close (was fail-closing every run pre-Session-6). Watch `archive/reconciler-log/`.
2. **Process Phase Z assertions fire at least once.** Next scheduled 7am CT Process run will either pass Phase Z cleanly or fail loudly via `canonical/active-findings.md`. Either is a valid signal. Wait for 2 consecutive runs before drawing conclusions.
3. **Sunday Curate produces graduation signal.** Next Sunday Curate (2026-04-26 20:00 CT if cloud path is live) should produce either commits to `canonical/prompting-rules.md`/`antipatterns.md` OR an explicit `canonical-mirrors=0` ledger entry with "no candidates met 3-citation threshold" reason. Silence = Phase C regression signal.
4. **Reconciler auto-PRs orphan Curate skip-logs** once repo-setting fix lands (Pending #1).

---

## Pending for Logan (in priority order)

### 1. Repo setting fix — GitHub Actions PR permission (URGENT, 30 seconds)

**Action:** GitHub → repo Settings → Actions → General → Workflow permissions → enable "Allow GitHub Actions to create and approve pull requests".

**Why urgent:** Reconciler (PR #25's revised guardrail-7 logic) correctly identifies eligible orphans post-filter but is blocked on `pulls.create` API call. Two branches currently blocked: `claude/amazing-carson-2drec`, `claude/intelligent-lamport-4X8rU`.

**Cross-check against Session #5:** Session #5's probe verdict was `gh-blocked` (cloud runtime lacks `gh` CLI). This finding suggests some routine PR-creation failures may be attributable to the repo permission setting, not just `gh` absence. The two failure modes may overlap and need disentangling in Session #7 design.

**Gate:** Session #7 empirical probe should be designed AFTER this setting is flipped. Otherwise the probe will show false negatives on any routine that tries to open a PR.

### 2. Sunday Curate observation checkpoint — 2026-04-26/2026-04-27

After next Sunday (2026-04-26 20:00 CT) Curate run, inspect:

- `archive/digest/2026-04-26.md` — does it exist? Does it include a `canonical-mirrors=X` ledger field?
- `git log origin/main --since=2026-04-26 -- canonical/prompting-rules.md canonical/antipatterns.md` — any graduation commits?
- Phase Z assertions were NOT mirrored to `scheduled-tasks/curate.md` in Session #6. A silent Sunday cannot distinguish "fire-and-4.3-skip" from "did not fire at all" — both look identical. Session #7 probe scope must account for this ambiguity. Option: add Phase Z to curate.md as part of Session #7 prep, or accept ambiguity and design the probe to disentangle via runtime heartbeat/log signals.

**Outcome branches:**
- **PASS** (graduation commits OR ledger shows 0 with clear reason): Phase C holds. Session #7 probes only cloud-Curate-firing question.
- **FAIL** (silent — no digest, no ledger, no graduation, no assertion trip): Phase C regresses the mirror. Two sub-hypotheses:
  - (a) Cloud Curate never ran on Sunday (pre-existing hypothesis Session #7 is designed to test).
  - (b) Cloud Curate ran but step 4.3 still silently skips, same root cause as F1/F3 pre-fix.
- Session #7 scope expands accordingly; handoff for Session #7 should reserve scope for a Phase C revert-or-extend decision.

### 3. Session #5 PC preflight stash evaluation — next PC session

Deferred from Session #6 because Session #6 ran on Mac. Commands on PC:

```powershell
cd C:\Users\logan\Projects\Claudious
git stash list
git stash show --stat session-5-preflight-stash
git stash show -p session-5-preflight-stash
```

Decision rule (established in prior Mastery Lab chat): pure appends + content already on main → drop. Any deletion, modification to existing content, or novel un-landed work → flag before dropping.

### 4. ASF handoff WIP — parked branch

Branch `asf/wip-handoff-2026-04-23` holds two files staged during Session #6 preflight park: `canonical/handoff-active-asf.md` (modified) and `archive/handoffs/2026-04-23-ASF-1628.md` (new). Resume in next ASF session. Not Mastery Lab scope.

### 5. Mastery Lab project spec UI update — 30 seconds

Pending from pre-Session-5. Claude.ai UI action: Mastery Lab project → Settings / Instructions → update Claude Projects count to 7 and note Claudious is a GitHub repo only, not a Claude Project.

---

## Session #7 scope — cloud-routine empirical probe

**Primary question:** Is the 8pm CT cloud-scheduled Curate routine actually firing?

**Why it matters:** All observed Curate branches in the 7-day pre-Session-6 window (`amazing-carson-*`) are `logancallen`-authored, not `claude`-bot-authored. If cloud Curate is silently dead, the entire 4.3 graduation path (now sole owner per Phase C) is a paper contract.

**Probe design constraints (do not draft in Mastery Lab — draft in Session #7 chat):**

1. **Preflight:** repo setting fix (Pending #1) must be confirmed enabled. Otherwise PR-creation failures will confound the firing signal.
2. **Observation, not intervention:** probe watches scheduled runs; does not invoke manually.
3. **3-observation window:** wait for 3 scheduled cycles (2-3 days) before drawing conclusions.
4. **Disentangle from repo-permission issue:** a failed PR open is NOT the same signal as a routine that didn't fire. Log both separately.

**Deliverables:**
- `docs/investigations/2026-04-27-session-7-cloud-curate-firing.md` (read-only investigation, same format as Session #6 investigations)
- Session #7 fix scope recommendation based on findings
- If Phase C regression confirmed (Sunday checkpoint): scope for revert or extend

**Tentative Session #7 titles:**
- If cloud Curate NOT firing + Phase C holding: `2026-04-27 — CLAUDIOUS — Session #7 restore cloud Curate scheduling`
- If cloud Curate firing but 4.3 silently skipping: `2026-04-27 — CLAUDIOUS — Session #7 Curate Phase Z pattern`
- If Phase C regressing (no Sunday graduation, cloud dead): `2026-04-27 — MASTERY — Session #7 rescope for Phase C revert`

---

## Deferred items (carry-forward)

1. **Hook-not-firing-cross-chat** (Session #4 Question 0). No `🫀 lama` or `[HB] lama` preflight line observed. Independent investigation slot.
2. **ASF PR #1 merge decision.** Routes through ASF handoff.
3. **PWA implementation for ASF Graphics** (staged chat).
4. **`sync-knowledge.sh` live run.** Manual session, not CC.
5. **Scout routing clarification** (standalone vs folded into Intake/Process). Low priority.
6. **Codex CLI integration audit.** ChatGPT proposed a scripts + skill pattern on 2026-04-25. Conclusion: keep existing plugin-based `/codex:review`; do not add parallel script system without audit. Queue as own chat when scoped.

---

## Decisions made with reasoning — Session #6

1. **Approach (c) Phase Z + (b) ledger, not (a) prompt restructure.** Phase Z assertion reads ledger + disk state; catches skipped phases even when the skipped phase can't self-report. Prompt-restructure (a) is correct long-term but multi-session; Z+ledger ships the bleeding-stop now.
2. **Curate owns graduation; Process does not mirror.** Per F3 investigation: shared write authority was producing no-ownership no-op. Graduation semantics (3+ citations, delayed) are a curation decision, not a per-deploy processing decision. Queue file evidence corroborated.
3. **Phase D = leave as-is, no filter.** 3 skip-log commits/week is low-cost diagnostic noise. Pre-filter would hide the Curate-skip signal. Per Session #6 handoff explicit recommendation.
4. **Executed on Mac, not PC, despite PC being the prompt's stated target.** Session #6 work is OS-agnostic (YAML + markdown + git). Reconciler was fail-closing hourly; machine-hop delay was more expensive than deviating. Session #5 stash eval stays deferred to next PC session.
5. **ASF handoff WIP parked to `asf/wip-handoff-2026-04-23`, not stashed.** Mac stash avoidance rule: stashes are for accidental dirtiness, not deliberate WIP. Named branches for deliberate work.

---

## Frustration signals / lessons — Session #6

1. **Repo-permission blocker would not have been caught by Phase A code alone.** Even with guardrail-7 retuned correctly, PR creation fails silently at the API layer. **Lesson:** when a workflow depends on a permission or setting outside the code it controls, that dependency must be surfaced at write time — either as a preflight check at the top of the workflow (read org/repo settings and fail fast) or as a documented setup step in the workflow's README.
2. **Cross-model diagnosis from Session #5 may overlap new finding.** The `gh-blocked` verdict and the missing repo-permission setting both produce the symptom "routine can't create PRs." Session #7 design must distinguish empirically — one test at a time, not bundled.
3. **"Doc wins" authority rule continues to pay off.** Phase B's assertion structure was informed by F1/F3 investigation docs, not Logan's opening prompt position. Mastery Lab default: when an investigation doc disagrees with a prompt's proposed approach, prefer the doc.

---

## User Preferences changes pending

None from Session #6.

**Candidates for future consideration:**

1. Add rule: when a GitHub workflow is authored, include a preflight permission check that fails fast with a surfaced error if required repo settings (workflow permissions, Actions enablement, branch protections) don't match the workflow's assumptions.
2. Archive filename convention drift: User Prefs says `archive/handoffs/YYYY-MM-DD-HHMM.md`; actual repo uses `YYYY-MM-DD-PROJECT-descriptor.md`. Update Preferences to reflect drift, or re-enforce the original.

---

## Files changed this handoff commit

- `canonical/handoff-active-mastery.md` (overwritten — this file)
- `archive/handoffs/2026-04-25-MASTERY-session-6-fix-execution-complete.md` (new archive)
- `canonical/handoff-index.md` (date bump, separate commit if needed)

---

## Immediate next actions for next chat

1. **Logan flips the repo setting** (30 seconds) — Pending #1.
2. Confirm reconciler auto-PRs the two currently-blocked eligible orphans on next hourly cron.
3. Observe Sunday Curate (2026-04-26 20:00 CT) per Pending #2.
4. Scope Session #7 based on Sunday outcome + repo-setting-flip outcome.

---

## END OF HANDOFF
