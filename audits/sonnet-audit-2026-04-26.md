# Sonnet 4 / Opus 4 Pin Audit — 2026-04-26

**Deadline:** 2026-04-30 (4 days). 1M-context beta header retires.
**Pre-swap integrity:** same-origin = yes (`https://github.com/logancallen/asf-graphics-app.git`); Projects/asf-graphics-app unique commits = 0 (strict subset of Documents/GitHub/asf-graphics-app).
**Migration scope:** 32 Group A hits + 1 Group B code hit + 0 Group C code hits = **33 high-confidence migration targets across 12 files in 7 repos**. (Group D has 36 already-migrated hits in 26 files across 2 repos.)
**Scope:** 12 repos (2 stale duplicates excluded — `Projects/asf-graphics-app` post-integrity-swap; `Documents/GitHub/courtside-pro` per Logan canonical-pair note).

**Scope manifest:**

In scope (12):
- `C:\Users\logan\Projects\allen-sports-floors`
- `C:\Users\logan\Projects\Claudious`
- `C:\Users\logan\Projects\courtside-pro`
- `C:\Users\logan\Documents\GitHub\alpha-1`
- `C:\Users\logan\Documents\GitHub\asf-graphics-app` _(swapped — canonical for ASF active work)_
- `C:\Users\logan\Documents\GitHub\cattle-signal-api`
- `C:\Users\logan\Documents\GitHub\cattlesignal`
- `C:\Users\logan\Documents\GitHub\cattlesignal-data-service`
- `C:\Users\logan\Documents\GitHub\floortrack-api`
- `C:\Users\logan\Documents\GitHub\prospect-signal`
- `C:\Users\logan\Documents\GitHub\prospect-signal-api`
- `C:\Users\logan\Documents\GitHub\prospect-signal-etl`

Skipped (2):
- `C:\Users\logan\Projects\asf-graphics-app` _(stale; superset in Documents/GitHub/ post-integrity-check)_
- `C:\Users\logan\Documents\GitHub\courtside-pro` _(stale; canonical in Projects/)_

---

## Group A — Pinned dated model IDs (high-confidence migration targets)

All Group A hits in scope are `claude-sonnet-4-20250514` (matches `claude-sonnet-4-2025*` prefix). No `claude-sonnet-4-5-2025*`, `claude-opus-4-2025*`, or `claude-opus-4-1-2025*` hits anywhere.

### Per-repo summary (Group A)

| Repo | Code hits | Doc/archive references | Total |
|---|---:|---:|---:|
| Documents/GitHub/asf-graphics-app | 9 | 0 | 9 |
| Projects/courtside-pro | 7 | 2 | 9 |
| Documents/GitHub/prospect-signal | 4 | 0 | 4 |
| Projects/Claudious | 0 | 8 | 8 |
| Documents/GitHub/cattlesignal-data-service | 1 | 0 | 1 |
| Documents/GitHub/cattle-signal-api | 1 | 0 | 1 |
| Documents/GitHub/cattlesignal | 1 | 0 | 1 |
| Documents/GitHub/alpha-1 | 0 | 0 | 0 |
| Documents/GitHub/floortrack-api | 0 | 0 | 0 |
| Documents/GitHub/prospect-signal-api | 0 | 0 | 0 |
| Documents/GitHub/prospect-signal-etl | 0 | 0 | 0 |
| Projects/allen-sports-floors | 0 | 0 | 0 |
| **TOTAL** | **23** | **10** | **33** |

### Code hits (action targets — actual API call sites)

**Documents/GitHub/asf-graphics-app (9 hits, 4 files)**
- `backend/services/multi_agent.py:33` — `DOMAIN_MODEL = "claude-sonnet-4-20250514"`
- `backend/services/multi_agent.py:34` — `SYNTHESIZER_MODEL = "claude-sonnet-4-20250514"  # Switch to opus if conflict resolution quality needs improvement`
- `backend/services/lead_classifier.py:73` — `model="claude-sonnet-4-20250514",`
- `backend/routes/consolidation.py:255` — `"model": "claude-sonnet-4-20250514",`
- `backend/routes/ai.py:339` — `model="claude-sonnet-4-20250514",`
- `backend/routes/ai.py:425` — `model="claude-sonnet-4-20250514",`
- `backend/routes/ai.py:475` — `model="claude-sonnet-4-20250514",`
- `backend/routes/ai.py:522` — `model="claude-sonnet-4-20250514",`

**Projects/courtside-pro (7 hits, 1 file)**
- `app.jsx:2658` — `model: 'claude-sonnet-4-20250514', max_tokens: 1000,`
- `app.jsx:3896` — `model: 'claude-sonnet-4-20250514',`
- `app.jsx:4332` — `model: 'claude-sonnet-4-20250514',`
- `app.jsx:4896` — `body: JSON.stringify({ model: 'claude-sonnet-4-20250514', max_tokens: 4000, ... }),`
- `app.jsx:5856` — `metadata: { ..., model_note: 'claude-sonnet-4-20250514' },`
- `app.jsx:5872` — `metadata: { ..., model_note: 'claude-sonnet-4-20250514' },`
- `app.jsx:11162` — `model: 'claude-sonnet-4-20250514',`

