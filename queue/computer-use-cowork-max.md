# Queue Item — computer-use-cowork-max

**Source:** intake/2026-04-19.md — Section B, Search 4
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/platforms/claude.md

## Change block

```
### 2026-04-19 — TECHNIQUE — Computer Use in Cowork (Max Plan, No Setup)
**Severity:** HIGH
**Context:** Anthropic released Computer Use via Cowork to Pro and Max plan subscribers in April 2026.
**Learning:** Computer Use is now available in Cowork for Max plan (Logan eligible). Claude can open files, run dev tools, point/click/navigate the screen inside the sandbox. No setup required — it activates in Cowork automatically. Best use: UI validation tasks, running test suites, file operations that benefit from visual confirmation. Constraint: Cowork sandbox still cannot access multiple repos simultaneously (see gotchas.md).
**Applies to:** All Cowork sessions on Max plan
```

## Verification grep

`grep -c "Computer Use in Cowork" learnings/platforms/claude.md`
