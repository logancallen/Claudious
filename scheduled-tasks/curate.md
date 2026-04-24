# CURATE — Claudious daily task

**Effort:** high
**Task Budget:** 40000 tokens (beta header: `task-budgets-2026-03-13`)
**Model:** `claude-opus-4-7`
**Writes to:** `archive/digest/${TODAY}.md`, `canonical/briefing-today.md`, `alerts.md`, `archive/retrospectives/${TODAY}.md` (Sundays), `archive/runs/${TODAY}.md`, `canonical/active-findings.md` (pruning), `canonical/open-decisions.md` (pruning), `canonical/prompting-rules.md` (Sunday graduations), `canonical/antipatterns.md` (Sunday graduations)

---

## Literal-interpretation guardrail

Summarize today's ledger and proposals using only their content. Do not infer severity from your own priors. A proposal is "NEEDS YOU" only if archive/proposals/ contains it — never invent items for the brief. If today's intake is empty, say so; do not pad.

## 0. Environment

```bash
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "ABORT: not in a git repo"; exit 1; }
cd "$REPO_ROOT"

git config user.name "logancallen"
git config user.email "loganallensf@gmail.com"

CURRENT_BRANCH=$(git branch --show-current)
[ "$CURRENT_BRANCH" != "main" ] && { echo "ABORT: not on main"; exit 1; }
[ -n "$(git status --porcelain)" ] && { echo "ABORT: dirty tree"; exit 1; }

git pull origin main --ff-only || { echo "ABORT: pull failed"; exit 1; }

TODAY=$(date +%Y-%m-%d)
NOW=$(date +%H:%M)
DOW=$(date +%u)
LEDGER="archive/runs/${TODAY}.md"
DIGEST="archive/digest/${TODAY}.md"
BRIEF="canonical/briefing-today.md"
RETRO="archive/retrospectives/${TODAY}.md"
mkdir -p archive/runs archive/digest archive/retrospectives canonical

# Double-run check (manual trigger protection)
if [ -f "$DIGEST" ]; then
  FILE_AGE_MIN=$(( ($(date +%s) - $(stat -c %Y "$DIGEST" 2>/dev/null || stat -f %m "$DIGEST" 2>/dev/null || echo 0)) / 60 ))
  FILE_AGE_MIN=${FILE_AGE_MIN#-}
  if [ "$FILE_AGE_MIN" -lt 240 ] && [ "$FILE_AGE_MIN" -gt 0 ]; then
    echo "### ${NOW} curate [COMPLETE_NO_WORK]" >> "$LEDGER"
    echo "- reason: already ran ${FILE_AGE_MIN}m ago" >> "$LEDGER"
    exit 0
  fi
fi

START=$(date +%s)
```

## 1. Scope

- **Daily MAY write:** `archive/digest/${TODAY}.md`, `canonical/briefing-today.md`, `alerts.md`, `archive/runs/${TODAY}.md`, `canonical/active-findings.md` (prune only), `canonical/open-decisions.md` (prune only)
- **Sunday additionally:** `archive/retrospectives/${TODAY}.md`, `canonical/prompting-rules.md` (graduation appends), `canonical/antipatterns.md` (graduation appends), archive `archive/proposals/*.md`, `archive/queue/*.md`, modify `learnings/*.md` for graduations
- **MAY NEVER:** deploy code, touch application repos, modify User Preferences, modify `canonical/claude-state.md` or `canonical/claude-code-state.md` (intake-only), modify `canonical/00-README.md` or `canonical/toolchain.md` (manual only)

## 2. Dependencies

