---
proposal_date: 2026-04-22
source: monthly retrospective 2026-04
citation_count: 6
citations:
  - learnings/techniques.md § 2026-04-11 GitHub Closed-Loop Knowledge Sync
  - learnings/techniques.md § 2026-04-11 MEMORY.md Separation from CLAUDE.md
  - learnings/techniques.md § 2026-04-11 Post-Commit Hook for Auto-Knowledge Updates
  - learnings/techniques.md § 2026-04-11 Sync Script for One-Command Knowledge Push
  - learnings/patterns.md § 2026-04-11 3-Layer Claude Code Knowledge Architecture
  - learnings/patterns.md § 2026-04-11 SessionEnd/Start Hook Chain for Automatic Handoff
status: awaiting-logan-review
install_path_suggestion: ~/.claude/skills/knowledge-sync/SKILL.md
---

# SKILL PROPOSAL — knowledge-sync

## Rationale for graduation

Six independent citations across techniques.md (4) and patterns.md (2). All HIGH/CRITICAL. All describe different layers of the same system: how Claude Code keeps project knowledge files in lockstep with ground-truth code, across the 3-layer architecture, with automatic handoffs between sessions. This is the single largest cluster of related learnings in the corpus. Consolidation enables any new Claude project to spin up the full sync loop from one skill invocation.

## Draft SKILL.md

```markdown
---
name: knowledge-sync
description: Set up, audit, or repair the 3-layer Claude Code knowledge sync architecture for a project — CLAUDE.md (instructions), MEMORY.md (facts), skills/ (procedures), plus the GitHub closed-loop that keeps Claude Project knowledge files current. Trigger on "set up knowledge sync", "wire up docs/", "post-commit hook for docs", "session handoff", "3-layer architecture", or "why isn't my Claude Project current". Do NOT trigger for authoring individual skills (use skill-authoring) or for project-specific docs content.
effort: medium
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

# Knowledge Sync Architecture

## The 3-layer model

Separate `.claude/` into three layers. Mixing layers degrades all of them.

| Layer | File(s) | Purpose | Loads when |
|---|---|---|---|
| Instructions | `CLAUDE.md` | What to do (rules) | Every message |
| Facts | `MEMORY.md` (at `~/.claude/projects/[project]/memory/MEMORY.md`) | What Claude knows (incidents, gotchas, decisions, status) | First 200 lines auto-load into system prompt |
| Procedures | `.claude/skills/*.md` | How to do specific things | On-demand per semantic trigger |
| Reference | `docs/*.md` | Static docs (schema, business rules) | RAG retrieval |

## Rule 1 — CLAUDE.md = instructions only

CLAUDE.md loads on every message. Every line costs tokens. Target: under 200 lines (hard cap ~500 tokens structural target per learnings/antipatterns.md 2026-04-16). Domain knowledge belongs in skills or docs — NOT CLAUDE.md.

## Rule 2 — MEMORY.md = facts

One MEMORY.md per project at `~/.claude/projects/[project]/memory/MEMORY.md`. Populate with:
- Incidents (what broke and how it was fixed)
- Gotchas (silent-failure patterns)
- Architecture decisions + rationale
- Current project status

Auto-loads first ~200 lines / ~25KB into every session's system prompt.

## Rule 3 — GitHub closed-loop keeps Claude Project knowledge current

1. Store Claude Project knowledge files in `docs/` inside the project's GitHub repo.
2. Connect the Claude Project to the repo via GitHub sync.
3. Claude Code updates `docs/` files **in the same commit** as the code change that motivated the update.
4. After push, click Sync in the Claude Project UI.

Result: knowledge files always current, version-controlled, maintained by the agent with ground truth.

## Rule 4 — Post-commit hook auto-updates docs/

Wire `.claude/hooks/post-commit` to inspect changed files and update `docs/*.md`:
- `migrations/*` → `docs/schema-state.md`
- source files → `docs/codebase-state.md`
- `functions/*` → flag `docs/business-rules.md`

Use managed `<!-- BEGIN: -->` `<!-- END: -->` blocks so hook updates in-place without duplicating.

Wire: `git config core.hooksPath .claude/hooks` (must re-verify each session on Windows — see learnings/gotchas.md § core.hooksPath).

## Rule 5 — Sync script as one-command knowledge push

`scripts/sync-knowledge.sh` should:
1. Warn on stale `docs/*.md` files (last-modified older than most recent source change).
2. Commit pending changes with `"docs: auto-sync knowledge files"`.
3. Push to main.
4. Print a Sync reminder listing ALL connected Claude Projects by name.

Run after every session. Set git identity with local (not `--global`) config on Windows if bash doesn't read global.

## Rule 6 — SessionEnd/Start hooks = automatic handoff

- SessionEnd directive in CLAUDE.md: prompt Claude to write handoff to `.claude/handoff.md` (completed, pending, blockers, next action).
- SessionStart: reads `handoff.md` and pre-appends to new session.
- Add `handoff.md` to `.gitignore` (local-only).

Primary mechanism is the CLAUDE.md directive (in-context). Avoid scheduled-task-only implementations — those miss ad-hoc sessions.

## Setup checklist for a new project

1. Create `.claude/{skills,hooks,rules}/`.
2. Create `docs/` if missing; add `docs/schema-state.md`, `docs/codebase-state.md` stubs with BEGIN/END blocks.
3. Create `CLAUDE.md` (≤200 lines) — instructions only, pointers to docs and skills.
4. Create `MEMORY.md` at the global path for this project slug.
5. Install `.claude/hooks/post-commit` dispatcher + per-concern `post-commit-*.sh` (see learnings/patterns.md § Roadmap auto-close dispatcher pattern).
6. Install `scripts/sync-knowledge.sh`.
7. Add SessionEnd/SessionStart directives to CLAUDE.md.
8. Run `git config core.hooksPath .claude/hooks` (verify on session start).
9. Connect Claude Project to GitHub. Sync.

## Cross-platform gotchas

- Windows + bash: `git config --global` can silently fail. Use repo-local config.
- Shell scripts need LF line endings. Commit `.gitattributes` with `*.sh text eol=lf`. See cross-project entry 2026-04-18.
- OneDrive corrupts `.git/` — never store repo in OneDrive-synced folder.
```

## Open questions for Logan

1. **MEMORY.md location on Windows** — the spec calls for `~/.claude/projects/[project]/memory/MEMORY.md`. On Windows, that's `%USERPROFILE%\.claude\projects\...`. Does Logan's Claude Code setup actually use that path, or is MEMORY.md colocated with the repo? Install guidance depends on the answer.
2. **Global vs. project scope** — install this skill once at `~/.claude/skills/` and let it work across all 8 projects, or per-project? **Recommendation: global.**
3. **Supersedes** — this skill supersedes 6 learnings entries. After install, should process auto-deploy mark those as "graduated" in the learnings files (with a pointer) or should curate prune them? Need Logan's call since graduated-not-pruned doubles context cost.

## Install instructions (manual — do not auto-deploy)

```bash
mkdir -p ~/.claude/skills/knowledge-sync
# paste SKILL.md body above into ~/.claude/skills/knowledge-sync/SKILL.md
# verify: ls ~/.claude/skills/knowledge-sync/
```
