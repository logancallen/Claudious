---
proposal_date: 2026-04-22
source: monthly retrospective 2026-04
citation_count: 4
citations:
  - learnings/techniques.md § 2026-04-11 Skill YAML Full Spec
  - learnings/behavioral.md § 2026-04-11 Skill Triggering is Semantic Name+Description Only
  - learnings/gotchas.md § 2026-04-11 Skill negatives YAML Field Does Not Exist
  - learnings/gotchas.md § 2026-04-15 Skill Description Truncation Cap (34-36 skills)
status: awaiting-logan-review
install_path_suggestion: ~/.claude/skills/skill-authoring/SKILL.md
---

# SKILL PROPOSAL — skill-authoring

## Rationale for graduation

Four independent learnings entries, all HIGH severity, all describing rules for authoring Claude Code skills. Currently scattered across techniques/behavioral/gotchas. Consolidating into a single skill means any Claude Code session writing or editing a skill auto-loads the full ruleset on demand.

## Draft SKILL.md

```markdown
---
name: skill-authoring
description: Author, edit, or audit Claude Code skill files (SKILL.md). Use when creating a new skill, editing skill frontmatter, debugging why a skill isn't auto-triggering, or auditing total skill count. Covers YAML frontmatter spec, semantic triggering rules, negative-instruction handling, and the 34-36 skill description truncation cap. Do NOT trigger for skill INVOCATION (running an existing skill) — only for authoring and auditing skill files themselves.
effort: small
allowed-tools: Read, Edit, Write, Glob, Grep
---

# Skill Authoring

## Rule 1 — Triggering is semantic; ONLY name and description influence auto-match

Claude matches skills against the user's request by semantic similarity to the **name** and **description** fields. No other frontmatter field influences auto-triggering. Write descriptions with explicit trigger phrases ("Use when…", "Triggers on…") AND explicit exclusion phrases ("Do NOT trigger for…") inline.

Source: deep architecture research + official skill guide, 2026-04-11.

## Rule 2 — There is no `negatives:` YAML field

Community posts incorrectly reported `negatives:` as a valid field. It is not. To prevent misfires, put exclusions in the description text: `"Do NOT trigger for: staging deploys, preview builds, local testing."`

Source: learnings/gotchas.md § 2026-04-11.

## Rule 3 — Full frontmatter spec (use beyond name/description for control, not triggering)

```yaml
---
name: my-skill                    # required, semantic match
description: …                    # required, semantic match, up to 1,536 chars (raised from 250 in Week 16 April 2026)
effort: tiny|small|medium|large|epic   # optional — controls reasoning depth
allowed-tools: Read, Edit, Bash   # optional — restrict tool access
paths: ["frontend/**"]            # optional — scope to directories
model: claude-opus-4-7            # optional — override model per skill
context: none|inherited|fork      # optional — context isolation
agent: BUILDER                    # optional — spawn sub-agent
---
```

## Rule 4 — Watch the 34-36 skill description truncation cap

When total skill count (global + project scopes) exceeds ~34-36, Claude Code silently truncates skill descriptions in the `available_skills` block. Skills stop matching as cap is crossed. **No error is thrown.** Audit total count with `ls ~/.claude/skills/ && ls .claude/skills/` and consolidate or delete low-value skills when approaching 30.

## Rule 5 — Reframe negatives as positive instructions in description

Claude 4.x/Opus 4.7 fixates on negative instructions ("don't", "never", "avoid"). In skill descriptions and bodies, use positive direction: instead of `"Don't trigger for deploys"`, write `"Trigger only for authoring and auditing — not for running."` See learnings/behavioral.md § 2026-04-11 for the behavioral basis.

## Workflow

1. Check existing skills: `ls ~/.claude/skills/ .claude/skills/`
2. If count ≥ 30: consolidate first, author second.
3. Draft frontmatter with triggering phrases AND exclusions in `description`.
4. Validate: `head -20 SKILL.md` — confirm only `name` and `description` are semantic-match fields.
5. Test triggering by paraphrasing expected user prompts and confirming the skill is listed in `<available_skills>` at session start.
6. Check for bloat: skill descriptions over ~1,500 chars or bodies over ~200 lines should split.
```

## Open questions for Logan

1. Install globally (`~/.claude/skills/`) or Claudious-scoped (`skills/`)? **Recommendation: global** — skill authoring applies across all of Logan's 8 projects, not just Claudious.
2. Should this skill include a verification step that runs `/doctor` after editing a skill? Would add utility but introduces a shell-execution surface the `disableSkillShellExecution` setting may block.

## Install instructions (manual — do not auto-deploy)

```bash
mkdir -p ~/.claude/skills/skill-authoring
# paste SKILL.md body above into ~/.claude/skills/skill-authoring/SKILL.md
# verify with: ls ~/.claude/skills/skill-authoring/
```
