# Task Routing Table
## When Logan asks "where should I do X?" — answer from this table. No hedging.

**Last Updated:** April 14, 2026
**Plans active:** Claude Max ($200/mo) | ChatGPT Business ($63.84/mo) | Perplexity Max ($200/mo) | Grok Premium+ ($40/mo)

---

## Routing Rules
1. Default to Claude unless this table says otherwise.
2. If a task spans multiple categories, route to the platform that handles the HARDEST part.
3. If two platforms are tied, pick the one Logan is already in (minimize switching cost).
4. Always name the specific platform. Never say "it depends."
5. If a task requires capabilities Claude lacks entirely (image gen, video gen, full-duplex voice), route immediately — don't attempt a workaround.
6. For Perplexity: always attempt Search before Deep Research. Always attempt Deep Research before Computer. Always attempt Computer before Orchestrator. Never skip rungs.
7. Batch all related Perplexity questions into one thread. Never open separate threads for related topics.

---

## Platform Rankings by Category

| # | Category | Winner | 2nd | 3rd | 4th |
|---|----------|--------|-----|-----|-----|
| 1 | Core reasoning | Claude | ChatGPT | Grok | Perplexity |
| 2 | Live web search | Perplexity | ChatGPT | Grok | Claude |
| 3 | Deep research | Perplexity | ChatGPT | Claude | Grok |
| 4 | Citation quality | Perplexity | ChatGPT | Claude | Grok |
| 5 | Memory | ChatGPT | Claude | Grok | Perplexity |
| 6 | File / doc analysis | Claude | ChatGPT | Perplexity | Grok |
| 7 | Coding | Claude | ChatGPT | Grok | Perplexity |
| 8 | Image generation | ChatGPT | Grok | Perplexity | Claude |
| 9 | Video generation | ChatGPT | Perplexity | Grok | Claude |
| 10 | Voice / audio | ChatGPT | Perplexity | Grok | Claude |
| 11 | Agentic execution (info) | Perplexity | ChatGPT | Claude | Grok |
| 12 | Agentic execution (action) | ChatGPT | Perplexity | Claude | Grok |
| 13 | Browser / computer use | Perplexity | ChatGPT | Claude | Grok |
| 14 | Multi-model synthesis | Perplexity | Claude | ChatGPT | Grok |
| 15 | Connectors / integrations | ChatGPT | Perplexity | Claude | Grok |
| 16 | Projects / workspaces | Claude | ChatGPT | Perplexity | Grok |
| 17 | Output tools (docs/slides) | Claude | ChatGPT | Perplexity | Grok |
| 18 | Real-time social / X | Grok | Perplexity | ChatGPT | Claude |
| 19 | Pricing / value | Grok | Claude | Perplexity | ChatGPT |

### When Claude wins
- Core reasoning, nuanced analysis, extended thinking
- File and document analysis (1M context, multi-file)
- Projects and workspaces (persistent context, skills, knowledge files)
- Coding — multi-file architecture, refactoring, Claude Code workflows
- All document creation (docx, xlsx, pptx, pdf via skills)

### When Perplexity wins
- Any research requiring citations by default
- Quick factual lookups with source verification
- Deep Research for competitive intelligence and domain briefings
- Computer for structured data extraction from known URLs
- Orchestrator for multi-site automated research sweeps
- Model Council for stress-testing high-stakes decisions across 3 models simultaneously

### When ChatGPT wins
- Image generation (DALL-E), video generation (Sora), voice (Advanced Voice Mode)
- Transactional agentic tasks (booking, purchasing, form-filling with actions)
- Overflow deep research when Perplexity credits are low (unlimited on Business plan)
- IDE-integrated coding (Copilot ecosystem)

### When Grok wins
- Real-time X / social monitoring (exclusive firehose)
- School-board sentiment, community pulse, trending topics
- Best value when budget is primary constraint

---

## Perplexity Credit Discipline (read before every Perplexity session)

**Monthly base:** 10,000 credits. Welcome bonus (35,000) is one-time and non-recurring.
**Observed burn rates:**

| Tool | Credits Per Use |
|---|---|
| Search | Free |
| Light Deep Research | 150–400 |
| Standard Deep Research | 700–1,200 |
| Heavy Deep Research | 1,500–2,500 |
| Computer — single page | 30–200 |
| Computer — multi-site | 500–1,500 |
| Orchestrator — chained | 1,000–5,000+ |
| Model Council | ~3x single query |

