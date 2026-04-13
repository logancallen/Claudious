# Supplemental Intelligence — Bootstrap Session (April 7, 2026)

**Source:** Genesis Framework bootstrap conversation, April 7, 2026
**Purpose:** Everything discovered during the bootstrap session that didn't make it into the four original project files. This file should be loaded into the Mastery Lab project as a knowledge file alongside the originals.

---

## 1. Revised Source Registry (Replaces Playbook Tiers)

The original playbook has a 4-tier source registry weighted toward official/endorsed channels. This was revised after recognizing that Anthropic partners and endorsed creators have an incentive to stay on-message and won't surface edge techniques, workarounds, or undocumented behaviors. The real bleeding-edge lives with independent builders.

### TIER 1: Independent Builders (No Anthropic Partnership — Highest Signal)

| Source | Platform | Why |
|---|---|---|
| **Theo (t3dotgg)** | YouTube (~500K subs) + X | Will openly criticize Anthropic. Processes tools as a working developer. Surfaces pain points and workarounds official channels won't. |
| **Sahil Lavingia (Gumroad CEO)** | YouTube + X | AI agents write 41% of Gumroad's code commits, targeting 80%. Production workflows, not tutorials. Documents what breaks. |
| **Alex Kim (alex000kim.com)** | Blog | Deepest independent analysis of the Claude Code source leak. KAIROS, /dream, frustration regexes, anti-copying defenses. |
| **The AI Corner Newsletter** | Web (the-ai-corner.com) | Independent. Tracks every Claude ship with setup instructions. |
| **r/ClaudeCode** | Reddit (~4,200+ weekly contributors) | Developers on real production codebases. Multi-agent tmux pipelines. Cost analyses. No filter. |
| **r/ChatGPTCoding** | Reddit | Cross-tool comparisons. "I switched because Y" posts reveal real advantages and limitations. |
| **Melvin Vivas** | Medium + LinkedIn | Created "Claude CEO" connecting Gmail, Brex, Mercury, Linear. Creative non-coding applications of Claude Agent SDK. |
| **Claude Cowork Substack** | Substack (@claudedesktop) | Independent community by and for Claude Cowork users. Real operator experiences. |
| **John Isaacson** | YouTube + Blog | Built full video editing pipeline with Claude Code. Record-to-publish under 1 hour. Shares what works AND what doesn't. |

### TIER 2: Official-Adjacent but Still High Value (Use With Filter)

| Source | Platform | Filter Notes |
|---|---|---|
| **YK Sugi / CS Dojo** | YouTube (1.9M subs) + GitHub | Independent but ecosystem-adjacent. GitHub repo (46 tips) is highest single-source density. |
| **How I AI (Claire Vo / ChatPRD)** | YouTube + Web (chatprd.ai) | Signal depends on the GUEST. Prioritize independent builder guests over Anthropic employees. 47 step-by-step workflows. |
| **Boris Cherny (@bcherny)** | X threads only | Head of Claude Code at Anthropic. X threads reveal features before docs. Won't surface workarounds, but WILL reveal power features nobody knows about. Don't prioritize his YouTube — it'll be on-message. |

### TIER 3: Source Leak Analysis (One-Time Extraction, Massive Value)

| Source | URL |
|---|---|
| Alex Kim's analysis | alex000kim.com/posts/2026-03-31-claude-code-source-leak/ |
| MindStudio "8 Hidden Features" | mindstudio.ai/blog/claude-code-source-code-leak-8-hidden-features |
| WaveSpeedAI analysis | wavespeed.ai/blog/posts/claude-code-leaked-source-hidden-features/ |
| BuildFastWithAI analysis | buildfastwithai.com/blogs/claude-ai-prompt-codes-2026 |

### TIER 4: Other Valuable Sources

| Source | What to Extract |
|---|---|
| **Corbin Brown** (YouTube, 160K subs) | Claude Code and Claude-specific videos only |
| **The AI Advantage (Igor Pogany)** | Claude-tagged videos only |
| **Skill Leap AI (Justin Fineberg)** | Claude-specific videos |
| **Edmund Yong** | Claude Code videos — high compression, advanced |
| **Matt Wolfe / FutureTools** | Only Claude-specific or major Anthropic announcements |
| **Alex Finn** | Claude-specific build tutorials only |
| **AI Explained** | Claude model analysis videos only |
| **Ryan Doser** | Claude Code skills and workflow videos. Has 20+ Claude Code skills for marketing. |

### Installable Intelligence Tool

**follow-builders** (GitHub: zarazhangrui/follow-builders) — A Claude Code skill that monitors top AI builders on X and YouTube, remixes their content into digestible summaries. Tracks Andrej Karpathy, Swyx, Amjad Masad, Peter Steinberger, Boris Cherny, Thariq, and more. Fetches content centrally, delivers digests.

