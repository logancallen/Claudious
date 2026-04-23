# Proposal — Expand Implementer auto-deploy scope to include antipatterns.md

**Source:** pioneer-2026-04 re-run; deployed.log line 32 (2026-04-17 SKIPPED_OUT_OF_SCOPE)
**Impact:** H (fixes a process bug that currently routes SAFE+HIGH+TRIVIAL items to manual handling)
**Effort:** S (routine edit, but needs testing on next real auto-deploy candidate)
**Risk:** SAFE
**Routing reason:** Changes Implementer routine scope — must be reviewed before going live, not auto-deployed → PROPOSAL

## Description
On 2026-04-17, the Implementer (process routine) correctly identified `claudeignore-500-token-target.md` as SAFE + HIGH + TRIVIAL but rejected the auto-deploy because the target file `learnings/antipatterns.md` was outside the allowed write-scope `[techniques.md, patterns.md, gotchas.md]`. Logan had to deploy it manually on 2026-04-19 (deployed.log line 39).

This is a scope-definition bug, not a tool bug. `antipatterns.md` is a peer file to techniques/patterns/gotchas — there is no principled reason to exclude it. Bloated-CLAUDE.md, ALL-CAPS-in-Claude-4.x, unused-MCPs, CLAUDE.md-without-claudeignore are all HIGH-severity antipattern entries that belong in the auto-deploy pathway.

## Proposed action
Edit `scheduled-tasks/process.md` (or wherever the Implementer scope is defined) to expand allowed write-targets from:

```
[learnings/techniques.md, learnings/patterns.md, learnings/gotchas.md]
```

to:

```
[learnings/techniques.md, learnings/patterns.md, learnings/gotchas.md, learnings/antipatterns.md]
```

Also audit whether `learnings/behavioral.md` and `learnings/cross-project.md` should be in-scope. Recommend leaving those OUT — cross-project items have promotion semantics and behavioral is higher-stakes than the four core logs. One expansion per proposal.

## Why not queued
Changes the contract that the cloud routine operates under. A Claudious routine writing to a previously-excluded file without explicit human sign-off is the exact guardrail the scope list exists to enforce.

## Verification after deploy
Next Implementer run on an antipattern-targeting SAFE+HIGH+TRIVIAL item should auto-deploy rather than SKIP_OUT_OF_SCOPE. Track via deployed.log — if a SKIPPED_OUT_OF_SCOPE appears again for an antipatterns.md target post-deploy, scope logic isn't reading the config.

## Rollback
Single-line revert. Routine is idempotent.