**Escalation ladder — never skip rungs:**
```
Search (free) → Deep Research (moderate) → Computer (high) → Orchestrator (highest)
```

**Thread consolidation is the #1 rule:** All related questions go in ONE thread. Separate threads for related topics is the primary credit drain. Six separate threads on related flooring topics = ~8,400 credits. One consolidated thread = ~2,000 credits. Same intelligence, 76% cheaper.

**Monthly budget allocation (10,000 base):**
- Deep Research sprints: 5,000 (4–6 consolidated threads)
- Computer targeted extractions: 2,000 (4–8 scoped tasks)
- Model Council strategic sessions: 2,000 (6–8 sessions)
- Buffer: 1,000

**Overflow rule:** When Perplexity credits are low → route heavy research to ChatGPT Deep Research (unlimited on Business plan, slower but free).

---

## Task → Platform Routing

### Research & Information

| Task | Route To | Tool / Mode | Credit Cost |
|------|----------|-------------|-------------|
| Quick factual lookup with sources | Perplexity | Search | Free |
| Current pricing / product specs | Perplexity | Search | Free |
| Verify a claim across multiple sources | Perplexity | Search | Free |
| Real-time news / breaking events | Grok | Web search | — |
| Trending topics / social pulse | Grok | X firehose | — |
| School-board / X sentiment monitoring | Grok | X firehose | — |
| Competitive intelligence scan | Perplexity | Deep Research (batched) | 700–2,500 |
| Domain briefing before Claude planning session | Perplexity | Deep Research (batched) | 700–2,500 |
| Multi-source synthesis into report | Perplexity → Claude | Deep Research → synthesize | 700–2,500 |
| Procurement vendor scouting | Perplexity | Deep Research (batched) | 700–2,500 |
| Pre-ULTRAPLAN failure mode research | Perplexity | Deep Research (batched) | 700–2,500 |
| Deep research (final deliverable quality, no credit pressure) | ChatGPT | Deep Research mode | Free (Business) |
| Structured data extraction from known URL | Perplexity | Computer | 30–500 |
| Multi-site competitor data sweep | Perplexity | Orchestrator | 500–1,500 |
| Public procurement portal scraping | Perplexity | Orchestrator | 500–1,500 |
| High-stakes decision stress-test | Perplexity | Model Council | ~3x query |
| Finance / SEC / analyst data | Perplexity | Finance Mode (Search) | Free |

### Writing & Reasoning

| Task | Route To | Why |
|------|----------|-----|
| Long-form strategic analysis | Claude | Highest reasoning quality, extended thinking |
| Legal contract review / risk scan | Claude | 200K context, legal-scanner skill |
| Financial modeling / projections | Claude | Extended thinking + financial-modeler skill |
| Nuanced policy or technical writing | Claude | Best long-form coherence |
| RFP / proposal spec writing | Claude | Reasoning depth + docx/xlsx/pdf skills |
| Client-facing email or communication | Claude | Professional tone + context awareness |
| Blog post or marketing copy | Claude (draft) → ChatGPT (if images needed) | Claude writes better; ChatGPT adds visuals |
| Quick document summary | Claude | Already in-platform; 1M context |
| Brainstorming / idea generation | Claude | Reasoning quality |
| Persuasive writing with visual elements | ChatGPT | Canvas + DALL-E in one workflow |
| Stress-test a plan before committing | Perplexity | Model Council — 3 models attack it simultaneously |

### Coding & Development

| Task | Route To | Why |
|------|----------|-----|
| Multi-file architecture review | Claude | Claude Code + 1M context |
| Large codebase refactoring | Claude | Multi-file context + terminal workflows |
| New feature implementation (complex) | Claude | Claude Code + Agent Teams + Artifacts |
| Quick isolated code snippet | Claude | Default platform |
| Debugging with stack trace | Claude | Reasoning depth for root cause |
| Code review / PR feedback | Claude | Claude Code + Codex adversarial review |
| Frontend component build | Claude | Artifacts with live preview |
| Database schema design | Claude | Extended thinking for complex relationships |
| CI/CD pipeline configuration | Claude | Multi-file context |
| API integration scaffolding | Claude | Reasoning + MCP connector awareness |
| Deployment automation / browser testing | ChatGPT | Agent mode with browser |
| IDE-integrated coding workflow | ChatGPT | Copilot ecosystem |

### Document & File Work

