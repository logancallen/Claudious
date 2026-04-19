# Skill Proposal — skill-triggering-guide

**Status:** DRAFT — graduation candidate from monthly retrospective
**Created:** 2026-04-15
**Source entries:** techniques.md (Skill YAML Full Spec), behavioral.md (Skill Triggering is Semantic), gotchas.md (Skill negatives YAML Field)
**Citation count:** 3 across 3 files
**Install:** Manual review by Logan via Claude Code CLI. Do NOT auto-deploy.

---

## Proposed SKILL.md

```markdown
---
name: skill-triggering-guide
description: Diagnose, design, and debug Claude Code skill trigger behavior. Use when a skill is not firing when expected, fires when it shouldn't, or you need to write or audit skill description fields. Triggers on phrases like "skill not triggering," "skill fires incorrectly," "write skill description," "skill YAML," "skill frontmatter," "why didn't [skill] activate," "skills truncated," and "skill cap." Do NOT trigger for: skill content authoring, skill creation from scratch (use skill-creator), or general Claude Code config questions.
effort: small
allowed-tools: [Read, Edit, Glob, Grep]
---

# Skill Triggering Guide

## Core Rules
1. Triggering is semantic and uses ONLY the `name` and `description` fields. No other YAML field influences auto-triggering.
2. There is no `negatives:` YAML field. Add exclusion phrases inline in the description: "Do NOT trigger for: [list]."
3. Available-skills block truncates around 34-36 skills. Past that cap, skills silently stop matching.
4. Claude 4.x fixates on negated language. Phrase trigger and exclusion guidance as positive direction wherever possible.

## Description Anatomy
A high-quality description has four sections:
- **What it does** (one sentence, concrete verb).
- **When to use** (3-7 trigger phrases the user actually says).
- **What NOT to use it for** (inline exclusions, prefixed "Do NOT trigger for:").
- **Routing notes** (which sibling skill to use instead, if relevant).

## YAML Frontmatter Full Spec
- `name` — kebab-case identifier
- `description` — semantic trigger surface (see anatomy above)
- `effort` — tiny / small / medium / large / epic
- `allowed-tools` — list of tool names to restrict access
- `paths` — directory glob list to scope where skill applies
- `model` — override per skill
- `context` — none / inherited / fork
- `agent` — spawn dedicated sub-agent

## Debugging Workflow
1. Verify skill is in `available_skills` block (not truncated past the cap).
2. Re-read the user's actual phrasing — does the description contain at least one of those trigger words or close synonyms?
3. Check sibling skills with similar descriptions — Claude may be selecting a closer match.
4. Add explicit "Do NOT trigger for:" line for the false-positive case, or add the missing trigger phrase to the description.
5. If 34+ skills are loaded, prune unused skills before adding more.

## Cap Mitigation
- Audit `~/.claude/skills/` and `.claude/skills/` — disable rarely-used skills.
- Group related procedures into one skill with internal sections rather than 3-4 micro-skills.
- Prefer plugins for domain-bundled skill sets (loaded only when plugin is active).
```

---

## Why graduate
Three independent entries across techniques, behavioral, and gotchas all converge on the same operational knowledge. A single on-demand skill removes redundancy and gives a single authoritative reference Logan can cite when debugging. Estimated token cost: ~600 tokens loaded only when triggered.

## Risks
- LOW: Adds one more skill toward the 34-36 cap. Mitigated because the skill itself documents the cap.
- LOW: Description may overlap with `skill-creator`. Mitigated by explicit routing note ("for skill creation use skill-creator").

## Next action
Logan reviews this draft. If approved, install via Claude Code CLI to `~/.claude/skills/skill-triggering-guide/SKILL.md` and remove or shorten the three source learnings entries to a one-line pointer.
