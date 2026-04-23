---
proposal_date: 2026-04-22
source: monthly retrospective 2026-04
citation_count: 5
citations:
  - learnings/gotchas.md § 2026-04-15 OneDrive Corrupts .git Index Files (CRITICAL)
  - learnings/gotchas.md § 2026-04-11 Windows Bash git config --global Not Sticking
  - learnings/gotchas.md § 2026-04-11 CRLF Line Ending Warnings on Hook Files
  - learnings/gotchas.md § 2026-04-16 Cowork Sandbox Git Persistence — Three Compounding Failures (CRITICAL)
  - learnings/cross-project.md § 2026-04-18 Scaffold shipped without .gitattributes (allen-sports-floors)
status: awaiting-logan-review
install_path_suggestion: ~/.claude/skills/windows-git-hygiene/SKILL.md
---

# SKILL PROPOSAL — windows-git-hygiene

## Rationale for graduation

Five independent citations, two CRITICAL severity. All concern silent failures caused by Windows-specific git behavior: OneDrive syncing `.git/` binaries, global config not sticking in bash, CRLF conversion breaking shell scripts, Cowork sandbox having no push auth, and new-repo scaffolds shipping without `.gitattributes`. Every one has cost hours of debug time. Consolidating into a skill means any new repo or session-start Claude Code run on Logan's PC auto-loads the full mitigation checklist.

## Draft SKILL.md

```markdown
---
name: windows-git-hygiene
description: Audit or repair Windows-specific git pitfalls in a repo — OneDrive-synced .git/ corruption, CRLF line-ending breakage on shell scripts and hooks, missing .gitattributes, git config --global not sticking in bash, core.hooksPath drift, and Cowork sandbox push authorization. Trigger on "new repo setup", "hook not firing", ".git/index corrupt", "bash on Windows", "CRLF warnings", "Cowork commits not pushing", or "why did my shell script break on Windows". Use proactively at session start on any PC-side Claude Code session. Do NOT trigger on macOS or Linux hosts.
effort: small
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

# Windows Git Hygiene

## Gotcha 1 — OneDrive corrupts `.git/` (CRITICAL)

OneDrive syncs `.git/` binary internals and races with git's atomic-rename operations, producing:
- `fatal: index file corrupt`
- Sticky `.git/index.lock`, `.git/HEAD.lock`, `.git/refs/heads/main.lock` files
- Phantom divergence reports

**Mitigation (must):** never store a git repo inside a OneDrive-synced folder. Move to `C:\Users\logan\Projects\` (non-synced). If migrating, clone fresh from GitHub rather than moving the `.git/` directory.

**Detection at session start:**
```bash
git rev-parse --show-toplevel | grep -i onedrive && echo "⚠️ REPO IS IN ONEDRIVE — MOVE IT"
```

## Gotcha 2 — `git config --global` can fail silently in bash on Windows

bash-on-Windows sessions may not read the same global config as PowerShell. `git config --global user.email foo@bar` silently succeeds but git still reports "Author identity unknown" on commit.

**Mitigation:** set identity at repo level (no `--global`):
```bash
git config user.email "loganallensf@gmail.com"
git config user.name "logancallen"
git config user.email  # verify
```
Or set `credential.helper` to `manager` via Windows Credential Manager.

## Gotcha 3 — CRLF conversion breaks shell scripts and hooks

Git on Windows converts LF→CRLF on checkout by default. Shell scripts with `\r\n` line endings fail to execute in bash with cryptic `\r: command not found` or silent no-ops.

**Mitigation (ship in root commit):** every new repo must include `.gitattributes`:
```
* text=auto
*.sh text eol=lf
*.bash text eol=lf
.husky/* text eol=lf
*.yml text eol=lf
*.yaml text eol=lf
```

Then per-repo on Windows:
```bash
git config core.autocrlf false
```

**Verify:** `git ls-files --eol` — all shell scripts should show `i/lf w/lf`.

If CRLF already crept in: re-normalize with `git add --renormalize .` and commit.

## Gotcha 4 — `core.hooksPath` drifts per session on PC

Setting `git config core.hooksPath .claude/hooks` does not always persist reliably across sessions on Windows. Post-commit hooks silently stop firing.

**Mitigation:** verify at start of any session involving hooks:
```bash
[ "$(git config core.hooksPath)" = ".claude/hooks" ] || git config core.hooksPath .claude/hooks
```
Add the check to session-start hook or CLAUDE.md directive.

## Gotcha 5 — Cowork sandbox commits die on recycle (CRITICAL)

Cowork sandbox has no git push auth. Commits made inside the sandbox stay local to the sandbox and are lost on recycle, even though the report output shows success.

**Mitigation:**
- Any Cowork autonomous run (scheduled task, Implementer, etc.) must be verified by running `git log --oneline -3` in `C:\Users\logan\Projects\Claudious\` the same day.
- Do not trust report output alone — it only reflects sandbox state.
- For push-required tasks, either (a) configure `GITHUB_TOKEN` env var in the sandbox, or (b) keep the task advisory-only and execute the push from the local shell.
- Close GitHub Desktop before running CLI git on Claudious — GitHub Desktop holds repo locks that cause `HEAD.lock` errors.

## Gotcha 6 — Multiple worktree clones pointing at the same remote mask state

Two repos (e.g. OneDrive clone + Projects clone) pointing at the same remote produce diagnostic output that varies by cwd. A `git log` run in the wrong clone looks out of sync with reality.

**Mitigation:** confirm canonical clone at session start:
```bash
git rev-parse --show-toplevel
```
Claudious canonical: `C:\Users\logan\Projects\Claudious`. OneDrive Claudious is retired/read-only.

## Checklist for a new repo on Windows

1. Clone into `C:\Users\logan\Projects\` (never OneDrive).
2. Ship `.gitattributes` in the root commit (template above).
3. Run `git config core.autocrlf false`.
4. Set repo-local identity: `git config user.email ... && git config user.name ...`.
5. If using hooks: `git config core.hooksPath .claude/hooks`.
6. Verify all shell scripts: `git ls-files --eol | grep -E '\.(sh|bash)$'` all show `i/lf w/lf`.
7. For repos operated by Cowork: add `GITHUB_TOKEN` to sandbox env OR mark as advisory-only.

## Recovery runbook — lock file stuck

```bash
# Close GitHub Desktop first.
rm -f .git/index.lock .git/HEAD.lock .git/refs/heads/main.lock .git/objects/maintenance.lock
# If rm fails with "Operation not permitted" (Cowork sandbox): mv to .bak suffix instead.
# If index corrupt after removing locks:
mv .git/index .git/index.bak
git reset  # rebuilds index from HEAD
```
```

## Open questions for Logan

1. Scope: install globally (`~/.claude/skills/`) since this applies to every PC-side project, or Claudious-only since Claudious is the hardest-hit repo? **Recommendation: global.**
2. Should this skill also include `pre-bash-safety.sh` bypass guidance (from gotchas.md § 2026-04-17 `git reset --hard` blocked)? That's a Claudious-safety-hook-stack concern, not a Windows concern — keeping it separate.
3. Cowork sandbox push fix — Logan's earlier decision was "deferred (advisory mode vs GITHUB_TOKEN env var)." Does this skill's Gotcha 5 mitigation reflect current policy, or is a decision pending?

## Install instructions (manual — do not auto-deploy)

```bash
mkdir -p ~/.claude/skills/windows-git-hygiene
# paste SKILL.md body above into ~/.claude/skills/windows-git-hygiene/SKILL.md
# verify: ls ~/.claude/skills/windows-git-hygiene/
```