| Task | Route To | Why |
|------|----------|-----|
| PDF analysis (long documents) | Claude | 1M context, best document comprehension |
| Spreadsheet creation / analysis | Claude | Code execution + xlsx skill |
| PowerPoint / presentation creation | Claude | pptx skill + Artifacts |
| Word document creation | Claude | docx skill + professional formatting |
| Multi-document cross-reference | Claude | Largest effective context for doc comparison |
| Data extraction from uploaded files | Claude | Native file analysis + code execution |
| Quick formatted research output (shareable) | Perplexity | Labs — citation-native, no Claude tokens |
| Competitive analysis as formatted report | Perplexity → Labs | Research + format in one session |

### Visual & Media Creation

| Task | Route To | Why |
|------|----------|-----|
| Photo-realistic image generation | ChatGPT | DALL-E 4, most versatile |
| Floor-graphic mockup for proposals | ChatGPT | DALL-E + Canvas in-conversation editing |
| Cinematic / social media video | ChatGPT | Sora 2 Pro, most capable |
| Quick video already in Perplexity session | Perplexity | Labs — Sora 2 Pro available on Max |
| Quick image for X / social post | Grok | Aurora, fast, already in X ecosystem |
| Diagram / flowchart / architecture visual | Claude | Artifacts (SVG, Mermaid, React) |
| Interactive data visualization | Claude | React/HTML Artifacts with live preview |
| Infographic with data + images | ChatGPT | Canvas + DALL-E in one session |
| Logo or brand asset creation | ChatGPT | DALL-E image gen + editing |
| SVG icon or simple illustration | Claude | Code-rendered SVG through Artifacts |

### Voice & Communication

| Task | Route To | Why |
|------|----------|-----|
| Voice conversation (real-time) | ChatGPT | Full-duplex voice, sub-1s latency |
| Voice-directed coding | Claude | Claude Code voice mode |
| Voice-directed research / Computer tasks | Perplexity | Computer voice mode (Max) |
| Meeting prep / talking points | Claude | Reasoning quality for strategic framing |
| Language practice / pronunciation | ChatGPT | Advanced Voice Mode with emotion/tone |
| Voice memo → action items | ChatGPT | Voice input + memory + task extraction |

### Automation & Agents

| Task | Route To | Tool | Credit Cost |
|------|----------|------|-------------|
| Structured data extraction from known URL | Perplexity | Computer | 30–200 |
| Multi-site research sweep (auth-free sites only) | Perplexity | Orchestrator | 500–1,500 |
| Public RFP / procurement portal scraping | Perplexity | Orchestrator | 500–1,500 |
| Book a flight / fill a web form | ChatGPT | Agent mode | — |
| Multi-step web research + transactional booking | ChatGPT | Agent mode | — |
| Desktop file organization / automation | Claude | Cowork | — |
| Scheduled recurring tasks | Claude | Cowork scheduled tasks | — |
| Browser-based testing | ChatGPT | Agent + Chrome-in-cloud | — |

**Perplexity Computer pre-flight — required before every run:**
- [ ] Can Search or Deep Research answer this? If yes → stop, use those
- [ ] Is the target URL accessible without login or captcha? If no → skip, Computer will loop
- [ ] Is the task specific enough that success/failure is immediately obvious?
- [ ] Stop condition defined?

**Perplexity Computer prompt anatomy:**
```
TARGET: [Exact URL — never "find a site that..."]
TASK: [Single specific action — no compound goals]
OUTPUT FORMAT: [Table / list / JSON / summary — be exact]
STOP CONDITION: [After N results / if login required stop immediately]
```

**Perplexity Orchestrator prompt anatomy:**
```
GOAL: [End state in one sentence]
STEPS: [Numbered — each step is one action, no compound steps]
DECISION RULES: [Every branch defined — if X unavailable do Y, never leave undefined]
OUTPUT: [What to return — format and structure]
BUDGET: [Max pages/sites/iterations — default: 5 sites max, skip login-required, stop and report after budget]
```

### Enterprise & Compliance

| Task | Route To | Why |
|------|----------|-----|
| Sensitive data analysis | Claude | Zero-data-retention option, SOC 2, ISO 27001 |
| Compliance document review | Claude | Best compliance posture + document analysis |
| Audit-ready research with sources | Perplexity | Every answer cited by default |
| Team knowledge base management | Claude | Projects + memory + file persistence |
| Admin / SSO / access management | ChatGPT | Most mature enterprise admin console |

