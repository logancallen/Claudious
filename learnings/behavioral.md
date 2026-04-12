# Behavioral — Claude Model Behavior Findings
<!-- Entries here are User Preferences candidates. Review monthly. -->

## Active Behavioral Findings

### 2026-04-11 — BEHAVIORAL — Claude 4.x Fixates on Negative Instructions
**Severity:** CRITICAL
**Context:** DreamHost empirical testing, confirmed in deep architecture research.
**Learning:** Claude 4.x paradoxically increases attention on things you tell it NOT to do. "Don't write a fluffy intro" → Claude focuses on fluff. Fix: reframe ALL negative instructions as positive direction. "Don't write fluffy intro" → "Begin directly with core argument." Applies to CLAUDE.md, skills, User Preferences, prompts. Audit all "never," "don't," "avoid" instructions and rewrite positively.
**Applies to:** User Preferences, all CLAUDE.md files, all skill descriptions, all prompts

### 2026-04-11 — BEHAVIORAL — Context-Before-Question Yields 30% Better Results
**Severity:** HIGH
**Context:** Empirically validated by DreamHost testing on Claude 4.x.
**Learning:** On long-context prompts, place all reference material BEFORE the question. Claude weights end of context most heavily — question at end has maximum attention. For prompts under 5K tokens: doesn't matter. For long prompts (large docs, code, research): always structure as [all context] → [question last].
**Applies to:** All Claude.ai sessions with substantial reference material

### 2026-04-11 — BEHAVIORAL — Adaptive Thinking Nerf (April 2026)
**Severity:** HIGH
**Context:** Community-wide discovery post April 2026 Anthropic update.
**Learning:** Anthropic shipped adaptive thinking throttle in early April 2026 that reduces reasoning depth on routine tasks. Fix: CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 env var bypasses throttling. Also: effortLevel: max in ~/.claude/settings.json. Use /effort high or ultrathink keyword for one-turn deep reasoning.
**Applies to:** All Claude Code sessions — add env var to shell profile

### 2026-04-11 — BEHAVIORAL — Skill Triggering is Semantic Name+Description Only
**Severity:** HIGH
**Context:** Confirmed via deep architecture research and official skill guide.
**Learning:** Claude matches skills semantically against name and description fields ONLY. No other YAML fields influence auto-triggering. Write descriptions with explicit trigger phrases and exclusion phrases inline. Cap: ~34-36 skills before available_skills block truncates and skills stop matching entirely.
**Applies to:** All Claude Code and Claude.ai skill design

## Archive
