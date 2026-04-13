# Research Prompt Kit — Consolidated Mega-Prompts

**Purpose:** Two ready-to-paste prompts — one for Grok Deep Research, one for ChatGPT Pro (Deep Research). Each covers the full intelligence scope in a single query.

**Refresh cadence:** Run both monthly. After major Anthropic releases, run both immediately.

---

## GROK DEEP RESEARCH — Single Consolidated Prompt

Copy everything below the line and paste into Grok Deep Research:

---

```
I need a comprehensive research sweep of X/Twitter for Claude AI and Claude Code power-user intelligence from the last 60-90 days. Search posts, threads, and quote-tweets from real developers and builders — not AI content creators, course sellers, or hype accounts. Prioritize posts with meaningful engagement (likes > 10 or substantive reply threads). I need the actual techniques, configurations, and implementation details — not opinions about AI trends.

Cover ALL of the following areas in a single research report:

**1. CLAUDE.md Configurations & Skills Shared on X**
Find posts where developers share their actual CLAUDE.md file contents, .claude/skills/ configurations, Claude Code hooks setups, or settings.json customizations. Include the actual file contents or detailed snippets, plus the reasoning for WHY they structured it that way.

**2. Workarounds & Undocumented Behavior**
Find practitioner-discovered workarounds, undocumented behaviors, or fixes for problems Anthropic hasn't officially addressed. Specifically: context window management tricks beyond /compact, rate limit workarounds on Max plan, undocumented slash commands or flags, behavior differences between Opus and Sonnet in Claude Code, workarounds for loops/refusals/stuck states, auto-compact alternatives, and conversation history recovery techniques from ~/.claude/projects/.

**3. Multi-Agent & Parallel Workflows**
Find posts showing how developers run multiple Claude Code instances in parallel. Specifically: git worktree setups, the cascade method, tmux configurations, /batch usage patterns, writer/reviewer patterns, merge conflict handling between parallel agents, cost implications on Max plan, and Boris Cherny's "dozens of Claudes" workflow.

**4. Claude Code Plugins & Marketplace**
Find posts about /plugin marketplace plugins that developers actually use daily (not just tried once). Specifically: which plugins have highest impact for TypeScript/React production apps, the ykdojo dx plugin in practice, code quality/linting/testing/security plugins, and MCP-based plugins connecting to external services. Include complaints about the plugin ecosystem.

**5. Advanced Claude.ai (Non-Code) Power User Techniques**
Find posts about advanced Claude.ai usage for someone running 7+ projects with 6 custom skills. Specifically: project knowledge file architecture for optimal RAG retrieval, memory system manipulation and deliberate seeding strategies, User Preferences optimization, techniques for managing context in long conversations, effective use of the 1M token context window, and cross-project workflow patterns.

**6. Specific Independent Builders' Recent Tips**
Find the most actionable recent posts (last 30 days) from these specific people: @t3dotgg (Theo), @saborat or Sahil Lavingia, @bcherny (Boris Cherny), @thariqshihab (Thariq), @swyx, @AmjadMasad, @alexalbert__, @petersteinberger (Peter Steinberger), @adocomplete (Ado). For each, extract specific techniques and configurations, skip opinions and hot takes.

**7. Claude Code Source Leak Takeaways (March 31, 2026)**
Find all practical, actionable takeaways from the Claude Code source leak. Specifically: the ~44 feature flags and which are usable via env vars, the KAIROS autonomous agent system details, the /dream memory distillation pattern, the frustration detection regexes (exact patterns), anti-model-copying defenses and when they trigger, autocompact failure handling (MAX_CONSECUTIVE_AUTOCOMPACT_FAILURES), internal model codenames, and any developer who built local implementations from the leaked source.

**8. Last 7 Days Developments**
What are the most-discussed Claude developments, tips, and workflow innovations from the last 7 days? Include new feature announcements, Claude Code updates, new MCP integrations, novel workflow patterns with high engagement, power user tips that went viral, and complaints/issues that reveal useful workarounds.

For every finding, include: the poster's handle, approximate date, the actual technique/content shared, and engagement metrics where visible. Organize the report by the 8 sections above.
```

---

## CHATGPT PRO (DEEP RESEARCH) — Single Consolidated Prompt

Copy everything below the line and paste into ChatGPT with Pro / Deep Research mode selected:

---

