# Antipatterns — Known Failure Modes

**Last updated:** 2026-04-23
**Scope:** Patterns that waste tokens, degrade output, or cause silent failures. Universal unless noted.

---

## Model / Prompt Hazards

### sampling-params-on-opus-4-7
`temperature`, `top_p`, `top_k` on Opus 4.7 return a 400 error. Scrub SDK calls, CI configs, and any pinned API code.
*Source: `canonical/claude-state.md` — 4.7 breaking changes.*

### silent-prompt-repair-assumption
Opus 4.7 interprets prompts literally — no inferred-intent repair like 4.6 did. Prompts that kind-of-worked may now execute the literal words and regress. Rewrite ambiguous prompts before migrating.
*Source: `canonical/claude-state.md`; intake 2026-04-17.*

### all-caps-for-emphasis
ALL CAPS is ignored in Claude 4.x. Intensity modifiers ("L99:", "MUST", "ALWAYS") have no effect. Use conditional phrasing or structural hierarchy instead.
*Source: `learnings/behavioral.md` (DreamHost testing).*

### negative-instruction-fixation
Claude 4.x increases attention on things you tell it NOT to do. "Don't write fluffy intro" → Claude focuses on fluff. Audit all "never / don't / avoid" and rewrite as positive direction.
*Source: `learnings/behavioral.md`.*

## Context / Token Waste

### bloated-claudemd
CLAUDE.md is loaded on every message, not just session start. Domain knowledge there costs tokens every turn regardless of relevance. Target <150 lines; move domain knowledge to `.claude/skills/` (on-demand) or `docs/knowledge/` (reference).
*Source: `learnings/antipatterns.md`; CC-001.*

### connecting-unused-mcp-servers
Every connected MCP server loads full tool definitions on every message. One server ≈ 8,400 tokens wasted if unused. Audit `/mcp` at session start; disconnect anything not needed for the current task. Prefer CLIs (e.g. `gh`) over MCP where equivalent.
*Source: `learnings/antipatterns.md`; CC-012.*

### full-repo-project-knowledge-attachment
Attaching a full repo as Claude Project knowledge dilutes RAG retrieval with operational history (dated intakes, run ledgers, weekly digests). Attach only the curated `canonical/` directory. Archive old artifacts separately.
*Source: This restructure; RAG split pattern.*

### rag-unaware-knowledge-files
Files >5KB without descriptive H2/H3 headers and front-loaded key facts perform badly under RAG chunking. RAG activates at 2–6% context usage when many files exist — not just near the limit. Every knowledge file needs RAG-aware structure.
*Source: `learnings/patterns.md`; `learnings/gotchas.md`.*

### unbounded-agentic-loops
Production agentic loops without Task Budgets (`task-budgets-2026-03-13`, min 20k) can blow through subscription quota on runaway reasoning. Budget per task, not per response.
*Source: `canonical/claude-state.md`.*

## Code / Migration Hazards

### parallel-vocabularies-for-same-concept
Multiple representations of the same domain concept (product_type in 5 different forms across frontend/backend/DB) generate silent-failure bugs. One canonical internal key (snake_case), labels for display only, normalization shim at every ingress boundary. DB CHECK constraints or enums catch drift at write time.
*Source: `learnings/antipatterns.md` — 2026-04-17 sprint.*

### postgrest-silent-1000-row-truncation
PostgREST truncates DISTINCT query results at 1000 rows with no error. Truncation occurs alphabetically. Every Supabase query returning >500 rows needs explicit `.limit()` or range headers.
*Source: `learnings/gotchas.md`.*

### hardcoded-hs256-on-supabase
Supabase projects post-2026-Q1 default to ES256 asymmetric JWT keys. Backend verifiers pinning `algorithms=["HS256"]` fail with "alg value not allowed". Hit `/auth/v1/.well-known/jwks.json` before pinning algorithms; dispatch on token header `alg` instead of hard-coding.
*Source: `learnings/gotchas.md` — 2026-04-17.*

### trust-cc-self-summaries
Claude Code session summaries conflate intent with disk state. Every prompt claiming to add/modify a symbol must end with `grep -n <symbol> <file>` proof. Audits must `git pull --rebase` first.
*Source: `learnings/gotchas.md` — CC file-change summaries.*

### audit-on-stale-git-tree
Writing an audit without `git pull --rebase origin main` first produces false claims. Migration numbers, constant existence, and schema state all drift. After any rebase, re-run grep claims.
*Source: `learnings/gotchas.md` — 2026-04-17.*

### fetch-fix-without-render-verification
Claiming a fetch bug is fixed without testing the render. Boolean fields (isArchived, isHidden, isDeleted) often gate visibility in the mapper. Count DB rows vs rendered DOM; any gap = render-layer bug that survived the fetch fix.
*Source: `learnings/gotchas.md` — 2026-04-17.*

## Platform / Infrastructure

