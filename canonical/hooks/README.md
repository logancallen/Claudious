# Canonical Claude Code Hooks

These are the canonical pre/post-tool hooks for Claude Code. They live here so
they can sync across machines via git.

After pulling this repo on a new machine, copy the hooks into your local
Claude Code config:

```bash
# macOS / Linux
cp canonical/hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

```powershell
# Windows (PowerShell)
Copy-Item canonical\hooks\*.sh $env:USERPROFILE\.claude\hooks\
```

`~/.claude/settings.json` should reference these hooks under `hooks.PreToolUse`
and `hooks.PostToolUse`. Edits made directly in `~/.claude/hooks/` are local —
to make a change permanent and cross-machine, edit the file here, commit, and
re-copy on each machine.

## Hooks

- **pre-bash-safety.sh** — PreToolUse hook for the `Bash` tool. Blocks
  genuinely destructive operations (`--force`, `--hard`, `rm -rf /`,
  `DROP TABLE`, `TRUNCATE … CASCADE`) while allowing normal git workflow,
  including direct pushes to `main` per repo policy. Verified by a 31-case
  test suite.
