# Techniques — Cross-Claude Intelligence
<!-- Auto-maintained. Keep under 200 lines. Archive stale entries at bottom. -->

## Active Techniques

### 2026-04-11 — TECHNIQUE — GitHub Closed-Loop Knowledge Sync
**Severity:** CRITICAL
**Context:** Discovered building Courtside Pro — the agent with ground truth should maintain knowledge files.
**Learning:** Store all Claude Project knowledge files in docs/ inside the project GitHub repo. Connect Claude Project to repo via GitHub sync. Claude Code updates docs/ files in same commit as code changes. Hit Sync in Claude Project UI after pushing. Result: knowledge files always current, version-controlled, maintained by the agent with ground truth — never manually by Logan.
**Applies to:** All Claude Projects with a GitHub repo

### 2026-04-11 — TECHNIQUE — MEMORY.md Separation from CLAUDE.md
**Severity:** CRITICAL
**Context:** Discovered during deep architecture research — facts and instructions should live in separate systems.
**Learning:** CLAUDE.md = instructions (what to do). MEMORY.md at ~/.claude/projects/[project]/memory/MEMORY.md = facts (what Claude knows). Mixing them degrades both. MEMORY.md auto-loads into every session's system prompt (first 200 lines / ~25KB). Create one per project, populate with: incidents, gotchas, architecture decisions, current status.
**Applies to:** All Claude Code projects

### 2026-04-11 — TECHNIQUE — Path-Scoped Rules via .claude/rules/
**Severity:** HIGH
**Context:** Rules that only apply in certain directories shouldn't load every message.
**Learning:** Create .claude/rules/ with individual .md files containing YAML frontmatter paths: ["frontend/**"]. Rules only activate when Claude edits files in those paths. Keeps CLAUDE.md lean while enforcing domain-specific standards precisely. Use for frontend/, backend/, migrations/ domains.
**Applies to:** All Claude Code projects with distinct domain directories

### 2026-04-11 — TECHNIQUE — Env Var Layer for Claude Code Tuning
**Severity:** HIGH
**Context:** Discovered via March 2026 source leak — Claude Code has internal controls exposed as env vars.
**Learning:** Add to shell profile: CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 (fixes April 2026 quality nerf), CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000 (extends auto-compact threshold), CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (pins sub-agents to 1M context vs Opus 200k cap), CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true (enables team coordination), CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1 (prevents retry double-work).
**Applies to:** All Claude Code sessions globally — add to shell profile on both Mac and PC

### 2026-04-11 — TECHNIQUE — Skill YAML Full Spec
**Severity:** HIGH
**Context:** Most builders only use name and description — full spec unlocks tool restrictions, effort control, path scoping.
**Learning:** Full skill frontmatter: effort (tiny/small/medium/large/epic), allowed-tools (restrict tool access), paths (scope to directories), model (override per skill), context (none/inherited/fork), agent (spawn sub-agent). Triggering is semantic — name and description ONLY. Add exclusion phrases directly in description text: "Do NOT trigger for: [list]". No negatives: YAML field exists — that field is invalid.
**Applies to:** All Claude Code skills across all projects

### 2026-04-11 — TECHNIQUE — Post-Commit Hook for Auto-Knowledge Updates
**Severity:** HIGH
**Context:** Claude Code should update knowledge files as part of commits, not as an afterthought.
**Learning:** Create .claude/hooks/post-commit that inspects changed files and updates relevant docs/ files. migrations/* → update docs/schema-state.md. source files → update docs/codebase-state.md. functions/* → flag docs/business-rules.md. Use managed <!-- BEGIN: --> <!-- END: --> blocks so hook updates in place without duplicating. Wire with: git config core.hooksPath .claude/hooks (must re-verify each session on PC).
**Applies to:** All Claude Code projects with docs/ knowledge sync

### 2026-04-11 — TECHNIQUE — Sync Script for One-Command Knowledge Push
**Severity:** HIGH
**Context:** Built for Courtside Pro as the final step in the knowledge sync loop.
**Learning:** Create scripts/sync-knowledge.sh that warns on stale docs/ files, commits pending changes with "docs: auto-sync knowledge files", pushes to main, prints Sync reminder listing ALL connected Claude Projects. Run after every session. Wire git identity first using local (not --global) config on Windows when bash doesn't read global config.
**Applies to:** All Claude Code projects with GitHub sync

## Archive
