# Briefing — Today

**Last updated:** 2026-04-19
**Status:** No briefing yet — `curate` routine has not run today.

---

## Format

This file is rewritten daily by the `curate` routine. Keep it phone-readable — terse, scannable, no buried detail. Target ≤30 lines, ≤500 words.

```
# Briefing — YYYY-MM-DD

## System Health
- Intake: <status>  Process: <status>  Curate: <status>
- Week: <healthy | degraded | broken | bootstrapping>  Grade: <A | B | C>

## Action Required
- <kebab-id>: <1-line — what Logan needs to do>
- (only real items; empty list = "None today")

## Shipped Overnight
- <kebab-id>: <1-line — what the routine deployed>

## Alerts
- <CRITICAL / HIGH alerts, if any>

## Findings Worth Surfacing
- <0–3 items from active-findings.md that touch today's work>
```

---

## Placeholder (until first curate run populates this)

### System Health
Not yet running through new canonical-aware routines. Seed populated 2026-04-19 by canonical restructure.

### Action Required
- See `canonical/open-decisions.md` — 28 proposals awaiting review. Top 3: `skill-description-1536-chars-audit`, `context-mode-mcp-plugin`, `rollback-path-windows-tilde-bug`.

### Alerts
- CRITICAL: ASF-GRAPHICS migrations 026–028 broke employee permissions. Do NOT run new migrations until audit session. (Active since 2026-04-14.)
- HIGH: Skill description limit 250→1,536 chars — 15+ custom descriptions pending re-expansion.
- HIGH: `context-mode` MCP plugin pending test (50–90% token reduction claim).

### Findings Worth Surfacing
- `cowork-context-1m-to-200k` — verify any workflow depending on 1M Cowork context.
- `rollback-path-windows-tilde-bug` — emergency rollback may silently fail on Windows.
