# operating-model-5-parts
**Source:** archive/intake/2026-04-20.md section B-6
**Impact:** MEDIUM | **Effort:** LOW | **Risk:** SAFE
**Type:** COMMUNITY TECHNIQUE / META
**Target (proposed):** meta consolidation — canonical/prompting-rules.md

## Finding
Emerging "OS for AI dev" framework (community): (1) keep always-on context small, (2) procedures → skills/commands, (3) protect active sessions from context pollution, (4) parallelize only with supervision + isolation, (5) short focused sessions over marathons. Source: https://medium.com/@richardhightower/claude-code-2026-the-daily-operating-system-top-developers-actually-use-d393a2a5186d

## Overlap with existing rules
- (1) already in `canonical/prompting-rules.md` (small context footprint).
- (2) already reflected by Claudious skills/ and scheduled-tasks/ architecture.
- (3) overlaps with `session-checkpointing-before-autonomous-runs` (graduation candidate — see D3).
- (4) overlaps with `--worktree` + agent teams guidance.
- (5) overlaps with `/compact` and session-hygiene techniques.

## Decision needed
Is this a consolidation candidate (i.e. write a single "five-part operating model" meta-rule in `canonical/prompting-rules.md` that cross-links the existing rules), or treat as informational only? Low novelty — most components are already deployed, but the **framing** could help session-start orientation.

## Why not auto-queue
MEDIUM + meta-level — needs Logan's judgment on whether canonical/prompting-rules.md gets a new top-level framework section, or this stays informational.
