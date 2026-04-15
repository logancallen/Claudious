# Claudious — Claude Code Instructions

## Purpose
Global intelligence base for Logan's entire Claude ecosystem.
Connected to ALL Claude Projects. Fully automated capture and deployment.

## Rules
- Append-only — move stale entries to Archive, never delete
- Every entry self-contained — no cross-references that break RAG
- Entry format: date, category, severity, context, learning, applies-to
- Keep each file under 200 lines — create new files when approaching limit
- After any change: git add . && git commit -m "learnings: [date] [category] — [title]" && git push

## Entry Format
### [DATE] — [CATEGORY] — [Title]
**Severity:** CRITICAL / HIGH / LOW
**Context:** [1 sentence — what was happening]
**Learning:** [Specific, actionable insight]
**Applies to:** [Projects, files, workflows, or platforms affected]

## Categories
- BUG — Root cause + fix
- PATTERN — Reusable architecture or workflow pattern
- GOTCHA — Silent failure, non-obvious behavior, edge case
- DECISION — Architecture decision with rationale
- TECHNIQUE — Claude/tool/workflow technique that improved output
- DOMAIN — Business or domain knowledge
- PERF — Performance finding with specific numbers
- BEHAVIORAL — Claude behavior finding affecting User Preferences
- ANTIPATTERN — Token waste or output-degrading pattern

## Emergency Rollback
If a Pioneer-queued change breaks something:
bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD

## Related Scripts
- scripts/sync-knowledge.sh — one-command knowledge push
- scripts/backup-config.sh — weekly config snapshot
- scripts/rollback-config.sh — restore config from snapshot
- scripts/drift-check.sh — Run `bash scripts/drift-check.sh` monthly or before any migration work
