# Claudious — Living Intelligence Base

**Owner:** logancallen
**Purpose:** Fully automated cross-project, cross-platform intelligence system.
Connected to ALL Claude Projects as a global knowledge source.

## This Repo Is Global
Every Claude Project connects here as a knowledge source. Intelligence captured
here is available in every future session across all projects automatically.

## Automated Components
| Component | What It Does | Frequency |
|---|---|---|
| Scout | 6-search web sweep for new techniques + cross-platform | Weekly |
| Evaluator | Triages scout findings against current config | Weekly |
| Pioneer | Proposes self-improvements to Claude config | Monthly |
| Auto-Harvest | Fallback BUG/GOTCHA capture from CC sessions | Daily |
| Retrospective | Prunes, validates, promotes, graduates skills | Monthly |
| Drift Detector | Compares schema docs vs actual DB | Weekly |
| Config Backup | Snapshots all Claude config files | Weekly |
| Digest | Weekly summary of all system outputs | Weekly |
| Handoff Writer | Writes session handoff at session end | Per session |

## Manual Actions (Logan only)
- "approved" after harvest review
- queue/ — deploy ready improvements (~5 min/week)
- proposals/ — review judgment calls (~10 min/month)
- queue/deployed.log — one line when deploying (~10 sec)
- Sync button in Claude Project UI after pushes

## Alert System
alerts.md is checked at every session start. CRITICAL alerts surface immediately.

## Emergency Rollback
bash scripts/rollback-config.sh YYYY-MM-DD

## File Index
- learnings/techniques.md — Claude techniques (cross-project)
- learnings/patterns.md — Architecture and workflow patterns
- learnings/gotchas.md — Silent failures, edge cases
- learnings/behavioral.md — User Preferences candidates
- learnings/antipatterns.md — Token waste, output-degrading patterns
- learnings/platforms/*.md — Platform-specific findings
- skills/index.md — Master index of ALL skills across ALL projects
- scout/ — Weekly web research outputs
- evaluations/ — Triage results + processed.log
- queue/ — Ready-to-deploy improvements + deployed.log
- proposals/ — Improvements needing human judgment
- retrospectives/ — Monthly analysis reports
- snapshots/ — Weekly config backups
- digest/ — Weekly system digests
- alerts.md — Active system alerts

## Graduation Pipeline
1. Learning appears in learnings/*.md
2. Pattern cited 3+ times → retrospective flags as graduation candidate
3. Pioneer generates skill file → queue/ for approval
4. After approval: skill created, learning archived
