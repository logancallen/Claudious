# Archive redundant v2-1-x-command-awareness proposal

**Source:** pioneer-2026-04 re-run — open-decisions.md line 164 flags as "redundant"
**Impact:** L (file hygiene)
**Effort:** T
**Risk:** SAFE
**Routing:** SAFE + T + md-only-within-Claudious → QUEUE

## Rationale
`archive/proposals/v2-1-x-command-awareness.md` bundles four minor slash-command awareness items. Substance is already captured in `canonical/claude-code-state.md` (command surface tracked there) and `learnings/techniques.md` Week 15-16 entry (2026-04-19). Proposal is pure duplication — keeping it in proposals/ inflates the bulge metric without carrying new content.

Open-decisions.md line 164 explicitly tags it: "Candidates to defer / close: ... `v2-1-x-command-awareness` (redundant)."

## Implementation
1. Delete `archive/proposals/v2-1-x-command-awareness.md`
2. Remove the `### v2-1-x-command-awareness` block from `canonical/open-decisions.md` (lines 152-155)
3. Update the total count at line 161 from 28 → 27
4. Update line 164 to drop `v2-1-x-command-awareness` from the "Candidates to defer / close" list

## Verification
- `ls archive/proposals/v2-1-x-command-awareness.md` → No such file
- `grep -c "v2-1-x-command-awareness" canonical/open-decisions.md` → 0
- Proposals count drops from 37 → 36 files
