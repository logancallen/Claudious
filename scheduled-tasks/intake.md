# INTAKE — Claudious daily task

## 0. Environment

```bash
cd /repo || { echo "ABORT: wrong cwd"; exit 1; }

git config user.name "logancallen"
git config user.email "loganallensf@gmail.com"

CURRENT_BRANCH=$(git branch --show-current)
[ "$CURRENT_BRANCH" != "main" ] && { echo "ABORT: not on main ($CURRENT_BRANCH)"; exit 1; }
[ -n "$(git status --porcelain)" ] && { echo "ABORT: dirty tree"; git status --short; exit 1; }

git pull origin main --ff-only || { echo "ABORT: pull failed"; exit 1; }

TODAY=$(date +%Y-%m-%d)
NOW=$(date +%H:%M)
LEDGER="runs/${TODAY}.md"
INTAKE="intake/${TODAY}.md"
mkdir -p runs intake
[ -d runs ] || { echo "ABORT: runs/ not writable"; exit 1; }

# Double-run check (manual trigger protection)
if [ -f "$INTAKE" ]; then
  FILE_AGE_MIN=$(( ($(date +%s) - $(stat -c %Y "$INTAKE" 2>/dev/null || stat -f %m "$INTAKE" 2>/dev/null || echo 0)) / 60 ))
  FILE_AGE_MIN=${FILE_AGE_MIN#-}
  if [ "$FILE_AGE_MIN" -lt 240 ] && [ "$FILE_AGE_MIN" -gt 0 ]; then
    echo "### ${NOW} intake [COMPLETE_NO_WORK]" >> "$LEDGER"
    echo "- reason: already ran ${FILE_AGE_MIN}m ago" >> "$LEDGER"
    exit 0
  fi
fi

START=$(date +%s)

# IN_PROGRESS ledger entry FIRST (so token-limit kills leave a trace)
echo "" >> "$LEDGER"
echo "### ${NOW} intake [IN_PROGRESS]" >> "$LEDGER"
echo "- start: $(date +%FT%T)" >> "$LEDGER"
```

## 1. Scope

- **MAY write:** `intake/${TODAY}.md`, `runs/${TODAY}.md`
- **MAY NEVER:** modify `learnings/`, `queue/`, `proposals/`, `skills/`, any code repo, any migration, User Preferences

## 2. Dependencies

None. Intake is first daily task.

## 3. Work

### Section A — Novelty Check (~60 sec)

Web search: `Claude Code OR Claude.ai OR MCP OR Cowork new release OR feature last 24 hours`

Count RELEVANT hits (ignore unrelated AI news, non-Anthropic launches):
- 0 hits → `NOVELTY=low`, run shallow Scout (searches 1, 3, 5 only)
- 1+ hits → `NOVELTY=high`, run full Scout (all 6)

### Section B — Scout

1. `site:docs.claude.com OR site:code.claude.com changelog updated last 7 days`
2. `"claude code" OR "CLAUDE.md" tips patterns site:twitter.com OR site:x.com past 48 hours`
3. `"MCP server" OR "MCP tool" new release last 7 days`
4. `Claude Max OR Cowork new feature OR limit change`
5. `anthropic.com/news OR anthropic.com/blog last 14 days`
6. `reddit.com/r/ClaudeAI OR reddit.com/r/ChatGPTCoding high-upvote Claude technique last 7 days`

For each RELEVANT hit, extract:
- 1-line finding (what + why ≤20 words)
- Source URL
- Credibility: `OFFICIAL` | `VERIFIED` | `COMMUNITY` | `ANECDOTAL`
- Type: `TECHNIQUE` | `TOOL` | `BEHAVIOR` | `NEWS`
- Relevance to Logan: `HIGH` | `MEDIUM` | `LOW` (skip LOW)

### Section C — Drift Check

For each project path that exists on this machine:
- `C:\Users\logan\Projects\asf-graphics-app`
- `C:\Users\logan\Projects\courtside-pro`

Check:
1. Migration files in `supabase/migrations/` vs entries in `docs/schema-state.md`
2. Tables/columns in migrations not documented
3. RLS policies in migrations not reflected in `docs/business-rules.md`

If project missing: note "not present on this machine" (not a failure).

### Section D — Config Analysis

Read:
- `C:\Users\logan\.claude\CLAUDE.md`
- `CLAUDE.md` (Claudious)
- `learnings/*.md`
- `skills/graduated/*.md`
- `queue/deployed.log`
- `alerts.md`

Checks:
1. **Stale path scan:** `grep -rni "OneDrive" CLAUDE.md learnings/ 2>/dev/null` — any hit = proposal
2. **Removed-task references:** `grep -rni "AutoDream\|Config Backup\|Auto-Harvest" CLAUDE.md learnings/` — any hit = proposal
3. **Graduation candidates:** patterns in `learnings/*.md` referenced 3+ times
4. **Deploy calibration:** scan `deployed.log` for BROKE/REGRESSED — if any, note common factor
5. **Unused rules:** best-effort, rules in CLAUDE.md with no session references in 30+ days

Output per finding: name + rationale + `IMPACT (H/M/L)` + `EFFORT (T/L/M/H)` + `RISK (SAFE / TEST-FIRST / REVIEW-REQUIRED)`

### Commit at section boundary

```bash
git add -A
git commit -m "intake: ${TODAY} sections A-D complete" || echo "nothing to commit in sections"
```

## 4. Output

Write `intake/${TODAY}.md`:

```markdown
# Intake — YYYY-MM-DD

## Novelty: <high|low>

## A. Novelty Check
<result>

## B. Scout Findings
<list or "none">

## C. Drift Findings
<per-project or "none">

## D. Config Proposals
<list or "none">

## Summary
- Scout: X kept / Y skipped
- Drift: X across Y projects
- Config: X proposals
- Total for Process: X
- Novelty: <flag>
```

## 5. Commit & Push

```bash
git add -A
git commit -m "intake: ${TODAY} output written" || echo "nothing new"
git push origin main

TOTAL=$(grep -oE 'Total for Process: [0-9]+' "$INTAKE" | grep -oE '[0-9]+' || echo 0)
STATUS="COMPLETE"
[ "$TOTAL" = "0" ] && STATUS="COMPLETE_NO_WORK"

END=$(date +%s)
DUR=$((END - START))
```

## 6. Update Ledger Entry (replace IN_PROGRESS)

Use str_replace or sed equivalent to replace the `[IN_PROGRESS]` line with final status, and append details:

```
### ${NOW} intake [${STATUS}]
- commit: $(git rev-parse HEAD)
- inputs: web, ~/.claude, local repos
- outputs: intake/${TODAY}.md
- summary: Scout=X, Drift=X, Config=X (total=X, novelty=<flag>)
- duration: ${DUR}s
```

Commit + push ledger.

## 7. Self-Audit

1. `intake/${TODAY}.md` exists with all 4 sections
2. Ledger entry updated from IN_PROGRESS to final status
3. Stale-path + removed-task scans actually ran and reported

Print final status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
