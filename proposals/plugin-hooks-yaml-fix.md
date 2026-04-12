# Plugin Hooks YAML Frontmatter Bug Fix

**Date:** 2026-04-12
**Priority:** HIGH
**Status:** Action Required
**Note:** Requires manual deployment — outside Implementer scope. Must run `claude update` in CLI environment.

## What It Does
Recent Claude Code updates fixed two bugs:
1. Plugin skill hooks defined in YAML frontmatter were silently ignored
2. Plugin hooks failed with "No such file or directory" when CLAUDE_PLUGIN_ROOT wasn't set

## Implementation Instructions
1. Run `claude update` to get latest Claude Code
2. Test all custom skill hooks — especially any defined in YAML frontmatter
3. If using custom CLAUDE_PLUGIN_ROOT, verify it's set in your environment
4. Re-test any hooks that previously failed silently

## Verification
- After updating, trigger a skill with a hook and confirm the hook fires
- Check Claude Code version with `claude --version`
