# Graduation Candidate: skill-triggering-guide

**Source entries:**
- techniques.md → Skill YAML Full Spec
- behavioral.md → Skill Triggering is Semantic Name+Description Only
- gotchas.md → Skill negatives: YAML Field Does Not Exist

**Proposed skill definition:**
```yaml
---
name: skill-triggering-guide
description: >
  Debug and optimize Claude Code skill triggering. Use when a skill fires
  incorrectly, fails to trigger, or needs description tuning. Covers YAML
  frontmatter spec, semantic matching rules, exclusion phrase patterns, and
  the ~34-36 skill cap. Trigger with: "skill not firing", "skill misfires",
  "write skill description", "skill YAML help", "debug skill trigger".
---
```

**Key content to include:**
1. Triggering is semantic — name and description ONLY influence matching
2. No negatives: YAML field exists — use inline "Do NOT trigger for:" in description
3. Full YAML frontmatter spec: effort, allowed-tools, paths, model, context, agent
4. Cap: ~34-36 skills before available_skills block truncates
5. Description writing best practices with trigger and exclusion phrases

**Status:** Queued for review. Implement when Logan approves.