```
Do a comprehensive deep research sweep across GitHub repositories, technical blogs, documentation sites, forums, and developer publications for the most actionable Claude AI and Claude Code intelligence available as of April 2026. I'm a developer running Claude Code daily on a React/FastAPI/Supabase production app, with 7+ Claude Projects, 6 custom skills, and Claude Max. I need advanced/power-user techniques only — skip anything beginner-level.

Cover ALL of the following areas in a single research report:

**1. Claude Code Best Practices from GitHub & Documentation**
Find the most-starred GitHub repos related to Claude Code configuration — CLAUDE.md examples, skills, hooks, plugins. Summarize every tip from the ykdojo/claude-code-tips repo (46 tips) with enough detail to implement each. Cover the awesome-claude / awesomeclaude.ai curated list. Cover Anthropic's official best practices from code.claude.com/docs/best-practices. Find any GitHub repos containing example CLAUDE.md files for real production projects. Find actively maintained Claude Code skill repositories.

**2. Claude Skills Architecture**
Research everything about building effective Claude Code skills (.claude/skills/) — Anthropic's official skill-building guide, YAML frontmatter spec, how skill triggering works, examples of well-built skills from GitHub with actual file contents, the difference between skills and CLAUDE.md, on-demand loading behavior, the meta-skill pattern (a skill that generates other skills), how to test and iterate on skill quality, community-built skills worth installing, and how /plugin relates to .claude/skills/.

**3. MCP Integration Patterns for Production Apps**
Research the current state of MCP integrations — which servers are most actively maintained and production-ready, TranscriptAPI MCP for YouTube transcripts (setup, limitations, costs), Playwright MCP for browser automation (real use cases), GitHub MCP capabilities inside Claude Code, custom MCP server development (feasibility for solo developer), MCP servers for Supabase/Netlify/Railway, the Composio approach vs individual servers, how MCP servers interact with Claude Code skills and hooks, performance implications of many connected servers, and security considerations.

**4. Context Engineering**
Research "context engineering" as the emerging discipline — what it is and why it's more important than prompt engineering, how Claude Code internally manages context (from the March 2026 source leak insights), the modular context library approach (Teresa Torres pattern), knowledge file design for optimal RAG retrieval in Claude Projects, how the 1M token context window actually behaves at high usage, token efficiency techniques, /compact vs /half-clone vs fresh sessions (when to use each), HANDOFF.md patterns for session continuity, how to structure information for accurate RAG retrieval, and the progressive disclosure pattern for skills.

**5. Claude Cowork & Desktop Automation**
Research Claude Cowork — what it can actually do as of April 2026, real user workflows (not Anthropic marketing), the independent Claude Cowork Substack community findings, limitations and failure modes, comparison to Claude Code for automation, file management and document processing workflows, cross-application automation patterns, security and permissions model, and whether it's worth investing time for a developer who already uses Claude Code heavily.

**6. Advanced Prompting for Claude 4.x Models**
Research prompting techniques specific to Claude 4.x (Opus 4.6, Sonnet 4.6) vs earlier versions — what changed from 3.x to 4.x, the 5 techniques DreamHost empirically validated for 4.x, extended thinking mode (when it helps vs adds latency), XML tag processing differences in 4.x, contract-style system prompt structure, few-shot examples effectiveness, intensity modifiers like "L99" (do they work?), negative vs positive instructions reliability, how the 1M context window changes prompting strategy, and model-specific behavior differences between Opus 4.6 and Sonnet 4.6.

**7. Claude Code Source Leak — Complete Technical Analysis**
Compile all practical insights from the March 31, 2026 Claude Code source leak across all major analyses (Alex Kim's blog at alex000kim.com, MindStudio's "8 Hidden Features" blog post, WaveSpeedAI's analysis, BuildFastWithAI's analysis, Reddit r/ClaudeCode threads, the Plaban Nayak Medium analysis, the Mehul Gupta Medium analysis, and Hacker News threads). Extract: how Claude Code works internally (multi-agent architecture, tool orchestration), features/behaviors users can leverage now, the context management and memory architecture, the KAIROS autonomous agent system, all discoverable feature flags and env vars, anti-abuse and defensive mechanisms, and any developers who built local implementations and what they learned.

For each finding across all 7 sections, provide specific implementation details — commands, file contents, configuration steps, or code snippets where applicable. Organize the report by the 7 sections above. Cite your sources with URLs.
```

---

## After Running Both

1. Copy Grok's full output → open a DISTILL chat in the Mastery Lab project → paste → let it extract techniques
2. Copy ChatGPT's full output → open a separate DISTILL chat → paste → let it extract techniques
3. Review extracted techniques for duplicates between the two sources
4. Approve and update the playbook
