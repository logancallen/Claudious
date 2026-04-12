# Graduation Candidate: knowledge-sync-setup

**Source entries:**
- techniques.md → GitHub Closed-Loop Knowledge Sync
- techniques.md → Post-Commit Hook for Auto-Knowledge Updates
- techniques.md → Sync Script for One-Command Knowledge Push
- patterns.md → SessionEnd/Start Hook Chain for Automatic Handoff

**Proposed skill definition:**
```yaml
---
name: knowledge-sync-setup
description: >
  Set up end-to-end knowledge sync between Claude Code, GitHub, and Claude
  Projects. Covers: GitHub repo sync, post-commit hooks for auto-updating
  docs/, sync scripts, and session handoff via handoff.md. Use when setting
  up a new project's knowledge pipeline, when knowledge files drift from code,
  or when session handoffs break. Trigger with: "set up knowledge sync",
  "github sync claude", "knowledge files stale", "session handoff setup",
  "post-commit hook", "sync script".
---
```

**Key content to include:**
1. Store knowledge in docs/ inside GitHub repo
2. Connect Claude Project via GitHub sync
3. Post-commit hook: .claude/hooks/post-commit inspects changes, updates docs/
4. Managed <!-- BEGIN: --> <!-- END: --> blocks for in-place updates
5. Sync script: scripts/sync-knowledge.sh with stale-file warnings
6. Session handoff: .claude/handoff.md written by SessionEnd, read by SessionStart
7. Windows gotchas: git config local (not --global), core.hooksPath verification, LF line endings

**Status:** Queued for review. Implement when Logan approves.
