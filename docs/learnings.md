# Claudious — Project Learnings

## Active Learnings

### 2026-04-11 — DECISION — Claudious Architecture
**Severity:** CRITICAL
**Context:** April 11, 2026 design session.
**Learning:** Claudious connects to ALL Claude Projects as global knowledge source. Per-project learnings stay in each project's docs/learnings.md. Cross-project techniques, patterns, gotchas route to Claudious learnings/. Harvest skill produces dual CC prompts: one for project repo, one for Claudious. After both pushes, click Sync in both Claude Project UIs.
**Applies to:** All sessions — routing and sync decisions

### 2026-04-11 — DECISION — Queue vs Proposals Architecture
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** queue/ = SAFE + HIGH impact + TRIVIAL effort items Claude deploys with one-word approval. proposals/ = anything requiring human judgment (User Preferences, production code, schema, deletes). Pioneer never auto-deploys. queue/deployed.log tracks what was actually implemented and whether it worked — Pioneer reads this to calibrate future proposals.
**Applies to:** Pioneer skill, Evaluator scheduled task

### 2026-04-11 — DECISION — Primary vs Fallback Auto-Harvest
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** Primary harvest mechanism is SessionEnd directive in global CLAUDE.md (fires in-context, can read conversation). Daily scheduled task is FALLBACK only — catches sessions where SessionEnd hook was skipped. Never treat scheduled task as primary or duplicates accumulate.
**Applies to:** Auto-harvest architecture

## Archive
