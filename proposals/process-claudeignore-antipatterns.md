# Proposal — process-claudeignore-antipatterns

**Source:** intake/2026-04-19.md — Section D, Deploy Calibration
**Impact:** L
**Effort:** T
**Risk:** SAFE
**Routing reason:** IMPACT=L; requires manual action (scope exclusion in queue processor)

## Description
`queue/claudeignore-500-token-target.md` targets `learnings/antipatterns.md`. The automated queue processor excludes antipatterns.md from its allowed targets (only techniques.md, patterns.md, gotchas.md are allowed). This item has been in queue since April 17 and requires manual deployment.

## Proposed action
Logan or next Claude Code session to manually:
1. Read `queue/claudeignore-500-token-target.md`
2. Append the change block to `learnings/antipatterns.md`
3. Verify grep passes
4. `git rm queue/claudeignore-500-token-target.md`
5. Log to deployed.log with evidence

## Alternative
Expand queue processor's allowed target list to include antipatterns.md if it's a recurring target.
