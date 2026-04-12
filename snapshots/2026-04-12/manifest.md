# Config Backup — 2026-04-12

## Files Captured: 5
- claudious_alerts.md (1.2 KB)
- claudious_learnings_techniques.md (4.6 KB)
- claudious_learnings_patterns.md (2.5 KB)
- claudious_learnings_gotchas.md (3.6 KB)
- claudious_skills_index.md (1.2 KB)

## Files Missing: 8 — Not accessible from Cowork sandbox (Windows filesystem)
- global_CLAUDE.md (~/.claude/CLAUDE.md)
- global_MEMORY.md (~/.claude/MEMORY.md)
- global_settings.json (~/.claude/settings.json)
- asf_CLAUDE.md (Projects/asf-graphics-app/CLAUDE.md)
- asf_MEMORY.md (Projects/asf-graphics-app/MEMORY.md)
- asf_.claude_hooks_post-commit
- asf_.claude_hooks_session-start
- asf_.claude_hooks_session-end

## Total Snapshot Size: ~13 KB

## Notes
Global Claude config and ASF Graphics files are on the Windows filesystem and not accessible from the Cowork sandbox environment. These files can only be backed up from a Claude Code terminal session with direct filesystem access. Consider running `scripts/backup-config.sh` from a local terminal to capture the full set.