Install: `git clone https://github.com/zarazhangrui/follow-builders.git ~/.claude/skills/follow-builders`

---

## 2. YouTube Transcript Extraction Pipeline

### Tool: youtube-transcript.io ($9.99/month, 1,000 credits)

**Settings:**
- Format: TXT (not SRT, VTT, or JSON)
- Timestamps: OFF (saves ~20-30% token waste, zero value for distillation)
- Files: Individual per video (not combined mega-file)

**Workflow:**
1. Go to youtube-transcript.io/bulk
2. Paste playlist URL or channel ID
3. Select All → Fetch Selected
4. Download as individual TXT files
5. Open DISTILL chat in Mastery Lab → paste transcript → get extracted techniques

**Credit budget (1,000/month):**
- Week 1 seed: ~60 credits (Theo + How I AI selected + Sahil)
- Week 2-3: ~55 credits (YK Sugi + John Isaacson + Corbin Brown + Anthropic)
- Ongoing: ~50 credits/week for new videos
- Reserve: ~835 credits/month

### Supplementary: TranscriptAPI MCP for Claude Code

For real-time single-video extraction directly inside Claude Code:
```bash
claude mcp add --transport http transcript-api https://transcriptapi.com/mcp
```
100 free credits, no card required. Use for one-off videos, not bulk processing. Sub-agent pattern keeps transcripts out of main context.

---

## 3. Research Prompt Kit (Grok Deep Research + ChatGPT Pro)

### Grok: Optimized for X/Twitter Intelligence

**G-01: CLAUDE.md & Skills shared on X** — Actual file contents, configs, reasoning from engineers
**G-02: Workarounds & undocumented behavior** — Practitioner-discovered fixes, rate limit tricks, loop escapes
**G-03: Multi-agent & parallel workflows** — Git worktrees, cascade method, tmux configs, /batch
**G-04: Plugins & marketplace** — Daily-use plugins, TypeScript/React specific, quality/security
**G-05: Claude Projects & memory power user** — RAG optimization, memory seeding, 1M context behavior
**G-06: Named independent builders** — Theo, Sahil, Boris, Thariq, swyx, Amjad, Alex Albert, Peter Steinberger, Ado
**G-07: Source leak practical takeaways** — Feature flags, KAIROS, /dream, frustration regex, anti-copying
**G-08: Weekly "what's new" sweep** — Last 7 days developments, tips, complaints revealing workarounds

### ChatGPT Pro (Deep Research): Optimized for Web-Wide Synthesis

**C-01: GitHub & documentation sweep** — Most-starred repos, CLAUDE.md examples, best practices docs
**C-02: Skills architecture** — How to build effective skills, YAML frontmatter, triggering, meta-skills
**C-03: MCP integration patterns** — Production-ready servers, custom MCP development, security
**C-04: Context engineering** — Modular context libraries, RAG design, token efficiency, handoff patterns
**C-05: Cowork & desktop automation** — Real workflows, limitations, vs Claude Code comparison
**C-06: Advanced prompting for 4.x** — What changed from 3.x, validated techniques, model-specific behaviors
**C-07: Source leak complete analysis** — All blog analyses synthesized into implementable insights

### Cadence
- **Weekly:** G-08 (~10 min)
- **Monthly:** G-01, G-02, C-01, C-03 (~2 hours total)
- **Quarterly:** Full set G-01 through G-07 + C-01 through C-07 (~4 hours)
- **After major Anthropic release:** G-08 + C-06 + G-02 immediately

### Consolidated Prompts
The full ready-to-paste prompt text for each is in `research-prompt-kit.md` (separate knowledge file).

---

## 4. First Grok Intelligence Dump — Raw Findings (April 7, 2026)

This is the unprocessed output from the first Grok Deep Research run. It should be run through DISTILL to extract formal playbook entries.

### High-Value Findings (Pre-DISTILL Summary)

**Confirmed new commands/features:**
- `/effort low/high` — Toggle intelligence vs speed on-the-fly. Boris Cherny confirmed Apr 4, 1k+ likes.
- `!` prefix — Run bash commands directly (e.g., `!ls`). Ado tip.
- `/powerup` — Interactive onboarding lessons. New as of Apr 7.
- `/dx:half-clone` — Halves context history deterministically (ykdojo dx plugin).
- `/dx:handoff` — Auto-generates HANDOFF.md with goal/progress/next steps.
- `/dx:clone` — Duplicates conversation with new UUIDs.
- `/dx:gha` — Shows GitHub Actions failures.

**Environment variables from source leak:**
- `CLAUDE_CODE_UNDERCOVER=1` — Forces no AI traces in output.
- `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` — Disables beta features/anti-features.

