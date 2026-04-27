# Claudious — Playbook

**Last updated:** 2026-04-26

Two sections:
1. Prompting Rules — graduated, proven techniques only
2. Antipatterns — known failure modes

---

## 1. Prompting Rules

Universal rules (all models, all projects). Project-specific rules belong in that project's CLAUDE.md.

### Opus 4.7 Calibration

**literal-instruction-interpretation** — Opus 4.7 stopped silently repairing ambiguous prompts. Write what you mean. If a prompt worked on 4.6 via inferred intent, 4.7 may interpret literally and regress. Flag ambiguity in one sentence, proceed under most likely interpretation. Do not rely on Claude to silently fix under-specified prompts.

**explicit-effort-levels** — Agentic and research tasks need an explicit effort tag. Defaults are conservative. `/effort medium` (default single-file), `/effort high` (architecture, migrations, multi-file), `/effort xhigh` (ULTRAPLAN, adversarial review, hard proofs).

**task-budgets-over-max-tokens** — For production agentic loops, use Task Budgets beta (`task-budgets-2026-03-13`, min 20k) rather than raw `max_tokens`. Budget caps spend per task, not per response.

**no-sampling-params-4-7** — Never include `temperature`, `top_p`, or `top_k` on Opus 4.7 — they return a 400 error. Scrub SDK calls and CI configs.

**thinking-content-summarized-4-7** — Thinking content is omitted from responses by default in Opus 4.7. Set `display:"summarized"` in the `thinking` parameter to surface reasoning traces when needed (debugging, adversarial review, spec-gap analysis).

**tokenizer-inflation-4-7** — Opus 4.7 uses a new tokenizer consuming 1.0×–1.35× more tokens than 4.6 on the same text. A prompt that fit comfortably in 4.6's 1M window may not in 4.7. Measure before relying on historical token counts.

### Universal Prompting Technique

**plan-before-build-200-lines** — Any task touching 3+ files or producing >200 lines of code: spec-first, plan-mode review, approve, then execute. Applies to all projects.

**confidence-on-every-recommendation** — Every recommendation carries an explicit confidence level. <70% = ask Logan, don't guess. Applies to both autonomous runs and interactive advice.

**positive-framing-over-negative** — Claude 4.x fixates on negative instructions. "Don't write fluff" → Claude focuses on fluff. Rewrite as positive direction: "Begin directly with the core argument." Audit all "never / don't / avoid" before shipping a prompt or CLAUDE.md.

**no-all-caps-for-emphasis** — ALL CAPS emphasis is ignored in Claude 4.x. Use conditional phrasing ("if X then Y, else Z") or hierarchy (H2 section headers, bold for true keywords). Emphasis like "L99:" has no effect.

**context-before-question** — For prompts with >5K tokens of reference material, structure as [all context] → [question last]. Claude weights end of context most heavily. 30% better results on long-context prompts.

### Context Management

**compact-with-warm-cache** — Run `/compact Focus on <specifics>` within 5 minutes of last message to hit prompt cache discount. Every 10–15 turns (or ~25 on 1M context). 70%+ total token reduction over multi-hour sessions. Always provide a focus string.

**manual-compact-at-60** — Auto-compact fires at ~95% context — by which point quality has degraded ("lost in the middle"). Manually compact at 60% with preservation directive. After 3–4 compacts → `/summary` → `/clear` → paste summary into fresh session.

**context-buffer-reserved** — Claude Code reserves 33K–45K tokens for tool definitions, system prompt, safety. Usable context is ~955K, not the full 1M. Sub-agents have the same reduction — factor into task sizing.

**fresh-session-between-topics** — `/clear` before unrelated work. 98.5% of tokens in a 100+ message chat are spent rereading history. For major features: build in session 1, review in session 2 (fresh) or via Codex adversarial review.

### Code Workflow

**agentic-search-before-edit** — Glob + grep before editing. Read full relevant files, all callers, related tests. "Skim and assume" is Claude Code's lowest-scoring behavior dimension in Anthropic verification.

**grep-proof-on-self-reported-changes** — Every prompt that claims to add/modify a symbol must end with `grep -n <symbol> <file>` proof. Session-end summaries conflate intent with disk state. Audits must `git pull --rebase` first.

**writer-reviewer-separate-contexts** — Use a fresh context to review code. Preferred: Codex plugin (GPT-5.4) as adversarial reviewer — different model catches different bug classes, uses zero Claude tokens. Fallback: two Claude Code sessions.

