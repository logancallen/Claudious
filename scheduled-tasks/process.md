# PROCESS — Claudious daily task

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
LEDGER="runs/${TODAY}.md"
INTAKE="intake/${TODAY}.md"
mkdir -p runs queue proposals learnings

START=$(date +%s)
```

## 1. Scope

- **MAY write:** `queue/*.md`, `proposals/*.md`, `queue/deployed.log`, `learnings/*.md` (SAFE+HIGH+TRIVIAL+md-only ONLY), `runs/${TODAY}.md`
- **MAY NEVER:** deploy to application repos, modify User Preferences, touch schemas

## 2. Dependencies

```bash
INTAKE_STATUS=$(grep -oE 'intake \[[A-Z_]+\]' "$LEDGER" 2>/dev/null | head -1 | grep -oE '[A-Z_]+' | tail -1)

# Accept as satisfied: COMPLETE, COMPLETE_NO_WORK
SATISFIED=false
for ok in COMPLETE COMPLETE_NO_WORK; do
  [ "$INTAKE_STATUS" = "$ok" ] && SATISFIED=true
done

if [ "$SATISFIED" != "true" ]; then
  echo "" >> "$LEDGER"
  echo "### ${NOW} process [DEPENDENCY_NOT_SATISFIED]" >> "$LEDGER"
  echo "- reason: intake status is ${INTAKE_STATUS:-missing}" >> "$LEDGER"
  echo "- remediation: re-run intake" >> "$LEDGER"
  git add -A && git commit -m "process: skipped, intake not ready" && git push origin main
  exit 0
fi

# IN_PROGRESS entry
echo "" >> "$LEDGER"
echo "### ${NOW} process [IN_PROGRESS]" >> "$LEDGER"
echo "- start: $(date +%FT%T)" >> "$LEDGER"
```

## 3. Validate Intake File Structure

```bash
INTAKE_EMPTY=false
INTAKE_INVALID=false
if [ ! -f "$INTAKE" ]; then
  INTAKE_EMPTY=true
else
  for section in "## A." "## B." "## C." "## D." "## Summary"; do
    if ! grep -qF "$section" "$INTAKE"; then
      echo "- validation: intake file malformed, missing $section" >> "$LEDGER"
      INTAKE_INVALID=true
    fi
  done
fi

if [ "$INTAKE_INVALID" = "true" ]; then
  INTAKE_EMPTY=true
fi
```

## 4. Work — 3 Phases

### Phase 1 — Triage (only if intake valid and not empty)

Read `intake/${TODAY}.md`. For each finding in sections B, C, D:

**Classify:**
- `IMPACT`: HIGH | MEDIUM | LOW
- `EFFORT`: TRIVIAL | LOW | MEDIUM | HIGH
- `RISK`: SAFE | TEST-FIRST | REVIEW-REQUIRED

**Duplicate check (expanded scan — includes graduated skills):**

```bash
grep -rl "<key phrase>" queue/ proposals/ learnings/ skills/graduated/ 2>/dev/null
```

If hit → REDUNDANT, log, no file.

**Contradiction check:** Scan `learnings/` for statements conflicting with new finding. If conflict → CONFLICT tag, write to `proposals/`.

**Route:**
- AUTO-QUEUE if `SAFE + HIGH + TRIVIAL` → `queue/<kebab-name>.md`
- PROPOSE otherwise → `proposals/<kebab-name>.md`

**Queue file format:**

```markdown
# <Name>
**Source:** intake/${TODAY}.md section <X>
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE
**Target file:** learnings/<file>.md

## Change
<exact append block>

## Verification
grep -c "<unique string>" <target> → must ≥1 after deploy
```

Commit after triage:

```bash
git add -A
git commit -m "process: triage complete" || echo "no triage output"
```

### Phase 2 — Deploy

Scan `queue/*.md` (new + residual).

For each queue item:

**Re-verify SAFE+HIGH+TRIVIAL+md-only:**
- Parse header
- Target must end `.md` and be in `learnings/` or Claudious root
- If fails → move to `proposals/` with `auto-downgraded: violates queue rules` in deployed.log

**Deploy:**
1. Append "Change" block to target
2. `grep -c "<unique string>" <target>` → must ≥1
3. If fails → revert append, item stays in queue, log `DEPLOY_FAILED`
4. If passes → proceed to cleanup

**Cleanup:**

```bash
git rm "queue/<file>.md"
```

**Log to deployed.log:**

```
YYYY-MM-DD DEPLOYED <name> — <summary>. WORKING. [evidence: grep-confirmed in <target>]
```

Commit after deploy:

```bash
git add -A
git commit -m "process: deployed $DEPLOY_COUNT items" || echo "no deploys"
```

### Phase 3 — Verify (Evidence Loop)

Read last 7 days of `queue/deployed.log`. For each `DEPLOYED` line deployed >24hr ago (skip today's):

**Skip if line contains `INTENTIONALLY_REMOVED` tag.**

1. **Regression:** grep target file for unique string — if absent: `YYYY-MM-DD REGRESSED <item>`
2. **Alert:** grep `alerts.md` for item name with post-deploy date — if found: `YYYY-MM-DD BROKE <item>`
3. **Otherwise:** no-op

Skip items >7 days old already tagged WORKING (bloat control).

## 5. Commit & Push

```bash
git add -A
git commit -m "process: ${TODAY} verify complete" || echo "nothing new"
git push origin main

STATUS="COMPLETE"
if [ "$TRIAGED" = "0" ] && [ "$DEPLOYED" = "0" ] && [ "$VERIFIED" = "0" ]; then
  STATUS="COMPLETE_NO_WORK"
fi

END=$(date +%s)
DUR=$((END - START))
```

## 6. Update Ledger (replace IN_PROGRESS)

```
### ${NOW} process [${STATUS}]
- commit: $(git rev-parse HEAD)
- inputs: intake/${TODAY}.md, queue/, deployed.log
- outputs: queue=+X, proposals=+X, deployed=X, verified=X
- summary: Triage X, Deploy X W/X F, Verify X W/X B/X R
- duration: ${DUR}s
```

## 7. Self-Audit

1. Every intake finding has disposition
2. Every DEPLOYED line has `evidence:` tag
3. No queue items violate rules
4. Evidence Loop skipped same-day + INTENTIONALLY_REMOVED
5. Ledger updated from IN_PROGRESS

Print final status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
