# disable-skill-shell-execution
**Source:** archive/intake/2026-04-20.md section B-1
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE
**Target file:** learnings/techniques.md

## Change

### 2026-04-20 — TECHNIQUE — `disableSkillShellExecution` Blocks Inline Shell in Skills
**Severity:** HIGH
**Context:** Claude Code Week 14 April 2026 shipped a `disableSkillShellExecution` setting that blocks inline shell execution inside skill/command bodies (security hardening). Logan runs multiple custom skills with bash fences, so this is directly relevant.
**Learning:** Set `disableSkillShellExecution: true` in `~/.claude/settings.json` to prevent skills and slash commands from silently executing embedded shell. Prompts for explicit tool approval instead. Use when running untrusted or community-authored skills. Trade-off: local custom skills that rely on inline bash will prompt on every run — keep disabled during dev, flip on for production/trusted-only sessions. Check `/doctor` output if skills behave unexpectedly after enabling.
**Applies to:** All Claude Code sessions using custom skills — Claudious skills, mastery-lab skills, any community-installed skill

## Verification
grep -c "disableSkillShellExecution" learnings/techniques.md  # must be >=1 after deploy
