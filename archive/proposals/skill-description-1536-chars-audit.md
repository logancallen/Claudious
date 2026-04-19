# PROPOSED: Expand Skill Descriptions to Use New 1,536-Char Limit
**Finding-ID:** 2026-04-13-skill-description-1536-chars
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Classification:** PROPOSED
**Risk:** SAFE | **Impact:** HIGH | **Effort:** MEDIUM (15+ skills × audit + rewrite)

## What It Does
v2.1.105 raised the skill description character limit from 250 to 1,536 chars. Richer descriptions mean better triggering accuracy — more room for trigger phrases, exclusions, and disambiguation notes.

## Why Not Queued
- Logan has 15+ custom skills across `.claude/skills/`
- Auditing each and rewriting descriptions is a judgment-heavy task (not trivial automation)
- Should be done one skill at a time with tested trigger/exclusion phrasing
- Also the new limit only applies once Claude Code is updated to v2.1.105+ (see bash-permission-bypass proposal — same update)

## Implementation Plan
1. Confirm Claude Code is v2.1.105+ (from separate proposal)
2. List all custom skills: `asf-ux-design`, `ux-reviewer`, `harvest`, `legal-scanner`, `logan-os`, `operating-system`, `financial-modeler`, `skill-creator`, plus document-creation skills
3. For each, expand description to include:
   - Primary trigger phrases Logan actually uses
   - Explicit exclusion cases ("Do NOT trigger for...")
   - Disambiguation vs. adjacent skills (e.g., `asf-ux-design` vs. `ux-reviewer` vs. `design:design-critique`)
4. Test triggering on 3-5 realistic prompts per skill
5. Commit updated SKILL.md files

## Key Cross-Reference
`learnings/behavioral.md` notes: skill triggering is semantic, name+description ONLY. Also: ~34-36 skills before available_skills block truncates. With description expansion, token budget per skill grows — factor into that cap.

## Judgment Call
- Highest ROI on skills that currently mis-trigger (none documented so far, but harvest this from real sessions)
- Deprioritize any skill that already triggers cleanly
- Frame positively (per Claude 4.x behavioral rule) — "Triggers on X, Y, Z" before exclusions

## Where to Document
- Individual SKILL.md files updated in place
- Add completion note to `learnings/techniques.md` Skill YAML Full Spec entry

## Action Required
Logan: authorize the skill audit, or delegate to a dedicated Claude Code session using the `skill-creator` skill.
