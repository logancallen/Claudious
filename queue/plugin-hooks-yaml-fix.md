# QUEUED: Plugin Hooks YAML Frontmatter Bug Fix
**Finding-ID:** 2026-04-12-plugin-hooks-yaml-fix
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
Recent Claude Code updates fixed two bugs:
1. Plugin skill hooks defined in YAML frontmatter were silently ignored
2. Plugin hooks failed with "No such file or directory" when CLAUDE_PLUGIN_ROOT wasn't set

If any custom skill hooks weren't firing, this is likely why.

## Implementation Instructions
1. Run `claude update` to get latest Claude Code
2. Test all custom skill hooks — especially any defined in YAML frontmatter
3. If using custom CLAUDE_PLUGIN_ROOT, verify it's set in your environment
4. Re-test any hooks that previously failed silently

## Where to Document
- Log result in `queue/deployed.log` after update

## Verification
- After updating, trigger a skill with a hook and confirm the hook fires
- Check Claude Code version with `claude --version`
