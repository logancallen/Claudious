# Gotchas — Silent Failures and Non-Obvious Behaviors
<!-- Auto-maintained. Keep under 200 lines. -->

## Active Gotchas

### 2026-04-17 — GOTCHA — Supabase projects post-2026-Q1 default to ES256 asymmetric JWT keys

**Severity:** CRITICAL
**Context:** ASF Graphics Sprint 4.6. Backend verifier pinned `algorithms=["HS256"]` during an auth-hardening pass. Supabase had migrated the project to asymmetric signing keys (`/auth/v1/.well-known/jwks.json` returned a single ES256 P-256 key), and every authenticated route started failing with `Invalid token: The specified alg value is not allowed`. The error surfaced on three unrelated screens (Design Library, PVO, Production Hub Measure) with identical text — one root cause, three symptoms.
**Learning:** On any Supabase-backed backend created after 2026-Q1, `GET <project>.supabase.co/auth/v1/.well-known/jwks.json` before pinning PyJWT / jose algorithms. If JWKS returns ES256/RS256, the verifier must accept that alg (via `PyJWKClient` or equivalent); keep HS256 only as a fallback for legacy service-role tokens signed with the shared secret. Dispatch on the token header's `alg` instead of hard-coding a single algorithm in `algorithms=[...]`.
**Applies to:** All projects using Supabase Auth + a non-Supabase backend verifier (FastAPI, Express, Go). Triggered by any auth-hardening PR that narrows the accepted alg list.

### 2026-04-17 — GOTCHA — Render-layer bugs survive fetch-layer fixes until a human tests the UI

**Severity:** HIGH
**Context:** ASF Graphics Sprint 4.5 added `historical_jobs` fetching to `useJobs.js`; DB returned all 325 rows correctly. Sprint 4.6 discovered `/jobs` still only showed 8 rows because `mapHistoricalJob` set `isArchived: true` on every imported row, and the default `statusFilter = 'active'` plus the `all` filter both excluded archived. Fetch was green; one boolean in the mapper gated every user-visible bucket.
**Learning:** After any "fetch fix," verify the render. Boolean fields that gate visibility (isArchived, isHidden, isDeleted, isDeprecated) are the most common render-layer culprits. When a user reports a count mismatch ("I see 8, you told me there are 337"), count the data in the DB, then count it in the rendered DOM — the gap pinpoints the layer. Never declare a fetch fix done without visual verification.
**Applies to:** Any React/Vue/Svelte hook that fetches a collection and maps it through a transformer before rendering. Especially acute when the mapper adds flags that aren't in the source table.

### 2026-04-17 — GOTCHA — Data-migration CHECK constraint silently invalidates frontend enum logic

**Severity:** HIGH
**Context:** Migration 035b consolidated 17+ product_type variants down to 12 canonical title-case values and added `jobs_product_type_canonical` CHECK constraint on `jobs.product_type`. The frontend never got updated. Results: (a) IntakeFormV2 writes `productConfig.label` ("Press Box Wrap") at lines 591 + 912 and hits 23514 check_violation — saveDraft at line 620 silently `console.error`s, operators see no failure; (b) Fix 9's `VEHICLE_PRODUCT_TYPES` snake_case Set in JobMaterials.jsx compares against the now-title-case DB value and is a no-op on all 11 live jobs — including real vehicle wraps the guard was written to preserve; (c) QuickAddModal dropdown offers 8 options, 4 of which violate CHECK; (d) Admin.jsx demo seeds have 4 of 5 rows that violate CHECK.
**Learning:** When a data-migration CHECK constraint lands, every frontend and backend string-literal comparison against that column becomes a potential no-op (read side) or 23514 violation (write side). Before writing any guard like `ENUM_SET.has(row.col)`, grep the CHECK constraint AND the live DISTINCT values, compare vocabularies, and either reuse a canonical helper or introduce one. Hybrid snake_case+title-case "defensive" sets are a bug-class tell, not a fix. Any follow-up consolidation migration must be atomic (drop CHECK → backfill → re-add with new allowed set) and ship in the same deploy as the frontend fix — shipping code and migration sequentially admits a window where every write silently fails.
**Applies to:** Any Supabase column with an enum type or CHECK constraint (phase, role, material_type, product_type). Applies to any post-migration audit: vocabulary drift can only be counted accurately against a post-migration tree.

### 2026-04-17 — GOTCHA — `git reset --hard` is blocked by pre-bash-safety.sh even with explicit user request

