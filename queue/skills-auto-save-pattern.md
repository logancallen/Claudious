# QUEUED — Skills Auto-Save Discovered Patterns as LLM-Optimized Docs

**Finding-ID:** 2026-04-17-skills-auto-save-pattern
**Disposition:** SAFE + HIGH + TRIVIAL — captures the skills lifecycle pattern for all projects.
**Target file:** `learnings/techniques.md`
**Action:** Append the entry below under `## Active Techniques` (above `## Archive`).

---

### 2026-04-17 — TECHNIQUE — Skills as Auto-Saved Pattern Docs from Debugging Sessions
**Severity:** HIGH
**Context:** Source: X/Twitter community (Thariq @trq212) — Claude auto-creates skill files from debugging sessions.
**Learning:** Claude Code can auto-create `.claude/skills/` files from debugging sessions — prompt with "save this debugging pattern as a skill." The resulting skill files are LLM-optimized docs (not generic markdown): they include trigger conditions, known failure modes, and step-by-step resolution. Feed skill files directly into the next session's context via `CLAUDE.md` references or claude.ai Project knowledge. This compounds: each session's learnings become the next session's starting instructions.
**Applies to:** All Claude Code projects — wire into post-debugging workflow on ASF Graphics, Courtside Pro, Claudious

---

**Implementation steps:**
1. Open `learnings/techniques.md`
2. Insert the entry above immediately before the `## Archive` section
3. Verify file stays under 200 lines
4. Commit with message: `learnings: 2026-04-17 TECHNIQUE — skills auto-save pattern docs`