### onedrive-hosted-git-repos
OneDrive corrupts `.git` index files and creates sticky `index.lock` conflicts. Claudious was moved off OneDrive to `C:\Users\logan\Projects\Claudious` for this reason. Never store any git repo in a OneDrive-synced folder.
*Source: `learnings/gotchas.md` — 2026-04-15.*

### github-desktop-repo-locks
GitHub Desktop holds file locks on repo paths. CLI git fails with `HEAD.lock` errors. Close GitHub Desktop before CLI git on Claudious.
*Source: `learnings/gotchas.md` — 2026-04-16 Cowork sandbox three-failure incident.*

### crlf-line-endings-on-hook-files
Git on Windows converts LF → CRLF on `.sh` scripts, breaking bash execution. Any repo with hook files needs `git config core.autocrlf false` before committing hooks. Use LF endings on all hook and script files.
*Source: `learnings/gotchas.md`.*

### cowork-cross-repo-access
Cowork sandbox mounts a single working folder. Tasks needing two repos (Drift Detector: Claudious + asf-graphics-app) will fail silently. Run these in Claude Code, not Cowork. Also: Cowork sandbox has no git push auth — commits die on recycle.
*Source: `learnings/gotchas.md` — 2026-04-15 / 2026-04-16.*

### skill-description-truncation-over-34
Claude Code silently truncates skill descriptions when total count exceeds ~34–36. No error thrown. Monitor total across global + project scopes; consolidate if approaching the cap.
*Source: `learnings/gotchas.md`; CC-037.*

### skill-negatives-yaml-field
There is no `negatives:` YAML field in Claude Code skill frontmatter — community misreport. To block misfires, add exclusion phrases directly in `description`: "Do NOT trigger for: staging deploys, preview builds."
*Source: `learnings/gotchas.md`.*

### hookspath-not-persisting-on-pc
`git config core.hooksPath .claude/hooks` may not persist across sessions on Windows PC. Verify at session start; re-run if empty. Global CLAUDE.md session-start step checks this.
*Source: `learnings/gotchas.md`.*

## Operational

### operational-noise-in-project-knowledge
Dated intake files, daily run ledgers, weekly digests, and resolved proposals attached as project knowledge dilute RAG. They're operational history, not canonical state. Move to `archive/`; attach only `canonical/` to Claude Projects.
*Source: This restructure.*

### silent-routine-failures
Scheduled routines (intake/process/curate) can fail with no telemetry beyond the runs ledger file. Fix: every routine writes an IN_PROGRESS ledger entry FIRST, updates it to final status at end, and emits a Slack notification summarizing the run (success counts, failure reasons). Canonical `active-findings.md` / `open-decisions.md` updates are part of the routine, not a separate pass.
*Source: This restructure; goal 1 (observability).*

### age-based-alert-archival
Never archive alerts purely by age. Archive only when `deployed.log` shows the underlying issue resolved. Age-based pruning silently drops real unresolved problems.
*Source: `scheduled-tasks/curate.md` 3.2.*

## Browser Agent Permission Hygiene

**Never grant a browser agent write-access across trust boundaries in a single session.** Verified failure modes as of April 2026:

- **Claude for Chrome:** Anthropic's own data reports 23.6% prompt injection success without mitigations, 11.2% with current mitigations.
- **Claude Desktop:** The Register reported (April 20, 2026) that Claude Desktop installs a Native Messaging bridge pre-authorizing three Chrome extension identifiers without a permission prompt. Audit and remove bridges for unused tools.
- **CVE-2025-53773 (CVSS 9.6):** demonstrated hidden prompt injection in GitHub pull request descriptions enabling remote code execution via GitHub Copilot.
- **EchoLeak (Microsoft 365 Copilot):** zero-click prompt injection accessing enterprise data.

### browser-agent-cross-trust-writes
Do not use browser agents with Gmail/Drive/financial account access in the same session where untrusted web content is loaded. Prompt injection from web pages escalates to data exfiltration.
*Source: intake 2026-04-23; Anthropic Claude for Chrome data, The Register report, CVE-2025-53773, EchoLeak.*

### native-messaging-bridge-pre-authorization
Review all auto-installed Native Messaging bridges monthly; remove for any Claude/OpenAI/Perplexity tool not in active use. Claude Desktop pre-authorizes three Chrome extension identifiers without prompting.
*Source: The Register, April 20, 2026.*

### consumer-ai-agent-primary-auth-scope
Use a separate browser profile or agent account with least-privilege connectors for business operations — do not give consumer AI agents the same auth scope as your primary Gmail. A compromised agent inherits the scope it was granted.
*Source: intake 2026-04-23; browser-agent threat model.*

### agent-write-access-without-per-session-approval
Never grant agents write access to financial accounts, code repositories (push), or email without a human approval step on every session. Standing write access + prompt injection = silent exfiltration.
*Source: intake 2026-04-23; browser-agent threat model.*
