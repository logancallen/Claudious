# QUEUED — Add `.claudeignore` + 500-Token CLAUDE.md Target to antipatterns.md

**Finding-ID:** 2026-04-16-claudeignore-500-token-target
**Disposition:** SAFE + HIGH + TRIVIAL — md-only addition complementing existing Bloated CLAUDE.md antipattern with a concrete size ceiling and a `.claudeignore` recipe. No runtime impact, immediate token savings on every turn.
**Target file:** `learnings/antipatterns.md`
**Action:** Append the entry below under `## Active Antipatterns` (above `## Archive`).

---

### 2026-04-16 — ANTIPATTERN — CLAUDE.md Without `.claudeignore` and Size Ceiling
**Severity:** HIGH
**Context:** Source: buildtolaunch.substack token-optimization writeup. Sharpens the existing Bloated CLAUDE.md antipattern with a concrete structural target.
**Learning:** Structural target for CLAUDE.md: "five rules and three file pointers," under ~500 tokens (closer to 200 is better). Each line must answer "would removing this cause a mistake?" — yes = keep, no = cut. Pair with a `.claudeignore` file (gitignore syntax) at project root that strips `node_modules`, `.next`, `dist`, `build`, `*.lock`, `.env*`, and `coverage/` from Claude's visibility entirely. Audit length with `wc -w CLAUDE.md` × ~1.3 = token estimate. If over 500 tokens, move details to `docs/` files referenced by filename, not inlined. Re-measure after Arize prompt-learning iteration to catch bloat regression.
**Applies to:** All Claude Code projects — ASF Graphics, Courtside Pro, Claudious, Claude Mastery Lab

---

**Implementation steps:**
1. Open `learnings/antipatterns.md`
2. Insert the entry above immediately before the `## Archive` section
3. Verify file stays under 200 lines (currently ~24 lines)
4. Commit with message: `learnings: 2026-04-16 ANTIPATTERN — claudeignore + 500-token target`
