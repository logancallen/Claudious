# Session #6 investigation — F3: Auto-deploy mirror to `prompting-rules.md` / `antipatterns.md` never fires

**Generated:** 2026-04-24 (overnight queue Phase C2)
**Status:** Read-only investigation. No fixes applied. Recommended next action at end.
**Builds on:** `docs/investigations/2026-04-24-process-regen-investigation.md` Key Observation O-1.

---

## Scope

F3 is defined in the Session #4 investigation as:

> Auto-deploy mirror step to `prompting-rules.md` / `antipatterns.md` never runs. Zero commits to these files on any branch despite Process runs with deployed items.

This investigation confirms F3 is still true as of 2026-04-24 and maps the mechanism that was supposed to write these files.

---

## F3 status — confirmed still true

```
$ git log origin/main --oneline -- canonical/prompting-rules.md
2fcc376 routing: 2026-04-23 three-way synthesis refresh post-GPT-5.5 launch (#16)
cc3fc9d canonical: seed 9 signal-dense files from existing sources

$ git log origin/main --oneline -- canonical/antipatterns.md
2fcc376 routing: 2026-04-23 three-way synthesis refresh post-GPT-5.5 launch (#16)
cc3fc9d canonical: seed 9 signal-dense files from existing sources
```

Both files: exactly 2 commits on main.

```
$ git log --all --oneline -- canonical/prompting-rules.md
2fcc376, 2490056 (same PR, before vs after squash), cc3fc9d, b4b2a3b
```

Zero orphan commits. Zero routine-driven commits. No branch ever touched these files from Process or Intake or Curate routines. The **mechanism has never executed**, not even on an orphan.

---

## Mechanism audit — where was this supposed to happen?

### A. Process Phase 2 — Deploy sub-step "Mirror to canonical"

`scheduled-tasks/process.md:158-172` specifies (verbatim):

```
**Mirror to canonical:**

Based on `Type` field in the queue header:
- `TECHNIQUE` or `PATTERN` → append the same change block under the matching section of `canonical/prompting-rules.md`
- `ANTIPATTERN` or `GOTCHA` → append under the matching section of `canonical/antipatterns.md`
- Other types (TOOL, MODEL-STATE, CC-STATE, NEWS) → no canonical mirror from this step; those surface via `canonical/active-findings.md` and get deleted by curate on graduation/expiry

After the mirror append:

grep -c "<unique string>" "<canonical mirror>" || { echo "MIRROR_FAILED"; revert_both; }
```

**This is the IMMEDIATE mirror — every auto-deploy should fire it, synchronously, at deploy time.**

### B. Curate 4.3 — Graduate learnings (3+ citations)

`scheduled-tasks/curate.md:273-286` specifies the Sunday graduation path:

```
### 4.3 Graduate learnings (3+ citations) — now writes to canonical

Scan learnings/*.md for patterns referenced 3+ times. For each:
1. Determine target canonical file:
   - TECHNIQUE or PATTERN → canonical/prompting-rules.md
   - ANTIPATTERN or GOTCHA → canonical/antipatterns.md
...
```

**This is the DELAYED graduation — runs Sundays only, requires 3+ citations across learnings.**

Both routines claim write authority over these canonical files per `CLAUDE.md`'s Write-Authority Matrix:

| File | process | curate |
|---|---|---|
| `canonical/prompting-rules.md` | ✅ (auto-deploy mirror) | ✅ (Sunday graduations) |
| `canonical/antipatterns.md` | ✅ (auto-deploy mirror) | ✅ (Sunday graduations) |

---

## Evidence — neither mechanism is actually executing

### Process Phase 2 mirror NOT firing

Recent `archive/queue/deployed.log` entries (2026-04-15 onward):

```
2026-04-16 | add-spec-first-plan-mode-pattern.md | Appended Spec-First Plan Mode pattern to learnings/patterns.md | DEPLOYED
2026-04-19 DEPLOYED mcp-500k-result-storage — Appended MCP 500K result storage entry to learnings/techniques.md. WORKING. [evidence: grep-confirmed "500,000 characters" in learnings/techniques.md]
2026-04-19 DEPLOYED claude-code-w15-w16-features — Appended Claude Code Week 15-16 feature set entry to learnings/techniques.md. WORKING. [evidence: grep-confirmed "Week 15-16 April 2026" in learnings/techniques.md]
2026-04-20 DEPLOYED disable-skill-shell-execution — Appended disableSkillShellExecution technique to learnings/techniques.md. WORKING. [evidence: grep-confirmed "disableSkillShellExecution" in learnings/techniques.md]
```

Process spec `process.md:187` specifies the DEPLOYED line format as:

```
YYYY-MM-DD DEPLOYED <name> — <summary>. WORKING. [evidence: grep-confirmed in <target> + <canonical mirror>]
```

**All observed evidence lines cite only the target (`learnings/...`), never the `+ <canonical mirror>` half.** Combined with zero commits to the mirror files, this is conclusive: the Process "Mirror to canonical" sub-step is not executing.

