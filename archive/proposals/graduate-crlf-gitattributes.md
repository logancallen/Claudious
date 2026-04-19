# Proposal — graduate-crlf-gitattributes

**Source:** intake/2026-04-19.md — Section D, Graduation Candidates
**Impact:** M
**Effort:** T
**Risk:** SAFE
**Routing reason:** IMPACT=M → PROPOSE; also graduation (non-trivial routing)

## Description
CRLF/.gitattributes enforcement pattern appears 3 times across learnings:
1. `learnings/gotchas.md` (2026-04-11) — original entry
2. `learnings/gotchas.md` (cross-project sync 2026-04-18) — second reference
3. `learnings/cross-project.md` — PROMOTE TO CLAUDIOUS directive (2026-04-18)

Meets 3-reference graduation threshold. Graduating to skills/graduated/ would make it proactively triggerable for any new-repo session.

## Proposed action
Create `skills/graduated/gitattributes-lf-enforcement.md` skill that triggers when Claude Code detects a new repo being scaffolded or when shell scripts are present without a .gitattributes file.

## Graduation content
Key rule: Every new repo containing shell scripts, husky hooks, or YAML must ship with .gitattributes in the root commit. Minimum: `* text=auto`, `*.sh text eol=lf`, `.husky/* text eol=lf`, `*.yml text eol=lf`. Also: `git config core.autocrlf false` per-repo on Windows. Verify with `git ls-files --eol`.
