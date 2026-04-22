# Superpowers Plugin Trial — Claudious Scope

**Trial start:** 2026-04-22
**Trial end (expected):** 2026-04-29
**Scope:** Claudious repo only (`C:\Users\logan\Projects\Claudious`)
**Decision source:** Mastery Lab chat 2026-04-22 — Claude Opus 4.7 recommendation, Logan approved.

> **Path note:** The source prompt referenced `C:\Users\logan\Documents\GitHub\Claudious`; the canonical Claudious repo actually lives at `C:\Users\logan\Projects\Claudious` (matches the rollback reference in `~/.claude/CLAUDE.md`). Proceeded at `Projects/Claudious`.

---

## Pre-install baseline (Day 0)

### 1.1 Claude Code version

```
$ claude --version
2.1.116 (Claude Code)
```

Meets precondition (≥ 2.1.113). ✓

### 1.2 User-scope skills (`~/.claude/skills/`)

```
$ ls -la /c/Users/logan/.claude/skills/
_proposed-edits/
caveman/
coordinator-worker/
follow-builders/
harvest/
health-optimizer/
macro-intelligence/
negotiation-playbook/
pioneer/
project-router/
tiered-context/
ultraplan-template/
```

12 user-scope skill directories (one is `_proposed-edits/` holding queued edits — not an active skill). **11 active user-scope skills.**

### 1.3 Project-scope skills (`.claude/skills/` in Claudious)

```
$ ls -la .claude/skills/
(empty)
```

No project-scope skills at Claudious. `.claude/` contains `handoff.md`, `hooks/` (empty), `last-retrospective`, `settings.local.json`, `skills/` (empty).

### 1.4 Installed plugins (pre-install)

```
$ claude plugin list
Installed plugins:

  ❯ codex@openai-codex
    Version: 1.0.3
    Scope: user
    Status: ✔ enabled

  ❯ security-guidance@claude-plugins-official
    Version: unknown
    Scope: user
    Status: ✔ enabled

  ❯ typescript-lsp@claude-plugins-official
    Version: 1.0.0
    Scope: user
    Status: ✔ enabled
```

3 pre-existing plugins, all user-scope. No prior superpowers install. ✓

Configured marketplaces: `claude-plugins-official` (anthropics/claude-plugins-official), `openai-codex` (openai/codex-plugin-cc).

### 1.5 Slash-commands / available-skills (pre-install, from this session)

Skills block from the fresh CC session running this trial (Claudious repo):

```
update-config, keybindings-help, simplify, fewer-permission-prompts,
loop, schedule, claude-api, caveman, coordinator-worker, follow-builders,
harvest, health-optimizer, macro-intelligence, negotiation-playbook,
pioneer, project-router, tiered-context, ultraplan-template, self-eval,
codex:rescue, codex:setup, codex:codex-cli-runtime, codex:gpt-5-4-prompting,
codex:codex-result-handling, init, review, security-review
```

**Count: 27 skills visible pre-install.** Of these, 22 are Logan-custom (user + project scope combined) + 5 are CLI/plugin-provided (init, review, security-review, keybindings-help, update-config, fewer-permission-prompts, claude-api from security-guidance plugin family; codex:* from codex plugin).

`/brainstorm`, `/write-plan`, `/execute-plan`, `/skills-search` — **not present** pre-install (expected). ✓

### 1.6 Canonical 8 skills — pre-install visibility

**Prompt-specified canonical list vs. actual CLI visibility:**

| Skill | On Disk (location) | Visible in CC CLI? |
|---|---|---|
| `logan-os` | `%AppData%\Claude\...\skills\logan-os\SKILL.md` (Claude **desktop** app) | ❌ Not in CLI skills block |
| `operating-system` | `%AppData%\Claude\...\skills\operating-system\SKILL.md` (desktop) | ❌ Not in CLI skills block |
| `financial-modeler` | `%AppData%\Claude\...\skills\financial-modeler\SKILL.md` (desktop) | ❌ Not in CLI skills block |
| `legal-scanner` | `%AppData%\Claude\...\skills\legal-scanner\SKILL.md` (desktop) | ❌ Not in CLI skills block |
| `negotiation-playbook` | `~/.claude/skills/negotiation-playbook/` (CLI user-scope) | ✓ Present |
| `health-optimizer` | `~/.claude/skills/health-optimizer/` (CLI user-scope) | ✓ Present |
| `macro-intelligence` | `~/.claude/skills/macro-intelligence/` (CLI user-scope) | ✓ Present |
| `harvest` | `~/.claude/skills/harvest/` (CLI user-scope) | ✓ Present |

