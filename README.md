# Claudious — Autonomous Claude Nervous System

**Owner:** logancallen
**Purpose:** Self-maintaining shared knowledge layer across Logan's 8 Claude Projects.

---

## What this repo is

Claudious is the global brain for Logan's Claude ecosystem. Every Claude Project (ASF Graphics, Courtside Pro, Genesis Advisory, Claude Mastery Lab, etc.) attaches `canonical/` as project knowledge. Three daily cloud routines keep canonical current without manual tending.

## Repo layout

| Path | Purpose | Attached to Projects? |
|---|---|---|
| `canonical/` | Current-state truth (9 signal-dense files) | **Yes** |
| `archive/` | Dated history (intake, runs, digests, proposals, queue, scout, retrospectives, snapshots, evaluations, project-learnings, research) | No — reference only |
| `scheduled-tasks/` | Cloud routine prompts (intake, process, curate, scout-additions) | No |
| `learnings/` | Raw capture stream; graduates into `canonical/` | No |
| `skills/` | Claude Code skill definitions | No (loaded by Claude Code directly) |
| `mastery-lab/` | Prompting research vault | No |
| `scripts/` | Sync, backup, rollback tooling | No |
| `.github/workflows/` | Auto-merge and daily-briefing email | — |

## Daily pipeline

```
06:00  Intake   → archive/intake/YYYY-MM-DD.md   + canonical/active-findings.md
                                                  + canonical/claude-state.md (on OFFICIAL MODEL-STATE)
                                                  + canonical/claude-code-state.md (on OFFICIAL CC-STATE)

07:00  Process  → archive/queue/*.md              (auto-deploy candidates)
                  archive/proposals/*.md          (judgment calls)
                  learnings/*.md + canonical/prompting-rules.md | canonical/antipatterns.md
                                                  (SAFE+HIGH+TRIVIAL auto-deploys, mirrored)
                  canonical/open-decisions.md     (full regeneration)

20:00  Curate   → archive/digest/YYYY-MM-DD.md    (verbose daily digest)
                  canonical/briefing-today.md     (phone-readable overwrite)
                  canonical/active-findings.md    (prune >7d or graduated)
                  canonical/open-decisions.md     (prune >30d proposals)
                  archive/retrospectives/...      (Sundays — graduation + grading)
```

## Observability

Every push to `main` that changes `canonical/briefing-today.md` triggers `.github/workflows/daily-briefing.yml`, which emails the brief to `loganallensf@gmail.com` via Gmail SMTP. A BROKEN brief is written even when routines fail — the email pipeline is the tripwire.

## Routine details

Each routine file in `scheduled-tasks/` declares:
- `Effort:` — `high` or `xhigh`
- `Task Budget:` — explicit token ceiling (`task-budgets-2026-03-13` beta)
- `Model:` — `claude-opus-4-7`
- `Writes to:` — the file allowlist

Opus 4.7 interprets prompts literally; routines include an explicit literal-interpretation guardrail to prevent silent synthesis.

## Emergency rollback

```bash
# Windows
bash "C:/Users/logan/Projects/Claudious/scripts/rollback-config.sh" YYYY-MM-DD

# Mac
bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD
```

Or `git revert <sha>` on the offending commit.

## Related

- Alerts: `alerts.md` (session-start surfaces CRITICAL items)
- Global Claude Code instructions: `~/.claude/CLAUDE.md` (session-lifecycle + response-self-check)
- Claudious-specific rules: `CLAUDE.md` (this repo)