**CLAUDE.md consensus pattern:**
- ≤250 lines max. Beyond this, Claude drifts from instructions.
- Structure: stack + build commands + architecture rules + @imports + self-improving blocks.
- Offload details to `.claude/rules/*.md`, `AGENTS.md` (auto-imported), or `.claude/skills/`.
- @AGENTS.md reference in CLAUDE.md enables cross-tool compatibility (Claude Code → Codex, etc.).
- "Tiny, code-golfed recursive mantras" — injected every turn, so every word costs tokens.

**Frustration detection regex (exact from leak):**
```regex
/\b(wtf|wth|ffs|omfg|shit(ty|tiest)?|dumbass|horrible|awful|piss(ed|ing)? off|piece of (shit|crap|junk)|what the (fuck|hell)|fucking? (broken|useless|terrible|awful|horrible)|fuck you|screw (this|you)|so frustrating|this sucks|damn it)\b/
```
Triggers cheap sentiment handling. Implication: clear prompts > frustrated prompts, mechanically.

**Autocompact behavior:**
- `MAX_CONSECUTIVE_AUTOCOMPACT_FAILURES = 3` — After 3 consecutive failures, auto-compact disables for the session.
- Was wasting ~250k API calls/day globally before this fix.
- Practical: Manually `/compact` or use `/dx:half-clone` when it loops.

**KAIROS (unreleased autonomous daemon):**
- Background agent with GitHub webhooks, 5-min cron, daily logs.
- `/dream` skill for nightly memory distillation (summarize/consolidate).
- Proactive `<tick>` prompts.
- Not enabled yet, but the pattern is replicable via skills/hooks/cron.

**Anti-model-copying defenses:**
- `tengu_anti_distill_fake_tool_injection` — Injects misleading tool outputs to poison competitor training data.
- Triggers during suspected distillation/scraping scenarios.

**Parallel workflow tools:**
- **Maestro tool** (@ihtesham2005, 229 likes) — 1-12 sessions in grid, auto worktrees, MCP status, visual git graph. Supports mixed Claude/Gemini/Codex.
- Boris Cherny pattern: 5 terminal tabs → parallel checkouts → plan mode in each → round-robin → Opus one-shots best implementation. 5 plans evaluated = filtering, not waste.
- Engineers running 8+ agents simultaneously with clear guidelines (commit rules, Linear tracking, reviews for hotpaths).

**Top plugins (daily-use by production engineers):**
- ykdojo dx — most mentioned by serious engineers. Token efficiency + multi-agent continuity.
- Montana Labs skills pack — reusable blocks for coding agents.
- Waza skills — minimalist engineer habits (thinking/review/debug/docs).
- Website cloner skill — Uses Chrome MCP for exact fonts/colors/layout reproduction.
- AI-writing detector/rewriter — Flags and rewrites AI patterns in 2 passes.

**Conversation history:**
- Stored at `~/.claude/projects/` with folder names based on project path (slashes become dashes).
- Power users mirror to Obsidian/Notion via hooks/cron for search/visualization.
- One dev: 174 projects + 86 CLAUDE.md files + skills auto-mirrored.

**Memory and context patterns:**
- /dream-style distillation can be replicated manually via skills/hooks/cron.
- Obsidian vault mirroring `.claude/` (system/skills/memory + daily notes via scheduled tasks).
- Deliberate memory seeding via persistent projects.

---

## 5. Extraction Targets — YouTube Channels for Bulk Transcript Pull

Prioritized list for youtube-transcript.io bulk extraction. Extract Claude-specific content only.

**Week 1 (highest signal):**
1. YK Sugi GitHub README — paste directly, zero credits
2. How I AI full channel — bulk extract, prioritize independent builder guests
3. Theo (t3dotgg) Claude Code videos — bulk extract
4. Anthropic official Claude videos — bulk extract

**Week 2:**
5. Corbin Brown Claude-specific videos
6. The AI Advantage Claude-specific videos
7. John Isaacson Claude Code workflows
8. How I AI workflow pages (web copy, not video)
9. First Grok X research sweep

**Week 3+:**
10. Selective new videos from all sources
11. Monthly Grok sweep
12. Quarterly ChatGPT Deep Research sweep

---

## 6. Key Principle Captured in This Session

**"Partners and endorsed creators won't give you every latest tool or tip that's available but maybe not advertised."**

This principle should govern all source prioritization in the Mastery Lab. Official/endorsed sources provide the foundation and ground truth for feature behavior. Independent builders provide the edge — workarounds, undocumented features, production-tested patterns, honest critique, and the techniques that Anthropic either doesn't know about or doesn't want amplified. Both layers are necessary; neither is sufficient alone.
