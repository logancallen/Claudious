# INTAKE — Claudious daily task

**Effort:** xhigh
**Task Budget:** 40000 tokens (beta header: `task-budgets-2026-03-13`)
**Model:** `claude-opus-4-7`
**Writes to:** `archive/intake/${TODAY}.md`, `archive/runs/${TODAY}.md`, `canonical/active-findings.md`, `canonical/claude-state.md` (conditional), `canonical/claude-code-state.md` (conditional)

**Reads from:** `canonical/pipeline-flags.md`, `canonical/logan-current-stack.md`, `canonical/grok-scan-sources.md`, `archive/scan-inbox/*.md`, web, `canonical/*`, `learnings/*`

---

## Literal-interpretation guardrail

Interpret web search results literally. Do not synthesize beyond what the source states. Do not silently resolve ambiguity — flag it. If a finding could mean two things, write both interpretations and mark credibility `ANECDOTAL` until a second source confirms. Opus 4.7 no longer repairs ambiguous prompts; the same discipline applies here.

## 0. Environment

```bash
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "ABORT: not in a git repo"; exit 1; }
cd "$REPO_ROOT"

git config user.name "logancallen"
git config user.email "loganallensf@gmail.com"

CURRENT_BRANCH=$(git branch --show-current)
[ "$CURRENT_BRANCH" != "main" ] && { echo "ABORT: not on main ($CURRENT_BRANCH)"; exit 1; }
[ -n "$(git status --porcelain)" ] && { echo "ABORT: dirty tree"; git status --short; exit 1; }

git pull origin main --ff-only || { echo "ABORT: pull failed"; exit 1; }

TODAY=$(date +%Y-%m-%d)
NOW=$(date +%H:%M)
LEDGER="archive/runs/${TODAY}.md"
INTAKE="archive/intake/${TODAY}.md"
mkdir -p archive/runs archive/intake canonical
[ -d archive/runs ] || { echo "ABORT: archive/runs not writable"; exit 1; }

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

- **MAY write:** `archive/intake/${TODAY}.md`, `archive/runs/${TODAY}.md`, `canonical/active-findings.md` (append only), `canonical/claude-state.md` (OFFICIAL updates only), `canonical/claude-code-state.md` (OFFICIAL updates only)
- **MAY NEVER:** modify `learnings/`, `archive/queue/`, `archive/proposals/`, `skills/`, `canonical/prompting-rules.md`, `canonical/antipatterns.md`, `canonical/open-decisions.md`, `canonical/briefing-today.md`, any code repo, any migration, User Preferences
- **MAY NEVER DELETE from canonical/** — deletion is curate's job only.

## 2. Dependencies

None. Intake is first daily task.

## 3. Work

### Section A — Novelty Check (~60 sec)

Web search: `Claude Code OR Claude.ai OR MCP OR Cowork new release OR feature last 24 hours`

Count RELEVANT hits (ignore unrelated AI news, non-Anthropic launches):
- 0 hits → `NOVELTY=low`, run shallow Scout (searches 1, 3, 5 only)
- 1+ hits → `NOVELTY=high`, run full Scout (all 6)

### Section B.0 — Grok Scan Ingest

Read `canonical/pipeline-flags.md`. If `grok_ingest_enabled: false`, skip this section entirely.

If `grok_ingest_enabled: true`:

```bash
SCAN_INBOX="archive/scan-inbox"
LATEST_SCAN=$(ls -t ${SCAN_INBOX}/*-grok-scan*.md 2>/dev/null | head -1)

if [ -z "$LATEST_SCAN" ]; then
  echo "- grok-scan: no scan files in inbox (pipeline may not be live yet)" >> "$INTAKE"
  SCAN_STATE="none"
else
  # Missing-scan alarm (Hardening #13): warn if latest scan >36h old.
  SCAN_AGE_HOURS=$(( ($(date +%s) - $(stat -c %Y "$LATEST_SCAN" 2>/dev/null || stat -f %m "$LATEST_SCAN" 2>/dev/null || echo 0)) / 3600 ))
  if [ "$SCAN_AGE_HOURS" -gt 36 ]; then
    echo "- grok-scan: ALERT latest scan is ${SCAN_AGE_HOURS}h old (>36h threshold)" >> "$LEDGER"
    SCAN_STATE="stale"
  else
    SCAN_STATE="fresh"
  fi
fi
```

If `SCAN_STATE=fresh`: read the latest scan file plus any others from last 7 days. Extract findings into Section B alongside web-search Scout findings. Tag each with `source: grok-scan` and the scan filename. Same credibility/type/relevance classification applies.

If `SCAN_STATE=stale`: still read the file (partial value), but append `- note: latest scan is >36h old, coverage may have gaps` to Section B in the dated archive.

If `SCAN_STATE=none`: proceed to Section B web-search Scout as the sole Scout source.

Dedup rule: for each Grok-scan finding, grep `canonical/active-findings.md` and `archive/intake/` last 7 days. If kebab-id or URL already present → REDUNDANT, skip.

### Section B — Scout

Current search targets live in `scheduled-tasks/scout-additions.md`. Core six:

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
- Type: `TECHNIQUE` | `TOOL` | `BEHAVIOR` | `NEWS` | `MODEL-STATE` | `CC-STATE`
- Relevance to Logan: `HIGH` | `MEDIUM` | `LOW` (skip LOW)

### Section C — Drift Check

For each project path, attempt access. Cloud routines run on Linux — Windows paths are not reachable. If `test -d <path>` fails, note `not accessible in cloud execution` and continue.

Candidate paths:
- `$REPO_ROOT/../asf-graphics-app`
- `$REPO_ROOT/../courtside-pro`

For any reachable repo, check:
1. Migration files in `supabase/migrations/` vs entries in `docs/schema-state.md`
2. Tables/columns in migrations not documented
3. RLS policies in migrations not reflected in `docs/business-rules.md`

### Section D — Config Analysis

Read (skip any that do not exist — do not abort):
- `canonical/` (all files)
- `CLAUDE.md` (Claudious root)
- `learnings/*.md`
- `archive/queue/deployed.log`
- `alerts.md`

**Constitutional-rule seeds for next graduation cycle** (already drafted — if not yet graduated to `canonical/prompting-rules.md`, re-seed here as Config Proposal entries):

1. **Rule: no-hardcoded-entities-in-routines** — Target `canonical/prompting-rules.md`. Any routine prompt, scan, or automated pipeline that targets people, products, URLs, versions, or organizational state must reference a canonical config file by URL, not inline the list. Exceptions: entities with zero rot risk (protocol names, company names). Quarterly staleness-audit reviews all canonical config files. Source: 2026-04-19 Grok pipeline adaptability audit. IMPACT: H | EFFORT: T | RISK: SAFE.

2. **Rule: verification-prompts-suppress-self-report** — Target `canonical/prompting-rules.md`. Prompts that request verification outputs (commit SHAs, file contents, git status) must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block. Otherwise the self-report overrides the requested verification output, forcing re-run. Source: 2026-04-19 handoff generation session. IMPACT: H | EFFORT: T | RISK: SAFE.

Both rules are seeded here until they appear in `canonical/prompting-rules.md`. On graduation, delete these two bullet points from this section.

Checks:
1. **Stale path scan:** `grep -rni "OneDrive" CLAUDE.md learnings/ canonical/ 2>/dev/null` — any hit = proposal seed
2. **Removed-task references:** `grep -rni "AutoDream\|Config Backup\|Auto-Harvest\|KAIROS\|Chyros" CLAUDE.md learnings/ canonical/ scheduled-tasks/` — any hit = proposal seed
3. **Graduation candidates:** patterns in `learnings/*.md` referenced 3+ times
4. **Deploy calibration:** scan `archive/queue/deployed.log` for BROKE/REGRESSED — if any, note common factor
5. **Unused rules:** best-effort, rules in CLAUDE.md with no session references in 30+ days
6. **Hardcoded entity scan** (constitutional rule enforcement): run the following greps. Any hit → proposal seed to extract the list to a canonical config file.

```bash
# X-handles that should be in canonical/grok-scan-sources.md or similar
grep -rnE '@[a-zA-Z0-9_]{3,}' scheduled-tasks/ 2>/dev/null

# Two-word capitalized proper names (likely person names) in routine prompts
grep -rnE '\b[A-Z][a-z]+ [A-Z][a-z]+\b' scheduled-tasks/ 2>/dev/null | grep -viE '(Markdown|GitHub|MIT|API|CLI|SDK|URL|YAML|JSON|Claude Code|Claude Max|Claude Desktop|Claude Projects)'

# Hardcoded tool-name lists (competitors, stack items)
grep -rniE '(Cursor|Windsurf|Codex CLI|Gemini CLI|Cline|Aider)' scheduled-tasks/ 2>/dev/null
```

Output per finding: name + rationale + `IMPACT (H/M/L)` + `EFFORT (T/L/M/H)` + `RISK (SAFE / TEST-FIRST / REVIEW-REQUIRED)`

### Commit at section boundary

```bash
git add -A
git commit -m "intake: ${TODAY} sections A-D complete" || echo "nothing to commit in sections"
```

## 4. Output — Dated Archive File

Write `archive/intake/${TODAY}.md`:

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

## 5. Canonical Updates (write-only — never delete)

After the dated archive file is written, propagate to canonical:

### 5.1 `canonical/active-findings.md`

Append each Scout/Drift/Config finding as:

```markdown
### [YYYY-MM-DD] [kebab-id]
**Source:** [URL or path]
**Credibility:** OFFICIAL | VERIFIED | COMMUNITY | ANECDOTAL
**Type:** TECHNIQUE | TOOL | BEHAVIOR | NEWS | MODEL-STATE | CC-STATE
**Summary:** [1-2 sentences, literal — no added synthesis]
**Action:** queued
```

Action values: `queued` (default — process triages next), `proposed` (Logan review), `graduated` (promoted to canonical/prompting-rules or antipatterns), `archived` (merged to archive only). Intake only sets `queued`. Process/curate update the rest.

### 5.2 `canonical/claude-state.md` (conditional)

Update in place ONLY IF: credibility `OFFICIAL` AND type `MODEL-STATE` (new model release, pricing change, context window change, sampling-param behavior, deprecation, new capability). Edit the relevant section directly. Bump the `Last updated:` date at the top. Do NOT append a changelog — the file is current state, not history.

### 5.3 `canonical/claude-code-state.md` (conditional)

Update in place ONLY IF: credibility `OFFICIAL` AND type `CC-STATE` (new CC version, env var, slash command, keybinding change, feature flag). Same rules as 5.2.

### 5.4 Literal updates only

If a finding's OFFICIAL claim is narrow, update only that fact — do not rewrite the section. If the claim conflicts with existing canonical content, do NOT edit. Instead, add the conflict to `archive/intake/${TODAY}.md` Section D and let process handle it as a proposal.

## 6. Commit & Push

```bash
git add -A
git commit -m "intake: ${TODAY} output + canonical updates" || echo "nothing new"
git push origin main

TOTAL=$(grep -oE 'Total for Process: [0-9]+' "$INTAKE" | grep -oE '[0-9]+' || echo 0)
STATUS="COMPLETE"
[ "$TOTAL" = "0" ] && STATUS="COMPLETE_NO_WORK"

END=$(date +%s)
DUR=$((END - START))
```

## 7. Update Ledger Entry (replace IN_PROGRESS)

Use str_replace or sed equivalent to replace the `[IN_PROGRESS]` line with final status, and append details:

```
### ${NOW} intake [${STATUS}]
- commit: $(git rev-parse HEAD)
- inputs: web, canonical/, learnings/, local repos (if accessible)
- outputs: archive/intake/${TODAY}.md, canonical/active-findings.md (+N), canonical/claude-state.md (<updated|unchanged>), canonical/claude-code-state.md (<updated|unchanged>)
- summary: Scout=X, Drift=X, Config=X (total=X, novelty=<flag>), canonical-edits=N
- duration: ${DUR}s
```

Commit + push ledger.

## 8. Self-Audit

1. `archive/intake/${TODAY}.md` exists with all 4 sections
2. `canonical/active-findings.md` appended (or explicit "no findings" note in ledger)
3. Any canonical/claude-state or canonical/claude-code-state edits have `Last updated:` bumped
4. No deletes from any canonical file (only append/edit-in-place)
5. Ledger entry updated from IN_PROGRESS to final status
6. Stale-path + removed-task scans actually ran and reported

Print final status. Status must be one of: `COMPLETE | COMPLETE_NO_WORK | DEPENDENCY_NOT_SATISFIED | ABORT | IN_PROGRESS`.
