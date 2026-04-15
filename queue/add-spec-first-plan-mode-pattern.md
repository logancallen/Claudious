# QUEUED: Add Spec-First Plan Mode as PATTERN Entry

**Finding-ID:** 2026-04-14-spec-first-plan-mode
**Source:** https://dev.to/lizechengnet/how-to-structure-claude-code-for-production-mcp-servers-subagents-and-claudemd-2026-guide-4gjn
**Classification:** QUEUED (SAFE + HIGH + TRIVIAL, md-only)
**Risk:** SAFE — methodology, no config or dependency changes

## Why Queued
- Scout 2026-04-14 flagged as SAFE
- Logan's User Preferences already contains "Present plan first and wait for explicit approval before writing any code" — this formalizes that rule into a durable file artifact
- No existing entry in `learnings/patterns.md` captures the structured spec-file approach (Scope / Constraints / Acceptance Criteria / Do-Not-Do)
- Plugs a DECISION-category gap noted in retrospective 2026-04-15

## Implementation Steps
Append to `learnings/patterns.md` under "## Active Patterns" (before Archive section):

```
### 2026-04-14 — PATTERN — Spec-First Plan Mode Workflow
**Severity:** HIGH
**Context:** Formalizes Logan's "plan first, approve, then code" User Preference into a repeatable file artifact.
**Learning:** Before any non-trivial feature, create `specs/<feature-name>.md` with four sections: Scope, Constraints, Acceptance Criteria, Do-Not-Do. Start Claude Code in plan mode. Share spec. Prompt: "Review this spec and propose an implementation plan. Do not write code." Iterate on plan — challenge assumptions, require rationale. Only after plan approval, exit plan mode and execute. The Do-Not-Do section is the highest-leverage block: it replaces negative User Preferences instructions with positive constraints scoped to one feature.
**Applies to:** All Claude Code projects — ASF Graphics, Courtside Pro — for any feature >2 files or >30 min estimated work
```

## Verification
- `learnings/patterns.md` gains exactly one new entry, dated 2026-04-14
- File remains under 200 lines
- No content overlap with SessionEnd/Start Hook Chain or 3-Layer Knowledge Architecture entries

## Applies To
`learnings/patterns.md` only — md-only change within Claudious repo.
