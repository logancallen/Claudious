# Opus 4.7 Migration Checklist
Created: April 14, 2026
Purpose: Decision framework for migrating from Opus 4.6 to 4.7 when it officially releases.

## Background
Opus 4.6 has a documented 443% token regression vs 4.5. Opus 4.7 is expected to fix this.
Do not migrate blindly — run this checklist first.

## Pre-Migration Tests (run on a known task before switching)

### Test 1 — Token efficiency
Run the same medium-complexity ASF or Courtside Pro task on both 4.6 and 4.7.
Pass criteria: 4.7 token consumption is within 2x of 4.5 baseline (not 4.6 baseline).
Record: input tokens, output tokens, tool calls per task.

### Test 2 — Off-peak vs peak quality consistency
Run the same task at off-peak hours (early morning) and peak hours (afternoon).
Pass criteria: output quality is consistent — no measurable degradation at peak.
This tests the quantization/routing fix hypothesis.

### Test 3 — Existing prompts compatibility
Run existing CLAUDE.md + skills against 4.7 without modification.
Pass criteria: no new refusals, no behavior changes on standard tasks.
Record any unexpected behavior changes.

### Test 4 — Multi-agent task completion
Run an Agent Teams task that previously worked on 4.6.
Pass criteria: coordinator/worker communication is at least as reliable as 4.6.

## Migration Decision
If 2 or more tests pass: migrate immediately to 4.7 as default.
If token regression persists (Test 1 fails): hold at 4.5 for context-heavy tasks, use 4.7 for new features.
If quality variance persists (Test 2 fails): hold at 4.6 until resolved.

## Post-Migration
- Update MEMORY.md global with current model version
- Update logan-current-setup.md model field
- Run one full ASF and one full Courtside Pro session before declaring stable