```bash
INTAKE_STATUS=$(grep -oE 'intake \[[A-Z_]+\]' "$LEDGER" 2>/dev/null | head -1 | grep -oE '[A-Z_]+' | tail -1)
PROCESS_STATUS=$(grep -oE 'process \[[A-Z_]+\]' "$LEDGER" 2>/dev/null | head -1 | grep -oE '[A-Z_]+' | tail -1)

OK_STATES="COMPLETE COMPLETE_NO_WORK"

check_dep() {
  local status="$1"
  [ -z "$status" ] && return 1
  for ok in $OK_STATES; do [ "$status" = "$ok" ] && return 0; done
  return 1
}

if ! check_dep "$INTAKE_STATUS" || ! check_dep "$PROCESS_STATUS"; then
  echo "" >> "$LEDGER"
  echo "### ${NOW} curate [DEPENDENCY_NOT_SATISFIED]" >> "$LEDGER"
  echo "- reason: intake=${INTAKE_STATUS:-missing}, process=${PROCESS_STATUS:-missing}" >> "$LEDGER"
  # Still write a briefing so Logan sees the failure in email
  cat > "$BRIEF" <<EOF_BRIEF
📬 Claudious Daily — $(date +'%a %b %d')

📊 System: BROKEN

Today's pipeline did not complete.
🏥 Intake [$([ "$INTAKE_STATUS" = "COMPLETE" ] || [ "$INTAKE_STATUS" = "COMPLETE_NO_WORK" ] && echo ✅ || echo ❌)] Process [$([ "$PROCESS_STATUS" = "COMPLETE" ] || [ "$PROCESS_STATUS" = "COMPLETE_NO_WORK" ] && echo ✅ || echo ❌)] Curate [❌]

See ${LEDGER} for the failure reason.

Archive: github.com/logancallen/Claudious/blob/main/archive/runs/${TODAY}.md
EOF_BRIEF
  git add -A && git commit -m "curate: skipped, deps not ready" && git push origin main
  exit 0
fi

echo "" >> "$LEDGER"
echo "### ${NOW} curate [IN_PROGRESS]" >> "$LEDGER"
echo "- start: $(date +%FT%T)" >> "$LEDGER"
```

## 3. Daily Work

### 3.1 Ledger Health Check (bootstrapping-aware)

```bash
LEDGER_COUNT=$(ls archive/runs/*.md 2>/dev/null | wc -l)
BOOTSTRAPPING=false
[ "$LEDGER_COUNT" -lt 7 ] && BOOTSTRAPPING=true
```

If not bootstrapping, scan last 7 ledger files:
- Count status distribution (COMPLETE / COMPLETE_NO_WORK / ABORT / DEPENDENCY_NOT_SATISFIED)
- Flag missing days (no ledger file)
- Flag ABORT or DEPENDENCY_NOT_SATISFIED

Aborted-week guard: if ≥3 days have ABORT or DEPENDENCY_NOT_SATISFIED → `WEEK_BROKEN=true`.

If bootstrapping: skip missing-day alerts, just report what exists.

### 3.2 Staleness Check

- Proposals >7 days old → flag for Sunday review (not archive — just flag)
- Queue items >3 days old → flag
- Alerts — only archive if content matches a resolved item in `archive/queue/deployed.log` (never age-only)

### 3.3 Prune `canonical/active-findings.md`

In place, keep only entries with all of:
- Date within last 7 days, AND
- `**Action:**` is `queued` or `proposed`

Remove entries where:
- `**Action:**` is `graduated` or `archived` (process promoted them; canonical mirror holds the durable form)
- Date is older than 7 days regardless of action (findings that never graduated in 7 days are stale signal — they either proposed or rotted)

Before removing, mirror the block to `archive/intake/active-findings-pruned-${TODAY}.md` (append mode) so history exists. Never lose a finding silently.

### 3.4 Prune `canonical/open-decisions.md`

