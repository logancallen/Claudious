# Prompting Rules — Universal

**Last updated:** 2026-04-19
**Scope:** Rules that have proven universal (all models, all projects). Project-specific rules belong in that project's CLAUDE.md.

---

## Opus 4.7 Calibration

### literal-instruction-interpretation
Opus 4.7 stopped silently repairing ambiguous prompts. Write what you mean — if a prompt worked on 4.6 via inferred intent, 4.7 may interpret literally and regress.
*Source: `canonical/claude-state.md`; intake 2026-04-17.*

### explicit-effort-levels
Agentic and research tasks need an explicit effort tag. Defaults are conservative. Use `/effort medium` (default single-file), `/effort high` (architecture, migrations, multi-file), `/effort xhigh` (ULTRAPLAN, adversarial review, hard proofs).
*Source: `~/.claude/CLAUDE.md` effort mapping; Mythos v7 constitution.*

### task-budgets-over-max-tokens
For production agentic loops, use Task Budgets beta (`task-budgets-2026-03-13`, min 20k) rather than raw `max_tokens`. Budget caps spend per task, not per response.
*Source: Anthropic release notes; `canonical/claude-state.md`.*

### no-sampling-params-4-7
Never include `temperature`, `top_p`, or `top_k` on Opus 4.7 — they return a 400 error. Scrub SDK calls and CI configs.
*Source: `canonical/claude-state.md`; Anthropic 4.7 breaking changes.*

## Universal Prompting Technique

### plan-before-build-200-lines
Any task touching 3+ files or producing >200 lines of code: spec-first, plan-mode review, approve, then execute. Applies to ASF Graphics, Courtside Pro, Claudious, all projects.
*Source: `learnings/patterns.md` — Spec-First Plan Mode Workflow (2026-04-14).*

### confidence-on-every-recommendation
Every recommendation carries an explicit confidence level. <70% = ask Logan, don't guess. Applies to both autonomous runs and interactive advice.
*Source: `~/.claude/CLAUDE.md` response self-check; logan-os.*

### positive-framing-over-negative
Claude 4.x fixates on negative instructions. "Don't write fluff" → Claude focuses on fluff. Rewrite as positive direction: "Begin directly with the core argument." Audit all "never / don't / avoid" before shipping a prompt or CLAUDE.md.
*Source: `learnings/behavioral.md` — Claude 4.x Fixates on Negative Instructions; DreamHost testing.*

### no-all-caps-for-emphasis
ALL CAPS emphasis is ignored in Claude 4.x. Use conditional phrasing ("if X then Y, else Z") or hierarchy (H2 section headers, bold for true keywords). Emphasis like "L99:" has no effect.
*Source: `learnings/behavioral.md`; DreamHost empirical testing.*

### context-before-question
For prompts with >5K tokens of reference material, structure as [all context] → [question last]. Claude weights end of context most heavily. 30% better results on long-context prompts.
*Source: `learnings/behavioral.md` — Context-Before-Question.*

## Context Management

### compact-with-warm-cache
Run `/compact Focus on <specifics>` within 5 minutes of last message to hit prompt cache discount. Every 10–15 turns (or ~25 on 1M context). 70%+ total token reduction over multi-hour sessions. Always provide a focus string.
*Source: `learnings/techniques.md` — /compact with Warm Cache Timing.*

### manual-compact-at-60
Auto-compact fires at ~95% context — by which point quality has degraded ("lost in the middle"). Manually compact at 60% with preservation directive. After 3–4 compacts → `/summary` → `/clear` → paste summary into fresh session.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` CC-010.*

### context-buffer-reserved
Claude Code reserves 33K–45K tokens for tool definitions, system prompt, safety. Usable context is ~955K, not the full 1M. Sub-agents have the same reduction — factor into task sizing.
*Source: `learnings/techniques.md` — Context Buffer: 33K-45K Reserved Internally.*

### fresh-session-between-topics
`/clear` before unrelated work. 98.5% of tokens in a 100+ message chat are spent rereading history. For major features: build in session 1, review in session 2 (fresh) or via Codex adversarial review.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` WA-003.*

