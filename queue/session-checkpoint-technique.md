# QUEUED — Session Checkpointing Before Autonomous Claude Runs

**Finding-ID:** 2026-04-17-session-checkpoint-technique
**Disposition:** SAFE + HIGH + TRIVIAL — direct operational improvement for all autonomous Claude Code runs. Single additive learning, no config required.
**Target file:** `learnings/techniques.md`
**Action:** Append the entry below under `## Active Techniques` (above `## Archive`).

---

### 2026-04-17 — TECHNIQUE — Git Checkpoint Before Every Autonomous Claude Run
**Severity:** HIGH
**Context:** Source: X/Twitter community (Thariq @trq212) — higher success rate than in-session repair.
**Learning:** Commit a git checkpoint before any autonomous or multi-step Claude run: `git add -A && git commit -m "checkpoint: pre-claude-run"`. If the result is wrong, rollback with `git reset --hard HEAD~1` instead of attempting in-session repair — rollback is faster and more reliable than forward-fixing Claude errors mid-run. This is especially important before /ultraplan runs, long Cowork sessions, and any agent-teams invocation.
**Applies to:** All Claude Code projects — ASF Graphics, Courtside Pro, Claudious, Claude Mastery Lab

---

**Implementation steps:**
1. Open `learnings/techniques.md`
2. Insert the entry above immediately before the `## Archive` section
3. Verify file stays under 200 lines
4. Commit with message: `learnings: 2026-04-17 TECHNIQUE — git checkpoint before autonomous runs`