**Comet browser privacy caveat:** Do NOT use Comet for sensitive competitive intel, client research, or financial data. Perplexity collects Comet browsing history for ad targeting with no opt-out. Use standard Perplexity web interface for sensitive sessions.

---

## Logan's Specific Workflows

### Courtside Pro — Pre-Demo Research Sprint
1. **Perplexity Deep Research (1 consolidated thread):** Competitor surface specs, pricing, manufacturer landscape, MFMA compliance requirements — all in one thread
2. **Perplexity Model Council:** Stress-test pricing and positioning before contractor/manufacturer meetings
3. **Perplexity Orchestrator (if needed):** Sweep BuyBoard, public procurement portals, school district RFP sites — auth-free only, budget capped at 5 sites
4. **Claude:** Feed Perplexity outputs as tier_3 context → run ULTRAPLAN → architecture and proposal writing
5. **Grok:** School-board X sentiment, community concerns, trending complaints
6. **ChatGPT:** Floor-graphic mockups (DALL-E), visual proposal elements

### Procurement RFP
1. **Perplexity Deep Research (batched):** Scout competitors, pull cited procurement docs, check BuyBoard listings — one thread
2. **Perplexity Orchestrator:** Public bid portal sweep if needed
3. **Claude:** Write specs, model financials, legal contract scan, build proposal docs
4. **Grok:** School-board X sentiment
5. **ChatGPT:** Generate floor-graphic mockups, finalize visual proposal elements

### ASF Graphics Feature Build
1. **Perplexity Model Council (optional):** Stress-test architecture assumptions on complex features before committing
2. **Claude:** Architecture review, feature implementation, Claude Code for full dev workflow
3. **Claude:** Write technical docs, update API specs, sync knowledge files

### Client Communication
1. **Claude:** Draft all client-facing communications
2. **Perplexity Search:** If current market data or competitor info needed (free, instant)
3. **ChatGPT:** If communication needs embedded images or visual assets

### Daily Operations
- Morning research scan → **Perplexity Search** (free)
- School-board / community pulse → **Grok**
- Deep research needed → **Perplexity Deep Research** (1 consolidated thread, check credit budget first)
- Coding / building → **Claude**
- Document creation → **Claude**
- Image needs → **ChatGPT** or **Grok**
- Voice conversations → **ChatGPT**
- High-stakes decision → **Perplexity Model Council** → **Claude**
- Credits low → overflow research to **ChatGPT Deep Research**
- Everything else → **Claude** (default)

---

## Anti-Patterns (Never Do These)

- Never use Claude for image generation — route to ChatGPT or Grok immediately
- Never use Claude for video generation — route to ChatGPT (Sora) or Perplexity Labs (Sora 2 Pro)
- Never open separate Perplexity threads for related questions — consolidate into one thread
- Never launch Perplexity Computer or Orchestrator without completing the pre-flight checklist
- Never use Perplexity Computer on login-required or captcha-protected sites — will loop and drain credits
- Never use Perplexity Orchestrator without defining every decision branch upfront
- Never use Comet browser for sensitive competitive, client, or financial research — ad tracking with no opt-out
- Never use Grok for enterprise compliance work — weakest compliance posture
- Never use ChatGPT for citation-critical research — citations are mode-dependent, not default
- Never start a multi-file code project in ChatGPT — Claude Code handles this better
- Never use Model Council for tasks with obvious right answers — paying 3x for nothing
- When Perplexity credits are low, route heavy research to ChatGPT Deep Research (unlimited on Business plan)

---

## Perplexity Max — Feature Reference

| Feature | Credit Cost | Best Use |
|---|---|---|
| Search | Free | Quick factual lookups, spec checks, news |
| Deep Research | 150–2,500 | Multi-source synthesis, domain briefings, competitive intel |
| Model Council | ~3x query | Stress-testing high-stakes decisions across GPT-5.4 + Claude Opus 4.6 + Gemini 3.1 Pro |
| Computer | 30–1,500 | Structured data extraction from known auth-free URLs |
| Orchestrator | 1,000–5,000+ | Multi-site automated research sweeps — define tightly |
| Labs | Included | Quick formatted/shareable research outputs, Sora 2 Pro video |
| Finance Mode | Free | Analyst ratings, SEC filings, price targets |
| Comet Browser | Included | General browsing with AI context — avoid for sensitive research |
| Advanced Models | Included | Claude Opus 4.6, GPT-5.4, Gemini 3.1 Pro, o3-pro within Perplexity |
