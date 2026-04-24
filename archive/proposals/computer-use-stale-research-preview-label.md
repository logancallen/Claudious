# Computer Use — clear stale "research preview" label in claude-code-state.md

**Source:** archive/intake/2026-04-24.md § B — 2026-04-24-cowork-computer-use-ga
**Credibility:** OFFICIAL
**Impact:** MEDIUM | **Effort:** TRIVIAL | **Risk:** SAFE (single-line canonical edit)

## Summary
`canonical/claude-code-state.md:44` reads:
> - **Computer Use in CLI (research preview)** — Claude opens native apps, clicks through UI, and verifies changes from the terminal.

Per Anthropic's 2026-04 release notes, Computer Use is now available in Claude Cowork and Claude Code for Pro/Max subscribers — scope has expanded beyond "research preview." `learnings/platforms/claude.md:23` already reflects the GA status; canonical file is stale.

## Why proposal (not auto-deploy)
`canonical/claude-code-state.md` is intake-only per the Write-Authority Matrix. Process cannot edit it directly. This proposal surfaces the miss so the next intake run (or Logan) updates the label.

## Suggested edit
Replace line 44 with:
```
- **Computer Use in Cowork + Claude Code (Pro/Max)** — Claude opens native apps, clicks UI, and verifies changes from the terminal. Scope expanded beyond original research preview; Pro/Max subscribers eligible.
```

## Logan action
Option A: let tomorrow's intake catch it (add an explicit instruction to scout-additions.md if it keeps being missed).
Option B: manual edit now — single-line update, commit `canonical: claude-code-state.md — clear stale research-preview label on Computer Use`.
