# Gotchas — Silent Failures and Non-Obvious Behaviors
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Gotchas

### 2026-04-11 — GOTCHA — PostgREST Silent 1000-Row Truncation
**Severity:** CRITICAL
**Context:** Root cause of persistent vehicle/trailer dropdown bug in ASF Graphics that survived multiple fix attempts.
**Learning:** PostgREST truncates DISTINCT query results at 1000 rows silently — no error, no warning. Truncation occurred alphabetically at "Honda". Fix: always add .limit() with explicit count or use range headers on any query that could return large result sets. This is PostgREST default behavior, not a bug. Every Supabase query returning >500 rows needs explicit pagination.
**Applies to:** ASF Graphics, Courtside Pro — any Supabase query with large result sets

### 2026-04-11 — GOTCHA — Windows Bash git config --global Not Sticking
**Severity:** HIGH
**Context:** Setting up git identity for Courtside Pro sync script on PC.
**Learning:** On Windows, bash sessions may not read same git global config as PowerShell. git config --global user.email fails silently — git still reports "Author identity unknown". Fix: use git config (no --global flag) to set identity at repo level. Or set credential.helper to manager via Windows Credential Manager. Always verify: git config user.email after setting.
**Applies to:** All git operations from bash on Windows PC

### 2026-04-11 — GOTCHA — CRLF Line Ending Warnings on Hook Files
**Severity:** LOW
**Context:** Committing post-commit hook and sync script from Windows PC.
**Learning:** Git on Windows converts LF to CRLF when touching shell scripts, breaking bash execution. Fix: git config core.autocrlf false, then re-add and recommit affected files. All hook files and .sh scripts must use LF line endings to execute in bash.
**Applies to:** All shell scripts and hook files committed from Windows PC

### 2026-04-11 — GOTCHA — Skill negatives: YAML Field Does Not Exist
**Severity:** HIGH
**Context:** Community incorrectly reported this as a valid YAML field.
**Learning:** There is no negatives: YAML field in Claude Code skill frontmatter. To prevent skill misfires, add exclusion phrases directly in the description text: "Do NOT trigger for: staging deploys, preview builds, local testing." Triggering is semantic — only name and description influence auto-triggering. Max ~34-36 skills before available_skills block truncates.
**Applies to:** All Claude Code skills

### 2026-04-11 — GOTCHA — RAG Activates Earlier Than Expected
**Severity:** HIGH
**Context:** Deep architecture research on Claude Projects.
**Learning:** Claude Projects activate RAG at surprisingly low context usage (as low as 2-6%) when many files exist — not just when approaching the limit. Files may already be RAG-chunked even in small projects. Files over 5KB need RAG-optimized structure regardless of total project size.
**Applies to:** All Claude Projects with multiple knowledge files

### 2026-04-11 — GOTCHA — core.hooksPath Must Be Verified Each Session on PC
**Severity:** HIGH
**Context:** Post-commit hook wired but not firing on Courtside Pro.
**Learning:** git config core.hooksPath .claude/hooks must be set per repo. On PC it may not persist reliably across sessions. Verify at start of any Claude Code session involving hooks: git config core.hooksPath. If empty: re-run git config core.hooksPath .claude/hooks. Add verification to session-start hook output.
**Applies to:** All Claude Code projects using .claude/hooks/ on Windows PC

### 2026-04-15 — GOTCHA — Skill Description Truncation Cap (34-36 skills)
**Severity:** HIGH
**Context:** Claude Code truncates skill descriptions when total count exceeds ~34-36.
**Learning:** Monitor total skill count across global + project scopes. If approaching 34, consolidate or remove low-value skills. No error is thrown — descriptions silently truncate.
**Applies to:** All Claude Code sessions with many custom skills.

## Archive
