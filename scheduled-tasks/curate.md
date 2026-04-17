# CURATE — Claudious daily task

## 0. Environment

```bash
cd /repo || { echo "ABORT: wrong cwd"; exit 1; }

git config user.name "logancallen"
git config user.email "loganallensf@gmail.com"

CURRENT_BRANCH=$(git branch --show-current)
[ "$CURRENT_BRANCH" != "main" ] && { echo "ABORT: not on main"; exit 1; }
[ -n "$(git status --porcelain)" ] && { echo "ABORT: dirty tree"; exit 1; }

git pull origin main --ff-only || { echo "ABORT: pull failed"; exit 1; }

TODAY=$(date +%Y-%m-%d)
NOW=$(date +%H:%M)
DOW=$(date +%u)
LEDGER="runs/${TODAY}.md"
DIGEST="digest/${TODAY}.md"
RETRO="retrospectives/${TODAY}.md"
mkdir -p runs digest retrospectives skills/graduated

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

- **Daily MAY write:** `digest/${TODAY}.md`, `alerts.md`, `runs/${TODAY}.md`
- **Sunday additionally:** `retrospectives/${TODAY}.md`, `skills/graduated/*.md`, archive `proposals/*.md`, `queue/*.md`, modify `learnings/*.md` for graduations
- **MAY NEVER:** deploy code, touch application repos, modify User Preferences

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
LEDGER_COUNT=$(ls runs/*.md 2>/dev/null | wc -l)
BOOTSTRAPPING=false
[ "$LEDGER_COUNT" -lt 7 ] && BOOTSTRAPPING=true
```

If not bootstrapping, scan last 7 ledger files:
- Count status distribution
- Flag missing days (no ledger file)
- Flag ABORT or DEPENDENCY_NOT_SATISFIED

Aborted-week guard: if ≥3 days have ABORT or DEPENDENCY_NOT_SATISFIED → `WEEK_BROKEN=true`.

If bootstrapping: skip missing-day alerts, just report what exists.

### 3.2 Staleness Check

- Proposals >7 days old → flag for Sunday review (not archive — just flag)
- Queue items >3 days old → flag
- Alerts — only archive if content matches a resolved item in `deployed.log` (never age-only)

### 3.3 Write Daily Digest

```markdown
# Daily Digest — ${TODAY}

## Today
- Intake: <counts>
- Process: <counts>
- Curate: <this run>

## Action Required
<only list real items>

## System Health (last 7 days)
- Days complete: X / Y (Y = days with any ledger)
- Aborted: X
- Week status: <healthy|degraded|broken|bootstrapping>
```

Commit:

```bash
git add -A
git commit -m "curate: daily digest ${TODAY}" || echo "no daily changes"
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

Else, full retrospective:

**Prune proposals (>30 days):**

```bash
for f in proposals/*.md; do
  AGE=$(( ($(date +%s) - $(stat -c %Y "$f" 2>/dev/null || stat -f %m "$f")) / 86400 ))
  AGE=${AGE#-}
  if [ "$AGE" -gt 30 ]; then
    echo "$(date +%F) | $f | stale >30d" >> retrospectives/archive.md
    git rm "$f"
  fi
done
```

**Graduate learnings (3+ citations):**
1. Scan `learnings/*.md` for patterns referenced 3+ times
2. Create `skills/graduated/<name>.md` with consolidated content
3. Remove source entries from `learnings/*.md`
4. Verify: `grep -c "<key phrase>" learnings/*.md` → must = 0
5. If >0 → revert, log failure
6. Append to `deployed.log`: `YYYY-MM-DD GRADUATED <name>`

**Calibration:**
- Scan deployed.log last 30 days
- Compute % WORKING / BROKE / REGRESSED
- If BROKE+REGRESSED >20% → note for next Intake's config analysis

**Grade:**
- **A:** >95% WORKING, ≤5 stale, no broken weeks
- **B:** 85–95%, ≤10 stale, 0–1 broken days
- **C:** <85% or >10 stale or ≥2 broken days

### 4.2 Weekly Digest (appended to daily)

```markdown
---

## Week Summary
- Intake: X findings
- Process: X deployed, X verified, X failed
- Graduated: X
- Pruned: X
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
- inputs: runs/ (last 7), proposals/, queue/, deployed.log, learnings/, alerts.md
- outputs: digest/${TODAY}.md$([ $DOW -eq 7 ] && echo " + retrospectives/${TODAY}.md")
- summary: Alerts=X, Stale=X$([ $DOW -eq 7 ] && echo ", Graduated=X, Archived=X, Grade=<>")
- duration: ${DUR}s
```

## 7. Self-Audit

1. Daily digest exists
2. Ledger health check ran (bootstrapping-aware)
3. If Sunday: retrospective exists, graduations grep-verified
4. Alerts only archived by resolution (never age)
5. Action Required lists real items only
6. Ledger updated from IN_PROGRESS

Print status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
