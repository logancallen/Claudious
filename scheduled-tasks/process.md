# PROCESS — Claudious daily task

**Effort:** xhigh
**Task Budget:** 60000 tokens (beta header: `task-budgets-2026-03-13`)
**Model:** `claude-opus-4-7`
**Writes to:** `archive/proposals/*`, `archive/queue/*`, `archive/queue/deployed.log`, `canonical/open-decisions.md`, `canonical/prompting-rules.md` (on auto-deploy), `canonical/antipatterns.md` (on auto-deploy), `canonical/active-findings.md` (graduation marks), `learnings/*.md` (on auto-deploy), `archive/runs/${TODAY}.md`

---

## Literal-interpretation guardrail

Classify findings on what the source literally says. Do not upgrade a COMMUNITY finding to VERIFIED because it "sounds right." Do not downgrade an OFFICIAL finding because it contradicts prior belief — write a proposal instead. Risk and impact tags are evidence-based; `SAFE` means grep-verifiable md append, not "feels safe."

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
LEDGER="archive/runs/${TODAY}.md"
INTAKE="archive/intake/${TODAY}.md"
mkdir -p archive/runs archive/queue archive/proposals learnings canonical

START=$(date +%s)
```

## 1. Scope

- **MAY write:** `archive/queue/*.md`, `archive/proposals/*.md`, `archive/queue/deployed.log`, `learnings/*.md` (SAFE+HIGH+TRIVIAL+md-only ONLY), `canonical/open-decisions.md` (full regen), `canonical/prompting-rules.md` (append on auto-deploy of TECHNIQUE/PATTERN), `canonical/antipatterns.md` (append on auto-deploy of ANTIPATTERN/GOTCHA), `canonical/active-findings.md` (edit `Action:` field only), `archive/runs/${TODAY}.md`
- **MAY NEVER:** deploy to application repos, modify User Preferences, touch schemas, modify `canonical/claude-state.md` or `canonical/claude-code-state.md` (intake-only), modify `canonical/briefing-today.md` (curate-only)

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

Read `archive/intake/${TODAY}.md`. For each finding in sections B, C, D:

**Classify:**
- `IMPACT`: HIGH | MEDIUM | LOW
- `EFFORT`: TRIVIAL | LOW | MEDIUM | HIGH
- `RISK`: SAFE | TEST-FIRST | REVIEW-REQUIRED
- `TYPE`: TECHNIQUE | PATTERN | ANTIPATTERN | GOTCHA | TOOL | MODEL-STATE | CC-STATE | NEWS

**Duplicate check (expanded scan — includes canonical):**

```bash
grep -rl "<key phrase>" archive/queue/ archive/proposals/ learnings/ canonical/ skills/graduated/ 2>/dev/null
```

If hit → REDUNDANT, log, no file.

**Contradiction check:** Scan `learnings/` and `canonical/` for statements conflicting with new finding. If conflict → CONFLICT tag, write to `archive/proposals/` (never auto-deploy a contradiction).

**Route:**
- AUTO-QUEUE if `SAFE + HIGH + TRIVIAL` → `archive/queue/<kebab-name>.md`
- PROPOSE otherwise → `archive/proposals/<kebab-name>.md`

**Queue file format:**

```markdown
# <Name>
**Source:** archive/intake/${TODAY}.md section <X>
**Finding id:** <kebab-id from canonical/active-findings.md>
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE | **Type:** TECHNIQUE|PATTERN|ANTIPATTERN|GOTCHA
**Target file:** learnings/<file>.md
**Canonical mirror:** canonical/prompting-rules.md | canonical/antipatterns.md

## Change
<exact append block>

## Verification
grep -c "<unique string>" <target> → must ≥1 after deploy
grep -c "<unique string>" <canonical mirror> → must ≥1 after deploy
```

Commit after triage:

```bash
git add -A
git commit -m "process: triage complete" || echo "no triage output"
```

### Phase 2 — Deploy

Scan `archive/queue/*.md` (new + residual).

For each queue item:

**Re-verify SAFE+HIGH+TRIVIAL+md-only:**
- Parse header
- Target must end `.md` and be in `learnings/` or Claudious root
- If fails → move to `archive/proposals/` with `auto-downgraded: violates queue rules` in deployed.log

**Deploy to learnings:**
1. Append "Change" block to target file in `learnings/`
2. `grep -c "<unique string>" <target>` → must ≥1
3. If fails → revert append, item stays in queue, log `DEPLOY_FAILED`
4. If passes → proceed to canonical mirror step

**Mirror to canonical:**

Based on `Type` field in the queue header:
- `TECHNIQUE` or `PATTERN` → append the same change block under the matching section of `canonical/prompting-rules.md`
- `ANTIPATTERN` or `GOTCHA` → append under the matching section of `canonical/antipatterns.md`
- Other types (TOOL, MODEL-STATE, CC-STATE, NEWS) → no canonical mirror from this step; those surface via `canonical/active-findings.md` and get deleted by curate on graduation/expiry

After the mirror append:

```bash
grep -c "<unique string>" "<canonical mirror>" || { echo "MIRROR_FAILED"; revert_both; }
```

If mirror fails → revert BOTH the learnings append and the canonical append; leave queue item in place; log `DEPLOY_FAILED — canonical mirror`.

**Mark finding graduated in active-findings:**

Edit `canonical/active-findings.md` in place: find the block with matching `kebab-id` and change `**Action:** queued` → `**Action:** graduated`. Do NOT delete the block — curate prunes graduated entries weekly.

**Cleanup:**

```bash
git rm "archive/queue/<file>.md"
```

**Log to deployed.log:**

```
YYYY-MM-DD DEPLOYED <name> — <summary>. WORKING. [evidence: grep-confirmed in <target> + <canonical mirror>]
```

Commit after deploy:

```bash
git add -A
git commit -m "process: deployed $DEPLOY_COUNT items" || echo "no deploys"
```

### Phase 3 — Regenerate `canonical/open-decisions.md`

This is the only source of truth for proposals awaiting Logan. Regenerate the whole file from `archive/proposals/*.md`:

```bash
OPEN="canonical/open-decisions.md"
cat > "$OPEN" <<HEADER
# Open Decisions — Proposals Awaiting Logan

**Last updated:** ${TODAY}
**Total open:** $(ls archive/proposals/*.md 2>/dev/null | grep -v '\.gitkeep' | wc -l)

Proposals are improvements that cannot auto-deploy (TEST-FIRST, REVIEW-REQUIRED, CONFLICT, or larger than TRIVIAL). Each entry points to the full proposal file in archive/proposals/.

---

HEADER

for f in archive/proposals/*.md; do
  [ -f "$f" ] || continue
  [ "$(basename "$f")" = ".gitkeep" ] && continue
  # Extract fields via grep (defensive — format varies across older proposals)
  NAME=$(basename "$f" .md)
  SUMMARY=$(grep -m1 -E '^(## Summary|## Problem|## Finding|\*\*Summary:\*\*)' -A1 "$f" | tail -n 1 | sed 's/^[ *]*//' | head -c 200)
  WHY=$(grep -m1 -E '^(## Why proposal|## Why not auto-deploy|\*\*Why proposal:\*\*|\*\*Risk:\*\*)' -A1 "$f" | tail -n 1 | sed 's/^[ *]*//' | head -c 200)
  ACTION=$(grep -m1 -E '^(## Action needed|## Logan action|\*\*Action:\*\*)' -A1 "$f" | tail -n 1 | sed 's/^[ *]*//' | head -c 200)
  {
    echo "### ${NAME}"
    echo "**File:** archive/proposals/${NAME}.md"
    echo "**Summary:** ${SUMMARY:-(see file)}"
    echo "**Why proposal:** ${WHY:-(see file)}"
    echo "**Logan action:** ${ACTION:-review + approve/reject}"
    echo ""
  } >> "$OPEN"
