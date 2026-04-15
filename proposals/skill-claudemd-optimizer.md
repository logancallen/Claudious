# Skill Proposal — claudemd-optimizer

**Status:** DRAFT — graduation candidate from monthly retrospective
**Created:** 2026-04-15
**Source entries:** techniques.md (MEMORY.md Separation), patterns.md (3-Layer Knowledge Architecture), antipatterns.md (Bloated CLAUDE.md)
**Citation count:** 3 across 3 files
**Install:** Manual review by Logan via Claude Code CLI. Do NOT auto-deploy.

---

## Proposed SKILL.md

```markdown
---
name: claudemd-optimizer
description: Audit and restructure CLAUDE.md to reduce per-message token cost and split knowledge into the right layers. Use when CLAUDE.md exceeds 150 lines, when token usage feels high on simple messages, when setting up a new project's .claude/ directory, or when domain knowledge is bleeding into instructions. Triggers on phrases like "optimize CLAUDE.md," "CLAUDE.md too big," "reduce token cost," "MEMORY.md setup," "split knowledge layers," and "restructure claude config." Do NOT trigger for: writing new instructions, skill creation, or general project documentation.
effort: medium
allowed-tools: [Read, Edit, Write, Glob, Grep, Bash]
---

# CLAUDE.md Optimizer

## The Three Layers
Every Claude Code project should separate knowledge into three layers:
1. **CLAUDE.md** — instructions only (what to do). Loaded every message.
2. **MEMORY.md** at `~/.claude/projects/[project]/memory/MEMORY.md` — facts (what Claude knows). Auto-loads first 200 lines / ~25KB into every session.
3. **.claude/skills/** — on-demand procedures. Loads only when triggered.

Mixing layers degrades all three. The most common failure: domain knowledge in CLAUDE.md, costing tokens on every message.

## Audit Procedure
1. `wc -l CLAUDE.md` — target under 150 lines.
2. Scan for: vendor names, schema details, business rules, historical context, "we tried X and it failed" notes. These belong in MEMORY.md, not CLAUDE.md.
3. Scan for procedural sequences ("when X happens, do Y, Z, W"). These belong in skills, not CLAUDE.md.
4. Scan for negated instructions ("never," "don't," "avoid"). Rewrite as positive direction (Claude 4.x fixates on negatives).
5. Scan for ALL CAPS emphasis. Replace with conditional phrasing — Claude 4.x ignores caps.

## Migration Procedure
1. Create `~/.claude/projects/[project]/memory/MEMORY.md` if absent.
2. Move domain facts from CLAUDE.md → MEMORY.md, organized by topic with H2 headers, key fact in first 2 sentences per section.
3. Move procedural how-tos from CLAUDE.md → individual skills under `.claude/skills/[name]/SKILL.md`.
4. Reduce CLAUDE.md to: project purpose, immutable rules, tool-use protocols, commit conventions.
5. Verify: re-run `wc -l CLAUDE.md`. Should be under 150.

## What Stays in CLAUDE.md
- Project purpose (one paragraph)
- Immutable rules that must fire on every message
- Branching, commit, and PR conventions
- Pointer line: "For project facts see MEMORY.md. For procedures see .claude/skills/."

## What Belongs in MEMORY.md
- Architecture decisions and rationale
- Past incidents and root causes
- Business rules and domain vocabulary
- Current project status, blockers, and decisions in flight

## What Belongs in Skills
- Multi-step procedures
- Diagnostic workflows
- Templates and generators
- Anything that loads only when needed
```

---

## Why graduate
Three entries across three files describe the same architecture problem from three angles: the diagnosis (bloat), the structure (3-layer), and the fix (MEMORY.md separation). One on-demand skill is higher leverage than three scattered references.

## Risks
- LOW: Procedure assumes user has Claude Code project structure. Skill description routes away from non-Claude-Code projects.
- LOW: Overlaps with future `knowledge-sync-setup` skill. Mitigated — this is structural, that one is operational/git-pipeline.

## Next action
Logan reviews this draft. If approved, install via Claude Code CLI to `~/.claude/skills/claudemd-optimizer/SKILL.md`.
