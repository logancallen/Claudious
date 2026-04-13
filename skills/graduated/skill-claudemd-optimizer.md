# Graduation Candidate: claudemd-optimizer

**Source entries:**
- techniques.md → MEMORY.md Separation from CLAUDE.md
- patterns.md → 3-Layer Claude Code Knowledge Architecture
- antipatterns.md → Bloated CLAUDE.md with Domain Knowledge

**Proposed skill definition:**
```yaml
---
name: claudemd-optimizer
description: >
  Optimize CLAUDE.md structure and reduce per-message token cost. Use when
  CLAUDE.md exceeds 150 lines, when domain knowledge is mixed with instructions,
  or when setting up the 3-layer knowledge architecture (instructions / memory /
  reference). Trigger with: "optimize CLAUDE.md", "CLAUDE.md too big",
  "reduce token cost", "set up MEMORY.md", "knowledge architecture",
  "restructure claude config".
---
```

**Key content to include:**
1. CLAUDE.md = instructions only (fires every message)
2. MEMORY.md = facts at ~/.claude/projects/[project]/memory/MEMORY.md (auto-loads first 200 lines)
3. Skills = on-demand procedures (only load when triggered)
4. Domain knowledge → docs/knowledge/ or .claude/skills/
5. Target: CLAUDE.md under 150 lines
6. Step-by-step migration procedure

**Status:** Queued for review. Implement when Logan approves.
