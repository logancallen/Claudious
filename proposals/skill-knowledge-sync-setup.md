# Skill Proposal — knowledge-sync-setup

**Status:** DRAFT — graduation candidate from monthly retrospective
**Created:** 2026-04-15
**Source entries:** techniques.md (GitHub Closed-Loop Sync, Post-Commit Hook, Sync Script), patterns.md (SessionEnd/Start Hook Chain)
**Citation count:** 4 across 2 files
**Install:** Manual review by Logan via Claude Code CLI. Do NOT auto-deploy.

---

## Proposed SKILL.md

```markdown
---
name: knowledge-sync-setup
description: Set up the end-to-end GitHub-synced knowledge pipeline for a Claude Code project — post-commit hooks that update docs/, sync script for one-command push, and SessionStart/SessionEnd handoff chain. Use when bootstrapping a new project's knowledge sync, when knowledge files in a Claude Project go stale, when sessions lose continuity between Claude Code restarts, or when post-commit hooks aren't firing. Triggers on phrases like "set up knowledge sync," "github sync claude," "knowledge files stale," "session handoff broken," "post-commit hook," and "sync script setup." Do NOT trigger for: writing the actual knowledge content (use docs/), or general git setup.
effort: large
allowed-tools: [Read, Edit, Write, Bash, Glob]
---

# Knowledge Sync Setup

## The Pipeline
Code change → post-commit hook updates `docs/` → sync script pushes → Claude Project pulls → SessionEnd writes handoff → SessionStart reads it. Six links, each can break silently.

## Step 1 — GitHub-Synced Project Knowledge
1. Store all Claude Project knowledge files in `docs/` inside the project repo.
2. In Claude Project UI, connect to repo via GitHub sync.
3. After every push, hit Sync in Claude Project UI (or rely on the sync script's reminder list).

## Step 2 — Post-Commit Hook
Create `.claude/hooks/post-commit`:
- Inspect changed files.
- `migrations/*` changed → update `docs/schema-state.md`.
- Source files changed → update `docs/codebase-state.md`.
- `functions/*` changed → flag `docs/business-rules.md` for review.
- Use managed blocks `<!-- BEGIN: section -->` and `<!-- END: section -->` so the hook updates in place.

Wire it: `git config core.hooksPath .claude/hooks`. On Windows PC, verify at start of each session — `git config core.hooksPath` may not persist.

## Step 3 — Sync Script
Create `scripts/sync-knowledge.sh`:
- Warn on stale `docs/` files.
- Stage and commit: `git commit -m "docs: auto-sync knowledge files"`.
- Push to main.
- Print a "Sync these Claude Projects" reminder list.

Run after every session.

## Step 4 — Session Handoff Chain
- **CLAUDE.md SessionEnd directive:** "At session end, write `.claude/handoff.md` with sections: Completed, Pending, Blockers, Next Action."
- **CLAUDE.md SessionStart directive:** "At session start, read `.claude/handoff.md` if present and incorporate as initial context."
- Add `.claude/handoff.md` to `.gitignore`.
- The CLAUDE.md directive is the primary mechanism. A scheduled task is fallback only.

## Step 5 — Windows Gotchas
- `git config --global` may not stick for bash sessions on PC. Use repo-local `git config user.email` to set identity.
- `git config core.autocrlf false` before committing any `.sh` or hook file. Re-add and recommit if CRLF leaked in.
- Verify `core.hooksPath` at the start of every session — re-run if empty.

## Verification Checklist
- [ ] `docs/` directory exists with at least one knowledge file
- [ ] Claude Project connected to repo, last sync within 24h
- [ ] `.claude/hooks/post-commit` is executable
- [ ] `git config core.hooksPath` returns `.claude/hooks`
- [ ] `scripts/sync-knowledge.sh` exists and is executable
- [ ] CLAUDE.md contains SessionStart and SessionEnd directives
- [ ] `.claude/handoff.md` is in `.gitignore`
```

---

## Why graduate
Four entries describe one pipeline. Today they live in three places. As the pipeline gets adopted across more projects (ASF Graphics, Courtside Pro, Mythos), having one procedural skill instead of four scattered learnings is the difference between "I remember reading something about hooks" and "run knowledge-sync-setup."

## Risks
- MEDIUM: Skill is large (effort: large) — may be too long for some sessions. Mitigated by the 5-step structure, which lets Claude jump to the failing step.
- LOW: Windows-specific gotchas may not apply on Mac Studio. Mitigated — Step 5 is conditional and labeled.

## Next action
Logan reviews this draft. If approved, install via Claude Code CLI to `~/.claude/skills/knowledge-sync-setup/SKILL.md` and shrink the four source entries to one-line pointers.
