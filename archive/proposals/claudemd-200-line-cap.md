# claudemd-200-line-cap
**Source:** archive/intake/2026-04-20.md section B-2
**Impact:** MEDIUM | **Effort:** TRIVIAL | **Risk:** SAFE
**Type:** COMMUNITY TECHNIQUE
**Target (proposed):** learnings/techniques.md or prompting-rules mirror

## Finding
Community best practice: keep root CLAUDE.md under 200 lines; push details into skills / `@imports`; use nested CLAUDE.md indexes in subdirectories to prevent Claude from doing expensive exploratory searches on every session start. Source: https://amitray.com/best-practices-for-claude-md/

## Current state
- Claudious root `CLAUDE.md`: ~100 lines — well within budget.
- User Preferences (out of scope for this repo) — unknown size.

## Decision needed
Graduate as a general technique in `learnings/techniques.md` OR promote directly to `canonical/prompting-rules.md` (since it's a meta-rule about project config files). Recommended: add to `learnings/techniques.md` now, flag for `canonical/prompting-rules.md` mirror once a 2nd citation surfaces.

## Why not auto-queue
COMMUNITY source + MEDIUM impact (Logan's file is already compliant) — does not meet SAFE+HIGH+TRIVIAL bar.