**⚠️ Pre-existing finding — flagged to Logan:** The first 4 canonical skills (`logan-os`, `operating-system`, `financial-modeler`, `legal-scanner`) are Claude **desktop app** skills stored under `AppData\Local\Packages\Claude_pzs8sxrjxfjjc\LocalCache\Roaming\Claude\local-agent-mode-sessions\skills-plugin\...`. They are **not** currently loaded by Claude Code CLI and were not visible in the CC available-skills block even before this trial.

**Revised R1 rollback criterion** (for the 4 CLI-visible canonicals): superpowers install must not cause `harvest`, `health-optimizer`, `macro-intelligence`, or `negotiation-playbook` to disappear from the CC skills block.

---

## Pre-install environment notes

- No existing `superpowers` references in the Claudious tree (grepped — zero matches).
- `.claude/hooks/` at Claudious is empty; `~/.claude/hooks/` does not exist at user scope.
- `.claude/handoff.md` at Claudious dated 2026-04-21 AM — read and acknowledged, no superpowers-relevant state.
- Working tree clean after fast-forward pull from `7cc1874` to `9224361` (3-commit catchup).

---

## Scoping verification (Step 2)

```
$ claude plugin install --help
...
Options:
  -s, --scope <scope>  Installation scope: user, project, or local (default: "user")
```

**✓ Project scope is supported** via `--scope=project` (equivalently `-s project`). Proceeding to install.

---

## Install output (Day 0)

Command (primary marketplace — already registered pre-trial, no marketplace-add needed):

```
$ claude plugin install superpowers@claude-plugins-official --scope=project
Installing plugin "superpowers@claude-plugins-official"...
✔ Successfully installed plugin: superpowers@claude-plugins-official (scope: project)
```

**Version installed:** 5.0.7 (matches README claim in task prompt).

**Blast radius:**
- `C:\Users\logan\Projects\Claudious\.claude\settings.json` — **NEW FILE** (78 bytes), contents: `{"enabledPlugins": {"superpowers@claude-plugins-official": true}}`. This is the project-scope enablement marker. Ignored via `.gitignore`? Needs to be tracked in this PR for reproducibility.
- `~/.claude/plugins/cache/claude-plugins-official/superpowers/5.0.7/` — plugin content cached at user scope (shared across all projects; expected plugin-manager behavior). Not an R4 violation.
- `~/.claude/plugins/installed_plugins.json` — updated to register the new install.

No files created outside these expected locations. R4 **clean**. ✓

---

## Post-install state (Day 0)

### 4.1 Plugins list

```
$ claude plugin list
Installed plugins:
  ❯ codex@openai-codex                              (user, enabled)      v1.0.3
  ❯ security-guidance@claude-plugins-official       (user, enabled)      unknown
  ❯ superpowers@claude-plugins-official             (project, enabled)   v5.0.7
  ❯ typescript-lsp@claude-plugins-official          (user, enabled)      v1.0.0
```

Superpowers appears at project scope. ✓ R5 clean.

### 4.2 New skills inventory (fresh CC session probe)

Ran `claude -p "list every skill"` in a fresh session at the Claudious repo:

```
update-config, keybindings-help, simplify, fewer-permission-prompts,
loop, schedule, claude-api, caveman, coordinator-worker, follow-builders,
harvest, health-optimizer, macro-intelligence, negotiation-playbook,
pioneer, project-router, tiered-context, ultraplan-template, self-eval,
codex:rescue, codex:setup, superpowers:brainstorm, superpowers:execute-plan,
superpowers:write-plan, codex:gpt-5-4-prompting, codex:codex-result-handling,
codex:codex-cli-runtime, superpowers:using-superpowers, superpowers:executing-plans,
superpowers:requesting-code-review, superpowers:brainstorming,
superpowers:writing-plans, superpowers:verification-before-completion,
superpowers:writing-skills, superpowers:receiving-code-review,
superpowers:using-git-worktrees, superpowers:systematic-debugging,
superpowers:subagent-driven-development, superpowers:finishing-a-development-branch,
superpowers:dispatching-parallel-agents, superpowers:test-driven-development,
init, review, security-review
```

**Count: 43 skills visible post-install** (up from 27 — net +16: 3 commands + 13 prefixed skills; 14th plugin skill `using-superpowers` was already in the list, delivered via the SessionStart hook + the plugin manifest).

**No skills truncated.** Cap was at risk in theory but did not trigger. ✓

### 4.3 Commands added

`/superpowers:brainstorm`, `/superpowers:execute-plan`, `/superpowers:write-plan` — all three present. Commands are prefixed by plugin name per CC v2.x convention (`superpowers:*` rather than bare `/brainstorm`). Task prompt expected bare names; actual behavior is namespaced. ✓ functional equivalent.

No `/skills-search` command was added by the plugin (the Skill tool in CC is the skills search mechanism; `/skills-search` described in the task prompt does not exist in superpowers v5.0.7). Skipped Step 4.6 as N/A.

