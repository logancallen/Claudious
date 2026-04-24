# Logan Machine State

**Purpose:** Source-of-truth for per-machine repo paths and migration state. Overrides stale user-memory entries. Next Mastery Lab chat should reconcile `userMemories.recent_updates` against this file.

---

## Repo canonical paths — Windows PC (as of 2026-04-24)

- **Claudious:** `C:\Users\logan\Projects\Claudious` — **canonical, active.** All CC routines, all recent commits, all Session #3–#5 investigation work runs here. Heartbeat emitted from here (`logan-pc.json`). Preflight hook installed at `.claude/hooks/preflight.sh`.
- **asf-graphics-app:** verify on next ASF session. Prior memory claimed `C:\Users\logan\Projects\asf-graphics-app`.
- **courtside-pro:** verify on next Courtside session. Prior memory claimed `C:\Users\logan\Projects\courtside-pro`.

## Repo canonical paths — Mac Studio

- **Claudious:** `~/Documents/GitHub/Claudious` — canonical. Heartbeat `mac-studio.json`.
- Other repos: verify per-session.

## Migration to `C:\Users\logan\Documents\GitHub\` (PC) — NOT SCHEDULED

Aspirational target, not current reality. User memory text claiming `C:\Users\logan\Projects\` is DEPRECATED is **premature** — production runs on `Projects\` today.

Requires a dedicated session to execute:

1. Verify no unpushed commits on any repo at old path (per-repo `git log origin/main..HEAD` + `git stash list`)
2. Verify no unresolved stashes
3. Update `.claude/settings.json` in each repo (absolute paths to hooks, scripts)
4. Update `scripts/sync-knowledge.sh` DIRS list if it carries absolute paths (already-logged MEDIUM bug — Phase B of 2026-04-24 overnight queue)
5. Re-clone at new paths; confirm CC routines pick up without breakage (run one cloud routine cycle end-to-end before deleting old path)
6. Delete old-path clones only after new-path validation

**Do not treat `Projects\` as deprecated until migration actually runs.** User memory claiming deprecation while production runs on `Projects\` creates routing landmines for every chat — the user memory and canonical reality must agree.

## User memory reconciliation

The `userMemories.recent_updates` line currently reads (paraphrase):

> Windows canonical clone path for all GitHub repos is `C:\Users\logan\Documents\GitHub\` … `C:\Users\logan\Projects\` is DEPRECATED — any clones remaining there are stale and should be deleted once verified to have no unpushed commits and no stashes.

This should be replaced (by Logan in a Mastery Lab chat) with something like:

> Active Windows clone paths: Claudious at `C:\Users\logan\Projects\Claudious` (canonical). asf-graphics-app and courtside-pro paths pending next-session verification. Migration to `C:\Users\logan\Documents\GitHub\` is proposed but NOT executed — do not treat `Projects\` as deprecated.

CC cannot edit user memory directly; this canonical file is the handoff mechanism.