## Code Workflow

### agentic-search-before-edit
Glob + grep before editing. Read full relevant files, all callers, related tests. "Skim and assume" is Claude Code's lowest-scoring behavior dimension in Anthropic verification.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` CC-036; v7 constitution.*

### grep-proof-on-self-reported-changes
Every prompt that claims to add/modify a symbol must end with `grep -n <symbol> <file>` proof. Session-end summaries conflate intent with disk state. Audits must `git pull --rebase` first.
*Source: `learnings/gotchas.md` — CC file-change summaries cannot be trusted without grep proof.*

### writer-reviewer-separate-contexts
Use a fresh context to review code. Preferred: Codex plugin (GPT-5.4) as adversarial reviewer — different model catches different bug classes, uses zero Claude tokens. Fallback: two Claude Code sessions.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` CC-004 / CC-013.*

### split-tactical-from-strategic
When a bug has both a tactical 1-line patch and a strategic refactor path, ship the patch FIRST as a standalone commit. Never let the patch wait on the refactor. Document the larger scope in a committed audit doc.
*Source: `learnings/patterns.md` — Split tactical fixes from strategic refactors (2026-04-17).*

### pre-post-count-gates-for-bulk-migrations
Bulk-policy or bulk-data migrations: dry-run probe against live state returns a count, migration applies, re-probe expects target (usually 0). Advisor snapshots drift — always query live.
*Source: `learnings/techniques.md` — Pre/post-apply count gates.*

### roadmap-directive-in-commits
`roadmap: close RM-XXX` in commit messages auto-updates `docs/roadmap.md` via post-commit hook dispatcher. One directive replaces manual cross-session backlog editing.
*Source: `learnings/patterns.md` — Roadmap auto-close via post-commit hook dispatcher.*

## Knowledge Architecture

### 3-layer-claude-code-knowledge
Separate `.claude/` into skills/ (procedural — what to do), memory/ (episodic — what went wrong), knowledge/ (reference — static docs). CLAUDE.md = instructions. MEMORY.md = facts. Mixing layers degrades all of them.
*Source: `learnings/patterns.md` — 3-Layer Claude Code Knowledge Architecture.*

### rag-split-large-files
Files >5KB degrade RAG retrieval. Split into topic files under a subdirectory. Each file: descriptive filename, H2/H3 headers, self-contained sections, key fact in first two sentences. RAG can activate at 2–6% context usage when many files exist.
*Source: `learnings/patterns.md` — RAG Split for Large Knowledge Files; `learnings/gotchas.md` — RAG Activates Earlier Than Expected.*

### path-scoped-rules
Rules that only apply in certain directories: create `.claude/rules/*.md` with YAML frontmatter `paths: ["frontend/**"]`. Rules activate only when Claude edits those paths. Keeps CLAUDE.md lean.
*Source: `learnings/techniques.md` — Path-Scoped Rules via .claude/rules/.*

## Verification Culture

### freshness-check-on-technical-claims
Claude's training data cuts off August 2025. React hooks, Supabase RLS API, FastAPI versions, TypeScript compiler behavior may all have changed. Pre-execution verification: `[FRESHNESS CHECK] Claim / Tool used / Result / Verdict`. Cannot verify → STOP. No guessing.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` CC-037; v7 constitution Rule 0.*

### double-check-verification-prompt
After research-heavy output: "Double-check every single claim. Produce a table of what you were able to verify." Reduces hallucination risk, especially in Genesis advisory and forensic investigation.
*Source: `mastery-lab/claude-mastery-playbook-v2.md` WA-002; ykdojo/claude-code-tips.*

### render-layer-verification-after-fetch-fix
After any "fetch fix," verify the render. Boolean fields (isArchived, isHidden, isDeleted, isDeprecated) are the most common render-layer culprits. When a user reports a count mismatch, count DB rows vs rendered DOM — gap pinpoints the layer.
*Source: `learnings/gotchas.md` — Render-layer bugs survive fetch-layer fixes.*
