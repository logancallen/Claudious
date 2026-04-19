# Claudious — Autonomous Claude Nervous System

## Purpose
Single shared knowledge layer across Logan's 8 Claude Projects. Keeps every Claude instance current on model capabilities, Claude Code features, prompting rules, antipatterns, and active findings. Self-maintaining via 3 daily cloud routines.

## Architecture

### `canonical/` — Attached to all project knowledge
Current state, always fresh. 9 files:
- `00-README.md` (orientation)
- `claude-state.md` (current models, features, API)
- `claude-code-state.md` (current CC version, features, env vars)
- `prompting-rules.md` (graduated techniques)
- `antipatterns.md` (known failure modes)
- `toolchain.md` (MCPs, skills, plugins)
- `active-findings.md` (last 7 days of intake)
- `open-decisions.md` (proposals awaiting Logan)
- `briefing-today.md` (today's daily brief → email)

### `archive/` — Not attached, history only
Dated intake, runs ledger, digests, proposals, queue, scout reports, retrospectives, snapshots, evaluations, project-learnings, research. Reference-only via Claude Code.

### `scheduled-tasks/` — Cloud routine prompts
Intake (6am) → Process (7am) → Curate (8pm).

### `learnings/` — Raw capture stream
Written to by routines and manual harvest. Graduates into `canonical/` via process auto-deploys and curate Sunday graduations.

### `skills/`, `mastery-lab/`, `scripts/` — Unchanged
Skills loaded by Claude Code, mastery-lab is the prompting research vault, scripts holds sync/rollback tooling.

## Daily Operation
1. **Intake** (6am) — scans web + repo state → writes to `archive/intake/` + appends new findings to `canonical/active-findings.md` + conditionally updates `canonical/claude-state.md` / `canonical/claude-code-state.md` on OFFICIAL findings.
2. **Process** (7am) — triages findings → `archive/queue/` (auto-deploy candidates) or `archive/proposals/` (judgment calls) → auto-deploys `SAFE+HIGH+TRIVIAL` items to `learnings/*.md` AND mirrors them to `canonical/prompting-rules.md` or `canonical/antipatterns.md`. Regenerates `canonical/open-decisions.md`.
3. **Curate** (8pm) — writes daily digest to `archive/digest/` + OVERWRITES `canonical/briefing-today.md` with a phone-readable brief → commit on main triggers `.github/workflows/daily-briefing.yml` → email lands in Logan's inbox minutes later.

## Observability
Daily briefing flows: curate → `canonical/briefing-today.md` → GitHub Actions → email to loganallensf@gmail.com. A BROKEN brief is still written on dependency failure, so the email pipeline never goes dark.

## Self-Update
Routines update canonical files in place. Since project knowledge is attached directory-scoped to `canonical/`, every canonical edit propagates to all 8 Claude Projects on next sync — no manual re-attachment.

## Write-Authority Matrix

| File | intake | process | curate | manual |
|---|---|---|---|---|
| `canonical/00-README.md` | — | — | — | ✅ |
| `canonical/claude-state.md` | ✅ (OFFICIAL MODEL-STATE only) | — | — | ✅ |
| `canonical/claude-code-state.md` | ✅ (OFFICIAL CC-STATE only) | — | — | ✅ |
| `canonical/prompting-rules.md` | — | ✅ (auto-deploy mirror) | ✅ (Sunday graduations) | ✅ |
| `canonical/antipatterns.md` | — | ✅ (auto-deploy mirror) | ✅ (Sunday graduations) | ✅ |
| `canonical/toolchain.md` | — | — | — | ✅ |
| `canonical/active-findings.md` | ✅ (append) | ✅ (Action field) | ✅ (prune) | — |
| `canonical/open-decisions.md` | — | ✅ (full regen) | ✅ (prune >30d) | — |
| `canonical/briefing-today.md` | — | — | ✅ (overwrite) | — |

## Rules
- Canonical is append-only for intake and process; only curate deletes.
- Every routine declares effort, task-budget, model in its header.
- All routines speak literal-interpretation Opus 4.7 — no silent prompt repair.
- Dated files live under `archive/` only. Never create new dated files at repo root.
- After any manual canonical edit: `git add . && git commit -m "canonical: [file] — [what]" && git push`.

## Emergency Rollback
If a process deploy or curate graduation breaks something:
- Revert the exact commit on main: `git revert <sha>`.
- Or use the snapshot restore: `bash scripts/rollback-config.sh YYYY-MM-DD`.

## Related Scripts
- `scripts/sync-knowledge.sh` — one-command knowledge push.
- `scripts/backup-config.sh` — weekly config snapshot (into `archive/snapshots/`).
- `scripts/rollback-config.sh` — restore config from snapshot.
- `scripts/drift-check.sh` — Run `bash scripts/drift-check.sh` monthly or before any migration work.
