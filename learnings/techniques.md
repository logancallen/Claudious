# Techniques — Cross-Claude Intelligence
<!-- Auto-maintained. Keep under 200 lines. Archive stale entries at bottom. -->

## Active Techniques

### 2026-04-17 — TECHNIQUE — CC crash recovery via Claude.ai Supabase MCP

**Severity:** HIGH
**Context:** Migration 041 (auth.uid wrap across 94 policies) crashed Claude Code mid-apply with `API Error: terminated` at 146K tokens. File was written to disk but migration didn't apply. Retry-in-CC risked the same failure.
**Learning:** When CC crashes mid-apply on a Supabase migration, recovery path is NOT to retry in CC. Apply the migration directly via Claude.ai Supabase MCP `apply_migration` — it's a separate execution path with different failure modes. DB state is authoritative via `execute_sql` queries; git state reconciles after. File on disk from CC is reusable as the migration source.
**Applies to:** Any long-running Supabase migration, any CC session hitting context/token limits mid-execution.

### 2026-04-17 — TECHNIQUE — RLS auth.role() wraps identically to auth.uid()

**Severity:** HIGH
**Context:** Migration 041 wrapped 94 auth.uid() refs. Advisor still showed 11 auth_rls_initplan warnings after — all were auth.role() calls, same per-row evaluation issue. Migration 042 wrapped them with same `(select auth.role())` pattern.
**Learning:** Supabase RLS auth.*() functions (auth.uid, auth.role, auth.jwt) all suffer the same per-row evaluation cost. The `(select auth.FN())` wrap lets Postgres cache the scalar per-query. Always audit ALL auth.*() refs, not just auth.uid(). Generic dry-run probe: wrapped-count exclusion against pg_policies.qual and with_check.
**Applies to:** Any Supabase project using RLS. Any PostgREST-backed app where RLS policies run on every row fetch.

### 2026-04-17 — TECHNIQUE — Pre/post-apply count gates for schema migrations

**Severity:** LOW
**Context:** Migrations 041 and 042 used identical gate pattern: dry-run probe against live pg_policies returns a count (94/135 pre-041, 11 pre-042), migration applies, re-run probe expects 0/0. Gate caught no issues this sprint, but would have caught advisor-snapshot drift if present.
**Learning:** For any bulk-policy or bulk-data migration, hard-gate on pre-apply count matching expected baseline AND post-apply count being 0 (or whatever the target state is). Advisor snapshots drift from live state; always query live. Gate catches partial applies, wrong scope, and advisor staleness in one pattern.
**Applies to:** Supabase migrations touching multiple policies/rows, any bulk DB change with a countable target state.

### 2026-04-11 — TECHNIQUE — GitHub Closed-Loop Knowledge Sync
**Severity:** CRITICAL
**Context:** Discovered building Courtside Pro — the agent with ground truth should maintain knowledge files.
**Learning:** Store all Claude Project knowledge files in docs/ inside the project GitHub repo. Connect Claude Project to repo via GitHub sync. Claude Code updates docs/ files in same commit as code changes. Hit Sync in Claude Project UI after pushing. Result: knowledge files always current, version-controlled, maintained by the agent with ground truth — never manually by Logan.
**Applies to:** All Claude Projects with a GitHub repo

### 2026-04-11 — TECHNIQUE — MEMORY.md Separation from CLAUDE.md
**Severity:** CRITICAL
**Context:** Discovered during deep architecture research — facts and instructions should live in separate systems.
**Learning:** CLAUDE.md = instructions (what to do). MEMORY.md at ~/.claude/projects/[project]/memory/MEMORY.md = facts (what Claude knows). Mixing them degrades both. MEMORY.md auto-loads into every session's system prompt (first 200 lines / ~25KB). Create one per project, populate with: incidents, gotchas, architecture decisions, current status.
**Applies to:** All Claude Code projects

### 2026-04-11 — TECHNIQUE — Path-Scoped Rules via .claude/rules/
**Severity:** HIGH
**Context:** Rules that only apply in certain directories shouldn't load every message.
**Learning:** Create .claude/rules/ with individual .md files containing YAML frontmatter paths: ["frontend/**"]. Rules only activate when Claude edits files in those paths. Keeps CLAUDE.md lean while enforcing domain-specific standards precisely. Use for frontend/, backend/, migrations/ domains.
**Applies to:** All Claude Code projects with distinct domain directories