**Documents/GitHub/prospect-signal (4 hits, 1 file)**
- `index.html:1139` — `model: "claude-sonnet-4-20250514",`
- `index.html:1667` — `model: 'claude-sonnet-4-20250514',`
- `index.html:2312` — `model: "claude-sonnet-4-20250514",`
- `index.html:2524` — `model: "claude-sonnet-4-20250514",`

**Documents/GitHub/cattlesignal-data-service (1 hit)**
- `index.js:203` — `const SCORE_MODEL = 'claude-sonnet-4-20250514';`

**Documents/GitHub/cattle-signal-api (1 hit)**
- `server.js:167` — `body: JSON.stringify({ model: "claude-sonnet-4-20250514", max_tokens: 3000, ... }),`

**Documents/GitHub/cattlesignal (1 hit)**
- `netlify/functions/chat.js:18` — `const MODEL = process.env.MODEL || 'claude-sonnet-4-20250514';` _(env-overridable; default-only migration; consider also setting MODEL env on Netlify)_

### Doc/archive references (informational — not API call sites)

**Projects/courtside-pro (2)**
- `docs/sprint-i-photo-inspection.md:205`
- `docs/sprint-i-photo-inspection.md:280`

**Projects/Claudious (8 — all expected meta-references about the migration itself)**
- `canonical/active-findings.md:84`
- `canonical/claude-state.md:49`
- `canonical/handoff-active.md:36` _(this audit's own instructions)_
- `learnings/platforms/claude.md:38`
- `scheduled-tasks/scout-additions.md:25`
- `archive/intake/2026-04-17.md:29`
- `alerts.md:22`
- `archive/handoffs/2026-04-19-1959.md:37`

---

## Group B — Undated aliases (review-required)

### Per-repo summary (Group B)

| Repo | Code hits | Doc references | Total |
|---|---:|---:|---:|
| Projects/courtside-pro | 1 | 0 | 1 |
| Projects/Claudious | 0 | 2 | 2 |
| (all others) | 0 | 0 | 0 |
| **TOTAL** | **1** | **2** | **3** |

### Code hits

**Projects/courtside-pro (1 hit)**
- `app.jsx:1063` — `const meta = inspection.analysis_metadata || { photos_analyzed: inspection.photo_count || 1, model: 'claude-sonnet-4', confidence: inspection.confidence || 'medium' };`
  - **Review note:** This is a **default fallback metadata** value, not an API call. The string `'claude-sonnet-4'` is stored as a record annotation when no `analysis_metadata.model` is provided. It is NOT routed to Anthropic. Migration optional but recommended for consistency (`'claude-sonnet-4-6'`).

### Doc references

**Projects/Claudious (2)**
- `learnings/platforms/claude.md:37` — describes the Anthropic deprecation: "the 1M-token context window beta on `claude-sonnet-4-5` and `claude-sonnet-4` retires 2026-04-30"
- `learnings/platforms/claude.md:38` — long line, doc context

No other undated alias hits anywhere.

---

## Group C — 1M-context beta-header references

### Per-repo summary (Group C)

| Repo | Code hits | Doc references | Total |
|---|---:|---:|---:|
| Projects/Claudious | 0 | 16 | 16 |
| (all others) | 0 | 0 | 0 |
| **TOTAL** | **0** | **16** | **16** |

### Result: ZERO code hits across all 12 repos.

No source file contains `context-1m` or `1m-context` as a beta-header literal or otherwise. The Claudious doc references are all bookkeeping/findings/proposals about the upcoming retirement (intake, alerts, runs, retrospectives, archive, canonical state, handoffs).

**Implication:** No code in the audited 12-repo scope passes the `anthropic-beta: context-1m-2025-08-07` (or similar) header. Therefore the 2026-04-30 1M-beta retirement has **no direct API impact** on any caller in scope — only the model-ID retirement does (Group A).

### Doc references (Projects/Claudious only — all expected meta-references)

- `retrospectives/2026-04.md:97`
- `archive/evaluations/processed.log:8`
- `archive/scout/weekly-2026-04-12.md:70`
- `archive/digest/2026-W17.md:10`
- `archive/digest/2026-W17.md:16`
- `alerts.md:22`
- `archive/proposals/1m-context-rollback-investigation.md:1`
- `archive/runs/2026-04-20.md:22`
- `archive/intake/2026-04-20.md:16`
- `archive/retrospectives/pioneer-report-2026-04.md:13`
- `archive/retrospectives/pioneer-2026-04.md:38`
- `learnings/platforms/claude.md:38`
- `archive/queue/deployed.log:21`
- `archive/queue/deployed.log:42`
- `canonical/briefing-today.md:17`
- `canonical/active-findings.md:39` _(actually `cowork-context-1m-to-200k` — distinct topic, Cowork side; not an Anthropic 1M-beta header)_
- `canonical/active-findings.md:134`
- `canonical/handoff-active.md:15`
- `canonical/open-decisions.md:10`
- `canonical/open-decisions.md:11`
- `canonical/handoff-active-mastery.md:105`

---

## Group D — Already-migrated inventory (informational)

### Per-repo count summary

| Repo | claude-sonnet-4-6 / claude-opus-4-7 / claude-haiku-4-5 hits | Files |
|---|---:|---:|
| Projects/Claudious | 31 | 21 |
| Documents/GitHub/asf-graphics-app | 5 | 5 |
| Projects/allen-sports-floors | 0 | 0 |
| Projects/courtside-pro | 0 | 0 |
| Documents/GitHub/alpha-1 | 0 | 0 |
| Documents/GitHub/cattle-signal-api | 0 | 0 |
| Documents/GitHub/cattlesignal | 0 | 0 |
| Documents/GitHub/cattlesignal-data-service | 0 | 0 |
| Documents/GitHub/floortrack-api | 0 | 0 |
| Documents/GitHub/prospect-signal | 0 | 0 |
| Documents/GitHub/prospect-signal-api | 0 | 0 |
| Documents/GitHub/prospect-signal-etl | 0 | 0 |
| **TOTAL** | **36** | **26** |

**Observation:** Only Claudious docs and asf-graphics-app `.claude/agents/` configs reference the new IDs. **No code anywhere in the 12-repo scope has been migrated yet.** The Projects/courtside-pro, Documents/GitHub/prospect-signal, Documents/GitHub/cattlesignal*, Documents/GitHub/cattle-signal-api, and Documents/GitHub/asf-graphics-app `backend/` callers all still pin `claude-sonnet-4-20250514`.

### Files (asf-graphics-app already-migrated config — for reference)

- `Documents/GitHub/asf-graphics-app/.claude/agents/builder.md`
- `Documents/GitHub/asf-graphics-app/.claude/agents/deployer.md`
- `Documents/GitHub/asf-graphics-app/.claude/agents/migrator.md`
- `Documents/GitHub/asf-graphics-app/docs/codebase-state.md`
- `Documents/GitHub/asf-graphics-app/docs/specs/rm-021-design-library-bulk-upload.md`

---

## Suggested migration map

| Legacy ID | New ID |
|-----------|--------|
| `claude-sonnet-4-2025*`, `claude-sonnet-4-5-2025*`, `claude-sonnet-4-5`, `claude-sonnet-4` | `claude-sonnet-4-6` |
| `claude-opus-4-2025*`, `claude-opus-4-1-2025*`, `claude-opus-4` | `claude-opus-4-7` |

---

## Recommended sequencing (suggested — not executed)

1. **Documents/GitHub/asf-graphics-app** (9 code hits, 4 files, all Python `backend/`) — highest concentration; one focused PR. Note `multi_agent.py:34` comment about opus fallback; Logan should decide if SYNTHESIZER_MODEL should now route to `claude-opus-4-7` instead of `claude-sonnet-4-6`.
2. **Projects/courtside-pro** (7 code hits, 1 file `app.jsx`) — single-file change, plus the Group B fallback metadata literal at `app.jsx:1063`.
3. **Documents/GitHub/prospect-signal** (4 code hits, 1 file `index.html`) — single-file change.
4. **Documents/GitHub/cattle-signal-api**, **cattlesignal**, **cattlesignal-data-service** (1 code hit each, 3 files) — small batch; coordinate with `MODEL` env var on Netlify for `cattlesignal/netlify/functions/chat.js`.
5. **Doc references** (Group A doc/archive, Group C bookkeeping) — leave as historical record; do not rewrite history. Optionally update `canonical/claude-state.md:49` and `learnings/platforms/claude.md` if they describe the deprecation in a now-stale way.

---

## Caveats

- **Glob exclude limitation:** the rg `--glob=!asf-graphics-app/**` exclusion did not suppress hits under `Projects/asf-graphics-app/` in raw output; results were filtered in post-processing per the agreed scope. If you re-run any of these commands manually, expect to see those Projects/asf-graphics-app hits and need to filter them out (or use `cd Projects/asf-graphics-app && git status` to confirm the strict-subset relationship before deciding).
- **Group C scope precision:** the `cowork-context-1m-to-200k` finding at `canonical/active-findings.md:39` is about Cowork's context window, not the Anthropic 1M beta. Distinct topic; same substring.
- **No Group A hits for `claude-sonnet-4-5-2025*`, `claude-opus-4-2025*`, or `claude-opus-4-1-2025*`** anywhere in scope. All Group A hits are `claude-sonnet-4-20250514` exclusively.
- **`allen-sports-floors`, `alpha-1`, `floortrack-api`, `prospect-signal-api`, `prospect-signal-etl`:** zero hits in any of the four groups. Either no Anthropic API integration or already-migrated to a non-pinned alias not covered by Group D.
- **Audit is read-only.** No code files modified. This report is untracked at `audits/sonnet-audit-2026-04-26.md`.
