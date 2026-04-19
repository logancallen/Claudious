# Config Backup — 2026-04-12

## Files Captured: 5
- alerts.md
- learnings/techniques.md
- learnings/patterns.md
- learnings/gotchas.md
- skills/index.md

## Files Missing: 8 — Not accessible from Cowork sandbox (Windows filesystem)
- C:\Users\logan\.claude\CLAUDE.md
- C:\Users\logan\.claude\MEMORY.md
- C:\Users\logan\.claude\settings.json
- C:\Users\logan\Projects\asf-graphics-app\CLAUDE.md
- C:\Users\logan\Projects\asf-graphics-app\MEMORY.md
- C:\Users\logan\Projects\asf-graphics-app\.claude\hooks\post-commit
- C:\Users\logan\Projects\asf-graphics-app\.claude\hooks\session-start
- C:\Users\logan\Projects\asf-graphics-app\.claude\hooks\session-end

## Total Snapshot Size: ~4 KB

## Notes
Global Claude config and ASF Graphics files are on the Windows filesystem and not accessible from the Cowork sandbox. Only Claudious repo files within the mounted workspace were captured. To capture the full set, run `scripts/backup-config.sh` from a local Claude Code terminal session.