**Severity:** LOW
**Context:** During divergence reconciliation in `/Projects/asf-graphics-app/`, user explicitly scripted `git reset --hard origin/main` as a step. The `~/.claude/hooks/pre-bash-safety.sh` hook blocks the regex `git reset --hard` unconditionally — hook has no allowlist-by-user-confirmation path. Plumbing equivalent (`git update-ref refs/heads/main refs/remotes/origin/main` + `git reset HEAD` mixed + `git checkout -- .`) achieves the same end state and is not blocked. Push to default branch was also blocked separately by a permission rule.
**Learning:** User-confirmed destructive git commands can still be blocked by pre-bash-safety.sh. When blocked, the correct response is: (a) surface the block to the user with the plumbing alternative as an option, (b) not silently work around the hook. The plumbing path is functionally equivalent when working-tree content is already captured elsewhere. For default-branch pushes, the user can push manually with `! git push origin main` or the session can open a PR from a feature branch.
**Applies to:** Any Claude Code session running under the Claudious safety hook stack that needs to reconcile diverged branches or push to main.

### 2026-04-17 — GOTCHA — CC file-change summaries cannot be trusted without grep proof

**Severity:** CRITICAL
**Context:** Claude Code's Prompt 3 Fix 9 summary claimed VEHICLE_PRODUCT_TYPES was added to JobMaterials.jsx. A later audit claimed the constant didn't exist. Rebase revealed the constant DID exist (commit e97a513) — the audit had been run on a stale tree. Session-end summaries conflate "I intended to add this" with "this is on disk and pushed."
**Learning:** Every CC prompt that claims to add/modify a symbol must end with mandatory grep proof-of-work: `grep -n <symbol> <file>`. Session-end audits must `git pull --rebase` first. Claude.ai advisors must not trust summaries for downstream decision-making — verify with git log / grep / Supabase MCP against live state.
**Applies to:** Any Claude Code session that produces a file-change summary. Any Claude.ai advisor session that acts on CC's self-reported state.

### 2026-04-17 — GOTCHA — Audit docs run on stale git trees produce false claims

**Severity:** HIGH
**Context:** Product-type vocabulary audit (commit dfa5e85 before rebase) asserted VEHICLE_PRODUCT_TYPES didn't exist and next migration number was 035. Both false once rebased against remote main — constant existed at e97a513, next migration was 043.
**Learning:** Before writing any audit, `git pull --rebase origin main` and `git log --oneline -20` to verify tree is current. After any rebase, re-run grep claims and migration-number claims. Ship an addendum if the audit already committed with known-false claims.
**Applies to:** Any audit, schema snapshot, or state document that makes factual claims about codebase contents.

### 2026-04-15 — GOTCHA — OneDrive Corrupts .git Index Files
**Severity:** CRITICAL
**Context:** Claudious repo in OneDrive caused .git/index corruption and sticky index.lock files. Every Cowork scheduled task hitting the mount failed on git add.
**Learning:** Never store git repos inside OneDrive-synced folders. OneDrive syncs .git/ binary internals and creates lock file conflicts. Move repos to a non-synced path (C:\Users\logan\Projects\).
**Applies to:** All git repos on Windows machines with OneDrive active.

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

### 2026-04-15 — GOTCHA — Cowork Cannot Access Multiple Repos Simultaneously
**Severity:** HIGH
**Context:** Drift Detector Cowork task failed because it needs both Claudious and asf-graphics-app repos. Cowork sandbox only mounts one working folder.
**Learning:** Any task requiring cross-repo access must run in Claude Code, not Cowork. This also killed Config Backup and Auto-Harvest.
**Applies to:** All Cowork scheduled tasks that reference files outside the mounted working folder.

### 2026-04-16 — GOTCHA — Cowork Sandbox Git Persistence — Three Compounding Failures
**Severity:** CRITICAL
**Context:** Sunday Implementer run (2026-04-16) appeared successful — report showed DEPLOYED for 3 items, 1 no-op, commit cf732ec. Local investigation revealed no lost commit but exposed three interacting failure modes that together create silent data loss risk.
**Learning:** Three failures compound: (1) Two repos (OneDrive + Projects) point to same remote — diagnostic output varies by cwd, masking real state. (2) Cowork sandbox has no git push auth — commits stay in sandbox, die on recycle. (3) GitHub Desktop holds repo locks — CLI git fails with HEAD.lock errors. Mitigations: Projects\Claudious confirmed canonical; OneDrive kept as read-only mirror (retirement pending consumer audit); close GitHub Desktop before CLI git on Claudious; Cowork push fix deferred (advisory mode vs GITHUB_TOKEN env var). Detection: any Implementer/autonomous run must be verified by running `git log --oneline -3` in Projects\Claudious the same day — do not rely on report output alone.
**Applies to:** Claudious, any future Cowork-operated repos

## Archive