done
```

The exact extraction may need per-proposal fallback (older proposals don't match the newer header schema). When extraction returns empty, fall back to "(see file)" — do not fabricate summaries.

### Phase 4 — Verify (Evidence Loop)

Read last 7 days of `archive/queue/deployed.log`. For each `DEPLOYED` line deployed >24hr ago (skip today's):

**Skip if line contains `INTENTIONALLY_REMOVED` tag.**

1. **Regression:** grep target file AND canonical mirror for unique string — if either absent: `YYYY-MM-DD REGRESSED <item>`
2. **Alert:** grep `alerts.md` for item name with post-deploy date — if found: `YYYY-MM-DD BROKE <item>`
3. **Otherwise:** no-op

Skip items >7 days old already tagged WORKING (bloat control).

## 5. Commit & Push

```bash
git add -A
git commit -m "process: ${TODAY} verify + canonical regen" || echo "nothing new"
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
- inputs: archive/intake/${TODAY}.md, archive/queue/, archive/queue/deployed.log, archive/proposals/
- outputs: queue=+X, proposals=+X, deployed=X, verified=X, canonical-mirrors=X, open-decisions-regenerated=<yes|no>
- summary: Triage X, Deploy X W/X F, Verify X W/X B/X R
- duration: ${DUR}s
```

## 7. Self-Audit

1. Every intake finding has a disposition (queued, proposed, redundant, or deferred)
2. Every DEPLOYED line has `evidence:` tag citing BOTH target and canonical mirror
3. No queue items violate SAFE+HIGH+TRIVIAL+md-only rules
4. `canonical/open-decisions.md` regenerated; file count matches `archive/proposals/*.md` count
5. `canonical/active-findings.md` graduation marks match deploy count for this run
6. Evidence Loop skipped same-day + `INTENTIONALLY_REMOVED`
7. Ledger updated from IN_PROGRESS

Print final status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