**split-tactical-from-strategic** — When a bug has both a tactical 1-line patch and a strategic refactor path, ship the patch FIRST as a standalone commit. Never let the patch wait on the refactor. Document the larger scope in a committed audit doc.

**pre-post-count-gates-for-bulk-migrations** — Bulk-policy or bulk-data migrations: dry-run probe against live state returns a count, migration applies, re-probe expects target (usually 0). Advisor snapshots drift — always query live.

**roadmap-directive-in-commits** — `roadmap: close RM-XXX` in commit messages auto-updates `docs/roadmap.md` via post-commit hook dispatcher. One directive replaces manual cross-session backlog editing.

### Knowledge Architecture

**3-layer-claude-code-knowledge** — Separate `.claude/` into skills/ (procedural — what to do), memory/ (episodic — what went wrong), knowledge/ (reference — static docs). CLAUDE.md = instructions. MEMORY.md = facts. Mixing layers degrades all of them.

**rag-split-large-files** — Files >5KB degrade RAG retrieval. Split into topic files under a subdirectory. Each file: descriptive filename, H2/H3 headers, self-contained sections, key fact in first two sentences. RAG can activate at 2–6% context usage when many files exist.

**path-scoped-rules** — Rules that only apply in certain directories: create `.claude/rules/*.md` with YAML frontmatter `paths: ["frontend/**"]`. Rules activate only when Claude edits those paths. Keeps CLAUDE.md lean.

### Verification Culture

**freshness-check-on-technical-claims** — Claude's training data cuts off August 2025. React hooks, Supabase RLS API, FastAPI versions, TypeScript compiler behavior may all have changed. Pre-execution verification: `[FRESHNESS CHECK] Claim / Tool used / Result / Verdict`. Cannot verify → STOP. No guessing.

**double-check-verification-prompt** — After research-heavy output: "Double-check every single claim. Produce a table of what you were able to verify." Reduces hallucination risk in advisory and forensic investigation.

**render-layer-verification-after-fetch-fix** — After any "fetch fix," verify the render. Boolean fields (isArchived, isHidden, isDeleted, isDeprecated) are the most common render-layer culprits. Count DB rows vs rendered DOM — gap pinpoints the layer.

---

## 2. Antipatterns

Patterns that waste tokens, degrade output, or cause silent failures. Universal unless noted.

### Model / Prompt Hazards

**sampling-params-on-opus-4-7** — `temperature`, `top_p`, `top_k` on Opus 4.7 return a 400 error. Scrub SDK calls, CI configs, and any pinned API code.

**silent-prompt-repair-assumption** — Opus 4.7 interprets prompts literally — no inferred-intent repair like 4.6 did. Prompts that kind-of-worked may now execute the literal words and regress. Rewrite ambiguous prompts before migrating.

**all-caps-for-emphasis** — ALL CAPS is ignored in Claude 4.x. Intensity modifiers ("L99:", "MUST", "ALWAYS") have no effect. Use conditional phrasing or structural hierarchy instead.

**negative-instruction-fixation** — Claude 4.x increases attention on things you tell it NOT to do. "Don't write fluffy intro" → Claude focuses on fluff. Audit all "never / don't / avoid" and rewrite as positive direction.

### Context / Token Waste

**bloated-claudemd** — CLAUDE.md is loaded on every message, not just session start. Domain knowledge there costs tokens every turn regardless of relevance. Target <150 lines; move domain knowledge to `.claude/skills/` (on-demand) or `docs/knowledge/` (reference).

**connecting-unused-mcp-servers** — Every connected MCP server loads full tool definitions on every message. One server ≈ 8,400 tokens wasted if unused. Audit `/mcp` at session start; disconnect anything not needed for the current task. Prefer CLIs (e.g. `gh`) over MCP where equivalent.

**full-repo-project-knowledge-attachment** — Attaching a full repo as Claude Project knowledge dilutes RAG retrieval with operational history. Attach only the curated `canonical/` directory. Archive old artifacts separately.

**rag-unaware-knowledge-files** — Files >5KB without descriptive H2/H3 headers and front-loaded key facts perform badly under RAG chunking. RAG activates at 2–6% context usage when many files exist — not just near the limit.

**unbounded-agentic-loops** — Production agentic loops without Task Budgets (`task-budgets-2026-03-13`, min 20k) can blow through subscription quota on runaway reasoning. Budget per task, not per response.

### Code / Migration Hazards