Additionally, the `canonical-mirrors=X` ledger field (mandated by `process.md:270`) is absent from every recent Process ledger entry (confirmed by Session #4 Step (i) audit).

### Curate 4.3 graduation NOT firing

The 3+ citation threshold is easy to exceed given ongoing deploys — yet no Sunday Curate run has produced commits to `prompting-rules.md` or `antipatterns.md`. Curate ledger entries in recent `archive/digest/` files would show `canonical-mirrors=X` if graduation ran; none do.

Curate also has its own ambiguity issue: step 4.3 requires scanning `learnings/*.md` for the 3+ citations, but "citation" is undefined — is it three separate entries mentioning the pattern, or three deploys of related techniques? Without a concrete counting rule, the LLM likely defaults to "no candidates found."

### Evidence from a live queue file — implicit curate punt

`archive/queue/add-bundled-prompt-skills-technique.md` (deployed 2026-04-24) contains this self-instruction:

> Add `/loop` and `/debug` references to `canonical/prompting-rules.md` on next curate pass so they surface in prompting guidance, not just technique log.

The queue file itself **punts** the mirror to curate. If Process is supposed to mirror immediately, the queue file shouldn't need to instruct curate to do it later. This is a cultural artifact suggesting the immediate-mirror expectation has never been internalized — authors of queue items expect the graduation path instead.

---

## Ranked hypotheses

### H1 (highest confidence) — Process LLM skips the mirror sub-step during Phase 2 execution

Same pattern as F1: the LLM reading `scheduled-tasks/process.md` executes the primary deploy append (to `learnings/*.md`) and the verify-grep, then moves on to the next queue item without executing the "Mirror to canonical" sub-step that appears below.

**Supporting evidence:**
- Every recent DEPLOYED line omits the `+ <canonical mirror>` half of the evidence template
- `canonical-mirrors=X` ledger field consistently absent
- Zero commits to mirror files on any branch
- The sub-step is visually deeper than the primary append in the prompt structure (nested bullets under "Canonical mirror"), which the LLM may treat as commentary

### H2 — Curate 4.3 graduation silently skipped on Sundays

The Sunday-only mechanism may be conditionally guarded or mis-scheduled. The 3+ citation threshold may evaluate to zero candidates if "citation" is interpreted narrowly.

**Supporting evidence:**
- Zero curate-driven commits to mirror files
- No `canonical-mirrors=X` field in curate digests

**Counter-evidence:** Curate DOES run (canonical/briefing-today.md is regenerated daily) — so the 8pm trigger works. It's specifically step 4.3 that isn't firing.

### H3 — Shared-ownership = no-ownership

Both Process and Curate have write authority. Each LLM may implicitly assume the other is the "real" owner, leading both to no-op. The queue file example in evidence above is suggestive.

### H4 — Queue items lack the `Type` field Process needs

The Mirror step keys on `Type: TECHNIQUE | PATTERN | ANTIPATTERN | GOTCHA`. If queue files use different labels (e.g., `Type: T` or `Impact: H`), the type-switch falls through to "Other types → no canonical mirror." Worth spot-checking: the single queue file inspected has no explicit `Type:` field, only `Impact: H` and `Routing: SAFE + H + md-only → QUEUE`.

**Sample inspection:** `archive/queue/add-bundled-prompt-skills-technique.md` has no `Type:` field. The spec's type-switch would match "Other types → no canonical mirror" and silently skip. If most queue files follow this pattern, H4 becomes the dominant hypothesis.

---

## Recommended next probe

**Spot-audit all queue files for the `Type:` field** (10-line script). If most/all queue files lack it, H4 is the root cause — the fix is a queue-file-format lint + either a spec update so Process infers Type from filename suffix (`-technique.md`, `-antipattern.md`) or a queue-header normalization step.

Supplementary: a single Process probe-run with explicit `echo "[PROBE] mirror sub-step entered"` + `echo "[PROBE] Type=$TYPE → target=$MIRROR_FILE"` to see whether the LLM reads the Type field at all.

Structural fixes to consider for Session #6:

1. **Make Process the sole owner of the immediate mirror.** Delete Curate 4.3 or reduce it to a reconciliation pass that only runs if the immediate mirror was skipped.
2. **Mandatory `Type:` field** in queue-file header — with a Process pre-check that rejects queue files lacking it.
3. **Deterministic `canonical-mirrors=<count>` ledger emission** — computed from a post-Phase-2 diff check against the mirror files. Absent or `=0` on a COMPLETE run with deploys should surface loudly via `canonical/active-findings.md` as an ERROR.
4. **Evidence template enforcement** — a grep-check that every `DEPLOYED` line in `deployed.log` cites both `learnings/` and `canonical/*.md` in its `[evidence: ...]` tag. Missing the canonical half = broken mirror.

---

## Session #6 decision points

1. **Root-cause first, or defensive fix first?** Recommendation: defensive fix first (ledger enforcement + Type-field requirement), root-cause probe in parallel. Same calculus as F1.
2. **Scope bundling.** F1 and F3 share a likely root cause (LLM skipping deep sub-steps in a long prompt). A single fix that enforces ledger emission + assertion checks for BOTH Phase 3 (open-decisions) and Phase 2's mirror sub-step is strictly better than two separate passes.
3. **Type-field normalization is a non-trivial but independent task.** Could be Phase A of Session #6, preceding the routine-spec edits.
