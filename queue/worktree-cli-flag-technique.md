# QUEUED — Add `--worktree` / `-w` CLI Flag to techniques.md

**Finding-ID:** 2026-04-16-worktree-cli-flag
**Disposition:** SAFE + HIGH + TRIVIAL — direct upgrade to Logan's existing split-and-merge worktree pattern. Single additive flag, no config required.
**Target file:** `learnings/techniques.md`
**Action:** Append the entry below under `## Active Techniques` (above `## Archive`).

---

### 2026-04-16 — TECHNIQUE — Native `--worktree` Flag Replaces Manual Split-and-Merge Setup
**Severity:** HIGH
**Context:** `claude --worktree <name>` (or `-w <name>`) collapses the create-worktree → cd → launch-claude sequence into one command per parallel agent. Direct upgrade to the split-and-merge pattern Logan already uses.
**Learning:** Use `claude -w api-refactor`, `claude -w ui-polish`, etc. per terminal to spin up isolated parallel sessions. Auto-creates an isolated git worktree, checks out `worktree-{name}` branch from `origin/HEAD`, and scopes the Claude session to that directory. With no argument, generates a name automatically. Headless via tmux: `claude --worktree <name> --tmux`. Practical limit: 5-10 parallel sessions before merge bottleneck and rate-limit throttling. Pro-tier users hit limits in minutes with 2+ parallel sessions — Max tier required for serious scaling.
**Applies to:** All Claude Code projects using parallel-agent workflows — ASF Graphics, Courtside Pro, Claudious

---

**Implementation steps:**
1. Open `learnings/techniques.md`
2. Insert the entry above immediately before the `## Archive` section
3. Verify file stays under 200 lines (currently ~66 lines)
4. Commit with message: `learnings: 2026-04-16 TECHNIQUE — native worktree flag`