### 2026-04-11 — TECHNIQUE — Env Var Layer for Claude Code Tuning
**Severity:** HIGH
**Context:** Discovered via March 2026 source leak — Claude Code has internal controls exposed as env vars.
**Learning:** Add to shell profile: CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 (fixes April 2026 quality nerf), CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000 (extends auto-compact threshold), CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6 (50-70% cost savings on delegated work; Opus 1M now available if quality needed), CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true (enables team coordination), CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1 (prevents retry double-work).
**Applies to:** All Claude Code sessions globally — add to shell profile on both Mac and PC

### 2026-04-12 — TECHNIQUE — Context Buffer: 33K-45K Reserved Internally
**Severity:** HIGH
**Context:** Scout finding from claudefa.st architecture documentation.
**Learning:** Claude Code reserves 33K-45K tokens from the context window for internal operations (tool definitions, system prompts, safety). Usable context is ~955K, not the full 1M. Plan compaction triggers at ~900K to leave headroom. Sub-agents have the same reduction — factor into task sizing.
**Applies to:** All Claude Code sessions — compaction timing and token budget planning

### 2026-04-12 — TECHNIQUE — /compact with Warm Cache Timing (70%+ Token Savings)
**Severity:** HIGH
**Context:** Source: mindstudio.ai token management guide. Calling /compact within cache window slashes cost.
**Learning:** Call `/compact` within 5 minutes of your last message to hit the prompt cache discount. Can shrink 80K-token histories to 12K while preserving critical context. Use every 10-15 turns (or ~25 with 1M context). Always provide a focus string: `/compact Focus on [what matters]` — e.g. "code samples, API patterns, and architecture decisions" or "schema changes and migration state". Expected result: 70%+ total token reduction over a multi-hour session.
**Applies to:** All Claude Code sessions — especially long builds and multi-hour debugging

### 2026-04-11 — TECHNIQUE — Skill YAML Full Spec
**Severity:** HIGH
**Context:** Most builders only use name and description — full spec unlocks tool restrictions, effort control, path scoping.
**Learning:** Full skill frontmatter: effort (tiny/small/medium/large/epic), allowed-tools (restrict tool access), paths (scope to directories), model (override per skill), context (none/inherited/fork), agent (spawn sub-agent). Triggering is semantic — name and description ONLY. Add exclusion phrases directly in description text: "Do NOT trigger for: [list]". No negatives: YAML field exists — that field is invalid.
**Applies to:** All Claude Code skills across all projects