### 4.4 Canonical-skill preservation check (R1)

| Canonical CLI skill | Pre-install visible? | Post-install visible? | R1 status |
|---|---|---|---|
| `harvest` | ✓ | ✓ | ✓ preserved |
| `health-optimizer` | ✓ | ✓ | ✓ preserved |
| `macro-intelligence` | ✓ | ✓ | ✓ preserved |
| `negotiation-playbook` | ✓ | ✓ | ✓ preserved |

All 4 CLI-visible canonical skills preserved. **R1 NOT triggered.** ✓

(The 4 desktop-only canonicals — `logan-os`, `operating-system`, `financial-modeler`, `legal-scanner` — are out of scope for CC CLI and unaffected by this install.)

### 4.5 Hooks check (R3)

Superpowers registers one hook:

```
~/.claude/plugins/cache/claude-plugins-official/superpowers/5.0.7/hooks/
├── hooks.json           (hook manifest)
├── hooks-cursor.json    (Cursor IDE variant)
├── run-hook.cmd         (Windows wrapper)
└── session-start        (bash script)
```

**`hooks.json`:**
```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|clear|compact",
        "hooks": [
          { "type": "command", "command": "${CLAUDE_PLUGIN_ROOT}/hooks/run-hook.cmd session-start", "async": false }
        ]
      }
    ]
  }
}
```

**Behavior:** injects the `superpowers:using-superpowers` skill content into session `additionalContext` at SessionStart / /clear / /compact. Purely additive — does not clear, override, or conflict with existing state.

**R3 conflict check vs. CLAUDE.md handoff-protocol:**
- Handoff-protocol lives in `~/.claude/CLAUDE.md` (global user instructions) and runs as Claude-level behavior, not a hook.
- Superpowers' SessionStart hook only *appends* context via the `additionalContext` JSON output field.
- They are additive and independent. **No conflict.** ✓

**R3 NOT triggered.** ✓

### 4.6 Skills-search probe

`/skills-search` does not exist in superpowers v5.0.7 (task prompt was mistaken). The Skill tool inside CC is the discovery mechanism. Skipped.

---

## Rollback criteria summary

| Criterion | Description | Status |
|---|---|---|
| R1 | Canonical CLI skills preserved | ✓ All 4 present |
| R2 | `harvest` behavior unchanged | ✓ Skill file at `~/.claude/skills/harvest/` untouched; visibility preserved. Behavioral validation deferred to observation period. |
| R3 | No SessionStart-hook conflict with handoff-protocol | ✓ Purely additive hook, no conflict |
| R4 | No files created outside expected plugin locations | ✓ Only `~/.claude/plugins/...` cache + `.claude/settings.json` |
| R5 | `claude plugin list` shows superpowers | ✓ Listed, project scope, enabled, v5.0.7 |

**No rollback triggered.** Trial proceeds.

---

## Trial-branch tracking

Files tracked in this PR:
- `archive/proposals/superpowers-trial-log.md` (this file — new)

**Untracked by design (flagged for Logan's decision):**
- `.claude/settings.json` — plugin-install artifact at Claudious root. Contents: `{"enabledPlugins": {"superpowers@claude-plugins-official": true}}`. Not `.gitignore`'d (only `.claude/settings.local.json` is ignored). Left uncommitted per task prompt's "do not modify files outside the trial log." If Logan wants the trial to auto-activate on the Mac when pulling, add this file to the next commit manually; otherwise leave it local to the PC and re-install via `claude plugin install superpowers@claude-plugins-official --scope=project` on the Mac.

## Observation log (Days 1–7)
_Logan fills in daily. Template below._

### Day 1 (2026-04-23)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction with existing Claudious work: [notes]

### Day 2 (2026-04-24)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

### Day 3 (2026-04-25)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

### Day 4 (2026-04-26)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

### Day 5 (2026-04-27)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

### Day 6 (2026-04-28)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

### Day 7 (2026-04-29)
- Skills fired: [list]
- Helpful: [list]
- Noisy / false-fire: [list]
- Friction: [notes]

## Day-7 verdict
_Logan decides: EXTEND (install in ASF + Courtside), SELECTIVE (keep specific superpowers skills only, disable others), or ROLLBACK (uninstall entirely)._

- Net value: [HIGH / MEDIUM / LOW / NEGATIVE]
- Conflicts observed: [list]
- Recommendation: [EXTEND / SELECTIVE / ROLLBACK]
- Rationale: [2–3 sentences]

<!-- PROMOTE TO CLAUDIOUS: Superpowers trial verdict (for all projects) — whether `obra/superpowers` plugin integrates cleanly with a multi-custom-skill setup at the 18+ skill cap boundary. Affects future skill architecture decisions across ASF Graphics, Courtside Pro, and any future repos. -->