**parallel-vocabularies-for-same-concept** — Multiple representations of the same domain concept (product_type in 5 different forms across frontend/backend/DB) generate silent-failure bugs. One canonical internal key (snake_case), labels for display only, normalization shim at every ingress boundary. DB CHECK constraints or enums catch drift at write time.

**postgrest-silent-1000-row-truncation** — PostgREST truncates DISTINCT query results at 1000 rows with no error. Truncation occurs alphabetically. Every Supabase query returning >500 rows needs explicit `.limit()` or range headers.

**hardcoded-hs256-on-supabase** — Supabase projects post-2026-Q1 default to ES256 asymmetric JWT keys. Backend verifiers pinning `algorithms=["HS256"]` fail with "alg value not allowed". Hit `/auth/v1/.well-known/jwks.json` before pinning algorithms; dispatch on token header `alg` instead of hard-coding.

**trust-cc-self-summaries** — Claude Code session summaries conflate intent with disk state. Every prompt claiming to add/modify a symbol must end with `grep -n <symbol> <file>` proof. Audits must `git pull --rebase` first.

**audit-on-stale-git-tree** — Writing an audit without `git pull --rebase origin main` first produces false claims. Migration numbers, constant existence, and schema state all drift. After any rebase, re-run grep claims.

**fetch-fix-without-render-verification** — Claiming a fetch bug is fixed without testing the render. Boolean fields (isArchived, isHidden, isDeleted) often gate visibility in the mapper. Count DB rows vs rendered DOM; any gap = render-layer bug that survived the fetch fix.

### Platform / Infrastructure

**onedrive-hosted-git-repos** — OneDrive corrupts `.git` index files and creates sticky `index.lock` conflicts. Never store any git repo in a OneDrive-synced folder.

**github-desktop-repo-locks** — GitHub Desktop holds file locks on repo paths. CLI git fails with `HEAD.lock` errors. Close GitHub Desktop before CLI git on Claudious.

**crlf-line-endings-on-hook-files** — Git on Windows converts LF → CRLF on `.sh` scripts, breaking bash execution. Any repo with hook files needs `git config core.autocrlf false` before committing hooks. Use LF endings on all hook and script files.

**cowork-cross-repo-access** — Cowork sandbox mounts a single working folder. Tasks needing two repos will fail silently. Run these in Claude Code, not Cowork. Also: Cowork sandbox has no git push auth — commits die on recycle.

**skill-description-truncation-over-34** — Claude Code silently truncates skill descriptions when total count exceeds ~34–36. No error thrown. Monitor total across global + project scopes; consolidate if approaching the cap.

**skill-negatives-yaml-field** — There is no `negatives:` YAML field in Claude Code skill frontmatter — community misreport. To block misfires, add exclusion phrases directly in `description`: "Do NOT trigger for: staging deploys, preview builds."

**hookspath-not-persisting-on-pc** — `git config core.hooksPath .claude/hooks` may not persist across sessions on Windows PC. Verify at session start; re-run if empty.

### Browser Agent Permission Hygiene

**Never grant a browser agent write-access across trust boundaries in a single session.** Verified failure modes as of April 2026:

- **Claude for Chrome:** Anthropic's own data reports 23.6% prompt injection success without mitigations, 11.2% with current mitigations.
- **Claude Desktop:** Native Messaging bridge pre-authorizes three Chrome extension identifiers without a permission prompt. Audit and remove bridges for unused tools.
- **CVE-2025-53773 (CVSS 9.6):** demonstrated hidden prompt injection in GitHub pull request descriptions enabling remote code execution via GitHub Copilot.
- **EchoLeak (Microsoft 365 Copilot):** zero-click prompt injection accessing enterprise data.

**browser-agent-cross-trust-writes** — Do not use browser agents with Gmail/Drive/financial account access in the same session where untrusted web content is loaded. Prompt injection from web pages escalates to data exfiltration.

**native-messaging-bridge-pre-authorization** — Review all auto-installed Native Messaging bridges monthly; remove for any Claude/OpenAI/Perplexity tool not in active use.

**consumer-ai-agent-primary-auth-scope** — Use a separate browser profile or agent account with least-privilege connectors for business operations — do not give consumer AI agents the same auth scope as your primary Gmail. A compromised agent inherits the scope it was granted.

**agent-write-access-without-per-session-approval** — Never grant agents write access to financial accounts, code repositories (push), or email without a human approval step on every session. Standing write access + prompt injection = silent exfiltration.
