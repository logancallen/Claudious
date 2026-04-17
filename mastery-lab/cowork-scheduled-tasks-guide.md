# Cowork Scheduled Tasks — Canonical Reference

**Status:** SKELETON — seeded incrementally as each task prompt is edited in the Cowork UI.
**Authoritative source:** Cowork UI task editor on Logan's PC. This file mirrors UI prompts for git-visibility, Drift Detector auditing, and reprovisioning safety.
**Last full audit:** April 14, 2026 (audited in Cowork UI, prompts not yet mirrored here).

---

## Maintenance Protocol

When you edit a Cowork task prompt in the UI, also paste the updated prompt into this file under the task's section. This file is the safety net — if Cowork data is lost or needs reprovisioning, these prompts are the recovery source. Pioneer treats this file as the canonical reference when UI drift is suspected.

---

## The 9 Automations

Current cadence (staggered Sundays, 60+ min gaps):

**Cowork Scheduled Tasks (8):**
1. **Scout** — Sun 8:45 AM CDT — Weekly 6-search web sweep for new techniques
2. **Evaluator** — Sun 10:40 AM CDT — Triages Scout findings to queue/ or proposals/
3. **Drift Detector** — Sun 10:10 AM CDT — Compares schema docs vs actual migrations
4. **Retrospective** — Sun 11:10 AM CDT — Prunes, validates, graduates knowledge
5. **Pioneer** — Sun 12:30 PM CDT — Analyzes config, proposes improvements
6. **Digest** — Sun 9:35 PM CDT — Compiles weekly summary for Logan
7. **Evidence Loop** — Weekly — Verifies deployed techniques produced measurable impact
8. **Implementer** — Daily 7:45 AM CDT — Auto-deploys SAFE items from queue/

**Cloud Routines (1):**
1. **Claudious Weekly Health Check** — Sun 8:00 AM CDT — Runs before Scout to provide fresh context. See Cloud Routines section below for full spec.

---

## Task Prompts

### Scout
**Status:** TO SEED — paste current Cowork UI prompt here.

### Evaluator
**Status:** TO SEED.

### Drift Detector
**Status:** TO SEED.

### Retrospective
**Status:** TO SEED.

### Pioneer
**Status:** TO SEED — but has a pending addendum to apply in Cowork UI (see Pioneer Addendum below).

**Pioneer Addendum — Skill Proposed Edits Review (apply to Cowork UI April 16, 2026):**

Add this block to the Pioneer task's "what Pioneer reads/reviews" section in the Cowork UI:

> Read `_proposed-edits/` directories across all known locations: `~/.claude/skills/_proposed-edits/`, `asf-graphics-app/.claude/skills/_proposed-edits/`, `courtside-pro/.claude/skills/_proposed-edits/`. For each proposal file: if confidence HIGH, apply the edit to the underlying skill file and move the proposal to `_proposed-edits/_applied/YYYY-MM-DD-<skill>.md`. If confidence MEDIUM, surface in Pioneer's weekly report for Logan decision. If confidence LOW, archive to `_proposed-edits/_archived/` after 2 weeks without action. Never apply without a git-traceable move — no silent deletes.

### Digest
**Status:** TO SEED.

### Evidence Loop
**Status:** TO SEED.

### Implementer
**Status:** TO SEED.

---

## Cloud Routines (CC-039) — Separate from Cowork

These run on Anthropic cloud infrastructure, laptop-closed. Managed at claude.ai/code/routines.

### Claudious Weekly Health Check
**Schedule:** Sundays 8:00 AM CDT
**Created:** April 16, 2026
**Prompt:** (to seed from claude.ai/code/routines after first "Run now")

---

## Staleness Policy

If a task prompt in this file has a "last updated" date older than 90 days and the Cowork UI version has been edited since, Drift Detector flags it. Resolve by copying the UI version into this file and resetting the date.
