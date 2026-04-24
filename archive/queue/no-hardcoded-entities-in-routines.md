# No Hardcoded Entities in Routines
**Source:** archive/intake/2026-04-24.md section D
**Finding id:** constitutional-rule-no-hardcoded-entities-in-routines
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE | **Type:** TECHNIQUE
**Target file:** learnings/techniques.md
**Canonical mirror:** canonical/prompting-rules.md

## Change

```markdown
## No Hardcoded Entities in Routines — 2026-04-24

**Pattern:** Routine prompts, scans, and pipeline configs must reference canonical config files rather than inline people/products/URLs/versions/org state. Inlined lists rot silently; a single edit to a canonical source propagates to every consumer. Exceptions apply to zero-rot entities (protocol names, company names) where drift risk is effectively zero.

**Why it works:** Routines run on a schedule (Claudious intake/process/curate, sibling-repo health checks). When reality moves (new Claude model, renamed MCP server, retired scout target), inlined entities become silent bugs. A canonical config is one edit; inlined lists are N edits across N routines. Quarterly staleness audit catches drift that escapes the one-edit discipline.

**Rule:** any `grep -rE '<hardcoded-entity>' scheduled-tasks/` that returns hits outside a canonical-reference expression is a bug. Re-seeded from 2026-04-19 Grok pipeline adaptability audit.
```

**Canonical mirror block (append under `## Knowledge Architecture`):**

```markdown
### no-hardcoded-entities-in-routines
Routine prompts, scans, and pipeline configs must reference canonical config files rather than inline people/products/URLs/versions/org state. Inlined lists rot silently — routines running on a schedule drift from reality until a canonical reference replaces them. Exceptions for zero-rot entities (protocol/company names). Quarterly staleness audit across canonical config files.
*Source: `learnings/techniques.md` — No Hardcoded Entities in Routines (2026-04-24).*
```

## Verification
grep -c "No Hardcoded Entities in Routines" learnings/techniques.md → must ≥1 after deploy
grep -c "no-hardcoded-entities-in-routines" canonical/prompting-rules.md → must ≥1 after deploy