For each entry in `canonical/open-decisions.md`, check the pointed-to `archive/proposals/<name>.md` file mtime. If >30 days old:
1. Append the entry to `archive/retrospectives/archive.md` with `pruned_from_open_decisions: ${TODAY}` tag.
2. Remove the entry from `canonical/open-decisions.md`.
3. Do NOT delete the archive/proposals/*.md file — just stop surfacing it.

### 3.5 Write Daily Digest (`archive/digest/${TODAY}.md`)

Full digest — verbose, archival:

```markdown
# Daily Digest — ${TODAY}

## Today
- Intake: <counts — Scout/Drift/Config and novelty flag>
- Process: <counts — triaged, deployed, canonical mirrors, verified>
- Curate: <this run's prune/graduate counts>

## Action Required
<list real items from canonical/open-decisions.md top by recency>

## System Health (last 7 days)
- Days complete: X / Y (Y = days with any ledger)
- Aborted: X
- Week status: <healthy|degraded|broken|bootstrapping>

## Machines

<For each heartbeat file in `.claudious-heartbeat/*.json`, print one line: machine-id, per-repo status (✅ if clean/synced, ⚠️ with reason if not), last seen human-readable.>

Example:
- logan-pc: Claudious ✅, asf ✅, courtside ⚠️ 3 behind (last seen 2h ago)
- mac-studio: Claudious ✅, asf ✅, courtside ✅ (last seen 18h ago)

If NO heartbeat files exist: print "- (none yet — run scripts/update-heartbeat.* on each machine)"

## Canonical state
- active-findings entries: N (pruned M)
- open-decisions entries: N (pruned M)
- Last claude-state.md update: <date>
- Last claude-code-state.md update: <date>
```

### 3.6 Write `canonical/briefing-today.md` (OVERWRITE — phone-readable)

Hard overwrite this file. Goal: Logan reads it in ≤15 seconds on phone. Keep under 30 lines. Pull data from:
- Ledger (intake/process/curate status → health)
- Today's `archive/intake/${TODAY}.md` (top 3–5 findings by credibility + relevance)
- Today's process deploys (from `archive/queue/deployed.log` lines dated ${TODAY})
- `canonical/open-decisions.md` (top 3 entries)
- `alerts.md` (CRITICAL only)

Determine system health:
- `HEALTHY` — intake, process, curate all COMPLETE or COMPLETE_NO_WORK
- `DEGRADED` — 1 of 3 is ABORT/DEPENDENCY_NOT_SATISFIED
- `BROKEN` — 2+ failures OR any ABORT on today

Template:

```
📬 Claudious Daily — <Day Mon DD>

📊 System: <HEALTHY | DEGRADED | BROKEN>

🆕 NEW (<count>)
• <1-line finding — kebab-id: summary>
• <1-line finding>
• <1-line finding>

⚡ DEPLOYED (<count>)
• <1-line what changed>

⚠️ NEEDS YOU (<count>)
• <kebab-id>: <summary> — <one-word action>

🏥 Intake [✅/❌] Process [✅/❌] Curate [✅/❌]

🖥️ MACHINES (<count>)
• <machine-id>: <one-line per-repo status> (<last seen>)

Archive: github.com/logancallen/Claudious/blob/main/archive/digest/${TODAY}.md
```

Rules for the brief:
- If a section count is 0, show the section header with `(0)` and no bullets — do not omit the section.
- No section has more than 5 bullets. If there are more, truncate and append `• +N more in digest`.
- No line over 100 chars (mobile wraps badly).
- CRITICAL alerts from `alerts.md` bump the `📊 System:` line from HEALTHY to DEGRADED and add a line `🚨 <alert title>` above `🆕 NEW`.
- Emojis in this file are intentional — the brief is the phone UI. Do not remove them when refactoring.
- `🖥️ MACHINES` pulls from `.claudious-heartbeat/*.json`. One line per machine. ✅ when Claudious + tracked-repos are clean/synced; ⚠️ when any tracked repo is `behind > 0` or `dirty_files > 0` or `last_seen > 48h` ago. If no heartbeat files exist, render the section as `🖥️ MACHINES (0)` with bullet `• (none yet — run scripts/update-heartbeat.* on each machine)`.
- HIGH-impact heartbeat findings (`REPO_BEHIND`) must also surface under `⚠️ NEEDS YOU` with the heartbeat kebab-id and a one-word action (usually `pull`).

Commit:

```bash
git add -A
git commit -m "curate: daily digest + brief ${TODAY}" || echo "no daily changes"
```

## 4. Sunday Work (only if $DOW == 7)

### 4.1 Retrospective

If bootstrapping (LEDGER_COUNT < 7):

```markdown
# Retrospective — ${TODAY}
## Status: DEFERRED - bootstrapping
Less than 7 days of ledger history. Graduations/prunes skipped.
```

Else if `WEEK_BROKEN=true`:

```markdown
# Retrospective — ${TODAY}
## Status: DEFERRED
Week has <N> broken days. Graduations/prunes skipped. Review: <days>.
```

Else, full retrospective below.

### 4.2 Prune proposals (>30 days)

```bash
for f in archive/proposals/*.md; do
  AGE=$(( ($(date +%s) - $(stat -c %Y "$f" 2>/dev/null || stat -f %m "$f")) / 86400 ))
  AGE=${AGE#-}
  if [ "$AGE" -gt 30 ]; then
    echo "$(date +%F) | $f | stale >30d" >> archive/retrospectives/archive.md
    git rm "$f"
  fi
done
```

Then re-trigger `canonical/open-decisions.md` regeneration (same logic as process Phase 3) so the index reflects the pruned set.

### 4.3 Graduate learnings (3+ citations) — now writes to canonical

**Authority.** Curate is the SOLE owner of writes to `canonical/prompting-rules.md` and `canonical/antipatterns.md` (see `CLAUDE.md` Write-Authority Matrix). Process no longer mirrors on deploy — items land in `learnings/` first and only graduate to canonical once this step confirms citation threshold.

**Citation definition (deterministic — no LLM judgment).**

A "citation" is an entry in `learnings/*.md` (techniques, patterns, antipatterns, gotchas) that references the candidate concept by a stable identifier — either:
- An exact name string (e.g. the concept's primary name as it first appears), or
- A stable synonym explicitly linked to the concept via an `alias:` tag or a prior graduation record.

Three distinct entries across any combination of `learnings/*.md` files constitute graduation eligibility. Two rules:

1. **Repeat entries in the same file count as ONE citation**, not N. If `learnings/techniques.md` has three separate blocks all referencing `/loop`, that's one citation, not three.
2. **Process re-deploys of the same concept count as ONE citation** once collapsed. If the queue re-deployed the same `Type:TECHNIQUE` entry three times in three weeks (e.g. because it was re-proposed), the concept has one citation, not three.

This makes graduation deterministic: the LLM computes citation count from disk via `grep` + dedup, not by judgment. Zero candidates meeting the threshold is a valid outcome and must be logged explicitly (see step 6 below), not defaulted to.

**Procedure.**

1. Determine target canonical file from the `Type:` field carried on the learnings entry (written there by Process Phase 2):
   - TECHNIQUE or PATTERN → `canonical/prompting-rules.md`
   - ANTIPATTERN or GOTCHA → `canonical/antipatterns.md`
2. Append consolidated content to the target canonical file under the matching section.
3. Verify: `grep -c "<key phrase>" <canonical target>` → must ≥1. If 0, revert append and log failure.
4. Remove source entries from `learnings/*.md`.
5. Verify: `grep -c "<key phrase>" learnings/*.md` → must = 0. If >0, revert, log failure.
6. Append to `archive/queue/deployed.log`: `YYYY-MM-DD GRADUATED <name> → <canonical target>. WORKING. [evidence: grep-confirmed, citations=<N>]`.
7. If this step produces zero graduations, log an explicit no-op line: `YYYY-MM-DD GRADUATED_NOOP — 0 candidates met 3-citation threshold (scanned=<count>)`. Do not omit the log line; silence is the failure mode this section is designed to eliminate.

Graduations no longer write to `skills/graduated/` — canonical is the surface. `skills/` remains for Claude Code skill files only.

### 4.4 Calibration

- Scan `archive/queue/deployed.log` last 30 days
- Compute % WORKING / BROKE / REGRESSED
- If BROKE+REGRESSED >20% → note for next Intake's config analysis

### 4.5 Grade

- **A:** >95% WORKING, ≤5 stale, no broken weeks
- **B:** 85–95%, ≤10 stale, 0–1 broken days
- **C:** <85% or >10 stale or ≥2 broken days

### 4.6 Weekly Digest (appended to daily `archive/digest/${TODAY}.md`)

```markdown
---

## Week Summary
- Intake: X findings
- Process: X deployed, X canonical-mirrors, X verified, X failed
- Graduated: X → canonical
- Pruned proposals: X
- Pruned active-findings: X
- Grade: <A|B|C>

## Top 3 for Coming Week
1.
2.
3.

## Proposals Awaiting Logan (max 10)
- ...
```

## 5. Commit & Push

```bash
git add -A
git commit -m "curate: ${TODAY}$([ $DOW -eq 7 ] && echo ' + weekly retro')" || echo "nothing"
git push origin main

STATUS="COMPLETE"

END=$(date +%s)
DUR=$((END - START))
```

## 6. Update Ledger

```
### ${NOW} curate [${STATUS}]
- commit: $(git rev-parse HEAD)
- inputs: archive/runs/ (last 7), archive/proposals/, archive/queue/, archive/queue/deployed.log, learnings/, canonical/active-findings.md, canonical/open-decisions.md, alerts.md
- outputs: archive/digest/${TODAY}.md, canonical/briefing-today.md$([ $DOW -eq 7 ] && echo ", archive/retrospectives/${TODAY}.md")
- summary: Alerts=X, Stale=X, active-findings-pruned=X, open-decisions-pruned=X$([ $DOW -eq 7 ] && echo ", Graduated=X→canonical, Archived=X, Grade=<>")
- duration: ${DUR}s
```

## 7. Self-Audit

1. `archive/digest/${TODAY}.md` exists
2. `canonical/briefing-today.md` exists and was overwritten (mtime = today)
3. Brief is ≤30 lines and includes all five required sections (NEW, DEPLOYED, NEEDS YOU, health row, archive link)
4. Ledger health check ran (bootstrapping-aware)
5. `canonical/active-findings.md` pruning mirrored to archive before removal
6. If Sunday: retrospective exists, graduations grep-verified against canonical, proposals regenerated via open-decisions
7. Alerts only archived by resolution (never age)
8. Action Required lists real items only (no fabrication)
9. Ledger updated from IN_PROGRESS

Print final status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
