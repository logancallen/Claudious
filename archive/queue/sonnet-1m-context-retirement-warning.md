# sonnet-1m-context-retirement-warning
**Source:** archive/intake/2026-04-20.md section B-1
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE
**Target file:** learnings/platforms/claude.md

## Change

### 2026-04-20 — TECHNIQUE — Sonnet 4.5 / Sonnet 4 1M Context Beta Retires 2026-04-30
**Severity:** HIGH
**Context:** Anthropic official deprecation: the 1M-token context window beta on `claude-sonnet-4-5` and `claude-sonnet-4` retires 2026-04-30. After that date, those model IDs silently drop back to the base 200K window.
**Learning:** Before 2026-04-30, audit any Sonnet 4.5 / Sonnet 4 pinned callers (Claude Code subagents with `CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6` are unaffected because they target 4.6, but any caller pinned to `claude-sonnet-4-5` or `claude-sonnet-4` that relies on the 1M beta header will degrade). Migration path: switch long-context workloads to Opus 4.7 (native 1M not guaranteed — check current state) or re-chunk to 200K. Grep for `claude-sonnet-4-5`, `claude-sonnet-4-20250514`, and any `beta.*context-1m` header in project configs.
**Applies to:** Any Claude API / Claude Code caller pinned to Sonnet 4.5 or Sonnet 4 with long-context usage — audit window closes 2026-04-30

## Verification
grep -c "1M Context Beta Retires 2026-04-30" learnings/platforms/claude.md  # must be >=1 after deploy
