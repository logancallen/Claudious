# Proposal — Close bash-permission-bypass-patch as auto-resolved

**Source:** pioneer-2026-04 re-run; evidence from archive/proposals/superpowers-trial-log.md (CC baseline 2.1.116)
**Impact:** L (proposals hygiene — backlog bulge reduction)
**Effort:** T (delete one file, edit open-decisions.md)
**Risk:** SAFE — verification already done upstream
**Routing reason:** Judgment call — Logan should confirm the resolution before the proposal is archived (version verification on BOTH machines matters for a security patch) → PROPOSAL

## Description
`archive/proposals/bash-permission-bypass-patch.md` (dated 2026-04-13) instructs Logan to update Claude Code to ≥v2.1.98. Evidence 2026-04-22: Logan is running v2.1.116 (from `superpowers-trial-log.md`). `canonical/open-decisions.md` line 162 already notes the proposal is "likely resolved by version upgrade."

## Proposed action
1. Logan confirms `claude --version` on BOTH Mac and PC returns ≥v2.1.98 (preferably ≥v2.1.105 for full fix set per the proposal text).
2. If confirmed on both: delete `archive/proposals/bash-permission-bypass-patch.md`; remove the `### bash-permission-bypass` block from `canonical/open-decisions.md` (lines 32-36); decrement the total active count.
3. If one machine is behind: run `claude update` there first, then archive.
4. Log deploy result in `archive/queue/deployed.log` as `2026-04-XX ARCHIVED bash-permission-bypass-patch — Verified ≥v2.1.98 on Mac + PC. Closed as auto-resolved.`

## Why not queued
Security-patch status verification is a judgment call. Auto-deploying an archive-and-delete on a security proposal without Logan confirming both machines is the wrong default even though the single data point is strong.

## Rollback
If closure is wrong (e.g., one machine is actually behind), re-create the proposal from git history (`git show HEAD~1:archive/proposals/bash-permission-bypass-patch.md > archive/proposals/bash-permission-bypass-patch.md`).