### 2026-04-11 — TECHNIQUE — Post-Commit Hook for Auto-Knowledge Updates
**Severity:** HIGH
**Context:** Claude Code should update knowledge files as part of commits, not as an afterthought.
**Learning:** Create .claude/hooks/post-commit that inspects changed files and updates relevant docs/ files. migrations/* → update docs/schema-state.md. source files → update docs/codebase-state.md. functions/* → flag docs/business-rules.md. Use managed <!-- BEGIN: --> <!-- END: --> blocks so hook updates in place without duplicating. Wire with: git config core.hooksPath .claude/hooks (must re-verify each session on PC).
**Applies to:** All Claude Code projects with docs/ knowledge sync

### 2026-04-11 — TECHNIQUE — Sync Script for One-Command Knowledge Push
**Severity:** HIGH
**Context:** Built for Courtside Pro as the final step in the knowledge sync loop.
**Learning:** Create scripts/sync-knowledge.sh that warns on stale docs/ files, commits pending changes with "docs: auto-sync knowledge files", pushes to main, prints Sync reminder listing ALL connected Claude Projects. Run after every session. Wire git identity first using local (not --global) config on Windows when bash doesn't read global config.
**Applies to:** All Claude Code projects with GitHub sync

### 2026-04-14 — TECHNIQUE — Arize Prompt-Learning Loop for CLAUDE.md
**Severity:** HIGH
**Context:** Arize published a systematic method for CLAUDE.md optimization showing +5-10% SWE Bench improvement without model changes.
**Learning:** Pick a repeatable failing task. Run it against current CLAUDE.md. Diff Claude's actual output vs. desired output. Extract the exact instruction that would have prevented the error (e.g., "Run `npm test` before declaring done"). Append to CLAUDE.md, then test removal to confirm the new line is actually pulling weight — bloat hurts. Re-run. Cycle weekly on highest-failure-rate workflows. Pair with Bloated CLAUDE.md antipattern to keep net line count flat.
**Applies to:** All Claude Code projects — CLAUDE.md iteration on ASF Graphics, Courtside Pro, Claude Mastery Lab

### 2026-04-16 — TECHNIQUE — Native `--worktree` Flag Replaces Manual Split-and-Merge Setup
**Severity:** HIGH
**Context:** `claude --worktree <name>` (or `-w <name>`) collapses the create-worktree → cd → launch-claude sequence into one command per parallel agent. Direct upgrade to the split-and-merge pattern Logan already uses.
**Learning:** Use `claude -w api-refactor`, `claude -w ui-polish`, etc. per terminal to spin up isolated parallel sessions. Auto-creates an isolated git worktree, checks out `worktree-{name}` branch from `origin/HEAD`, and scopes the Claude session to that directory. With no argument, generates a name automatically. Headless via tmux: `claude --worktree <name> --tmux`. Practical limit: 5-10 parallel sessions before merge bottleneck and rate-limit throttling. Pro-tier users hit limits in minutes with 2+ parallel sessions — Max tier required for serious scaling.
**Applies to:** All Claude Code projects using parallel-agent workflows — ASF Graphics, Courtside Pro, Claudious

### 2026-04-19 — TECHNIQUE — MCP 500K Result Storage in Claude Code
**Severity:** HIGH
**Context:** Claude Code Week 16 April 2026 update increased MCP result storage limit.
**Learning:** Claude Code now stores up to 500,000 characters per MCP tool result (previously much lower). For Logan's 5+ MCP server setup, this means large query results, GitHub API payloads, and database responses no longer need truncation workarounds. If an MCP result is silently cut off, the new limit is 500K chars — check server-side response size if truncation still occurs.
**Applies to:** All Claude Code sessions using MCP tools — GitHub MCP, Supabase MCP, Perplexity MCP

### 2026-04-19 — TECHNIQUE — Claude Code Week 15-16 April 2026 Feature Set
**Severity:** HIGH
**Context:** Claude Code shipped two major weekly releases in April 2026 with high-signal workflow features.
**Learning:** Week 15 (Apr 6-10): Monitor tool streams background process events in real-time — replaces polling loops; `/loop` self-paces long sessions automatically; `/autofix-pr` fixes PRs from terminal without leaving Claude Code; `/team-onboarding` creates replayable setup guides; Ultraplan early preview (cloud planning on Opus 4.6, terminal stays free). Week 16 (Apr 14-18): `/powerup` interactive lessons for feature discovery; defer permission decisions mid-session (approve later without restarting); per-model `/cost` breakdown shows spend by model; skill description limit raised 250→1,536 chars. Update any slash-command workflows to use Monitor tool instead of background polling.
**Applies to:** All Claude Code sessions — especially Claudious process runs and parallel-agent workflows

### 2026-04-19 — TECHNIQUE — Request Logo Before Committing to Font/Color Decisions
**Severity:** HIGH
**Context:** ASF Sports Floors greenfield build: entire design system was specced before the actual logo was reviewed, resulting in conflicts that required a full visual reset.
**Learning:** On any greenfield brand-led web build, request the actual logo/mark BEFORE writing CSS or committing to font/color choices. A plausible-sounding aesthetic (luxury editorial, premium tech, athletic etc.) can actively contradict the real brand mark and signal inconsistency. Two-minute logo review prevents hours of design rework. Specific trigger: the moment a client says "make it feel like X" — stop and ask "can I see the logo first?"
**Applies to:** Any frontend build that begins with brand/aesthetic direction — ASF, Courtside Pro, any future Logan client project

### 2026-04-20 — TECHNIQUE — `disableSkillShellExecution` Blocks Inline Shell in Skills
**Severity:** HIGH
**Context:** Claude Code Week 14 April 2026 shipped a `disableSkillShellExecution` setting that blocks inline shell execution inside skill/command bodies (security hardening). Logan runs multiple custom skills with bash fences, so this is directly relevant.
**Learning:** Set `disableSkillShellExecution: true` in `~/.claude/settings.json` to prevent skills and slash commands from silently executing embedded shell. Prompts for explicit tool approval instead. Use when running untrusted or community-authored skills. Trade-off: local custom skills that rely on inline bash will prompt on every run — keep disabled during dev, flip on for production/trusted-only sessions. Check `/doctor` output if skills behave unexpectedly after enabling.
**Applies to:** All Claude Code sessions using custom skills — Claudious skills, mastery-lab skills, any community-installed skill

### 2026-04-20 — TECHNIQUE — CLAUDE.md 200-Line Cap with Skills and Nested Indexes
**Severity:** MEDIUM
**Context:** Community best practice (amitray.com/best-practices-for-claude-md) — oversized root CLAUDE.md files force Claude into expensive exploratory searches on every session start. Current compliance across Logan's stack verified 2026-04-20: Claudious 73 / courtside-pro 147 / asf-graphics-app 162 / allen-sports-floors 140 / global 75 — all under 200. First-citation graduation per Process proposal.
**Learning:** Keep root CLAUDE.md under 200 lines. Push domain details into skills (`.claude/skills/*.md`) or `@imports` for modular composition. Use nested CLAUDE.md files in subdirectories as scoped indexes so Claude loads only the relevant context per path. If a root CLAUDE.md grows past 200, extract the largest section into a skill or split a subdirectory index rather than trimming content indiscriminately. Flag for canonical/prompting-rules.md promotion once a second independent citation surfaces.
**Applies to:** All Claude Code projects with a root CLAUDE.md — Claudious, ASF Graphics, Courtside Pro, Allen Sports Floors, and user-global `~/.claude/CLAUDE.md`

## Cross-Machine Heartbeat Layer — 2026-04-23

**Pattern:** Commit per-machine state JSON to a tracked directory so the autonomous intake pipeline can detect when one machine is working against stale state. Each machine runs a heartbeat script that captures hostname, OS, and per-repo (SHA, branch, dirty count, ahead, behind, last_fetch). Intake at 6am reads these files and emits findings when machines go stale, repos sit behind origin, or WIP sits abandoned.

**Why it works:** Filesystem-native. No external service. Survives Claudious being offline. Scales to N machines. Every heartbeat commit is git-visible, so history of "which machine did what when" is free.

**Gotcha:** Heartbeat commits create routine git noise. Acceptable tradeoff — metadata IS the signal. If noise becomes a problem, migrate to a dedicated `heartbeat/` branch with a cron-pull.

**Follow-up (Layer 2):** SessionStart hook in global `~/.claude/CLAUDE.md` will read the heartbeat of this machine before any work starts — halts on dirty trees, unpulled commits, or stale sibling machines.

<!-- PROMOTE TO CLAUDIOUS: N/A — this IS Claudious. Pattern is cross-project relevant: any multi-machine dev environment benefits from committed heartbeat files. -->

## Pre-Session Doctor (Layer 2) — 2026-04-23

**Pattern:** SessionStart hook in `.claude/settings.json` calls a thin wrapper that invokes a central preflight script (lives in Claudious `scripts/update-heartbeat.sh --preflight <repo>`). Hook runs before any Claude Code work starts: updates heartbeat, commits+pushes to Claudious main, fetches current repo, halts on drift conditions.

**Halt conditions (exit codes 2-4):** current repo behind origin; stale WIP (≥5 dirty AND oldest >24h); sibling machine pushed within 4h and this machine is behind.

**Fail-open philosophy:** infrastructure failures (network, Claudious missing, git errors, unknown repo name) print a `[WARN] preflight-degraded` line and exit 0. Only real drift data causes halts. CC remains usable even when Claudious is unavailable.

**Cross-platform:** `.claude/settings.json` is committed to each tracked repo; both machines inherit the hook on `git pull`. The hook wrapper is `.sh` (bash available on Mac natively and via Git Bash on Windows — same bash CC uses to run asf's existing hooks). A sibling `.ps1` exists for manual admin use. JSON parsing uses `node -e` (universal on Logan's dev boxes; python3 on Windows is a Microsoft Store alias stub, not a real interpreter).

**Heartbeat auto-commit** means zero manual cross-machine sync steps — next CC session on either machine picks up the latest state automatically. Commit-push is gated on `branch == main` so feature-branch CC sessions don't accidentally push on behalf of the user.

**Scope control:** hook only lives in 3 tracked repos (Claudious, asf-graphics-app, courtside-pro). No overhead in CC sessions outside those repos.

<!-- PROMOTE TO CLAUDIOUS: N/A — this IS Claudious. Cross-project pattern: commit hook config + centralize logic. -->

## Archive
