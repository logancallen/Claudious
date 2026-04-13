# Task Routing Table
## When Logan asks "where should I do X?" — answer from this table. No hedging.

---

## Routing Rules
1. Default to Claude unless this table says otherwise.
2. If a task spans multiple categories, route to the platform that handles the HARDEST part.
3. If two platforms are tied, pick the one Logan is already in (minimize switching cost).
4. Always name the specific platform. Never say "it depends."
5. If a task requires capabilities Claude lacks entirely (image gen, video gen, full-duplex voice), route immediately — don't attempt a workaround.

---

## Platform Rankings by Category (at Logan's subscription tiers)

These rankings reflect what Logan actually has access to: Claude Max ($200/mo), ChatGPT Business ($63.84/mo), Perplexity Pro ($20/mo), Grok Premium+ ($40/mo). Features locked behind tiers Logan doesn't pay for (e.g., Perplexity Max Computer) are ranked by what's available at his tier.

| # | Category | Winner | 2nd | 3rd | 4th | Winner Score |
|---|----------|--------|-----|-----|-----|-------------|
| 1 | Core reasoning | Claude | ChatGPT | Grok | Perplexity | 9 |
| 2 | Live web search | Perplexity | ChatGPT | Grok | Claude | 10 |
| 3 | Deep research | ChatGPT | Claude | Perplexity | Grok | 9 |
| 4 | Citation quality | Perplexity | ChatGPT | Claude | Grok | 9 |
| 5 | Memory | ChatGPT | Claude | Grok | Perplexity | 9 |
| 6 | File / doc analysis | Claude | ChatGPT | Perplexity | Grok | 9 |
| 7 | Coding | ChatGPT | Claude | Grok | Perplexity | 9 |
| 8 | Image generation | ChatGPT | Grok | Perplexity | Claude | 9 |
| 9 | Video generation | ChatGPT | Grok | Perplexity | Claude | 9 |
| 10 | Voice / audio | ChatGPT | Grok | Perplexity | Claude | 10 |
| 11 | Agentic execution | ChatGPT | Perplexity | Claude | Grok | 9 |
| 12 | Browser / computer | ChatGPT | Perplexity | Claude | Grok | 9 |
| 13 | Connectors | ChatGPT | Perplexity | Claude | Grok | 9 |
| 14 | Projects / workspaces | Claude | ChatGPT | Perplexity | Grok | 8 |
| 15 | Output tools | ChatGPT | Claude | Perplexity | Grok | 9 |
| 16 | Enterprise | ChatGPT | Claude | Perplexity | Grok | 9 |
| 17 | Pricing / value | Grok | Claude | Perplexity | ChatGPT | 8 |

### Summary: Categories won (no ties)
- **ChatGPT**: 11 categories — broadest platform
- **Claude**: 3 categories — deepest reasoning + docs + workspaces
- **Perplexity**: 2 categories — search + citations
- **Grok**: 1 category — best value per dollar

### When Claude wins (use Claude first)
- Core reasoning / nuanced analysis
- File and document analysis (200K context, multi-file)
- Projects and workspaces (persistent context, skills, knowledge files)
- Plus: any coding task where multi-file depth matters more than ecosystem breadth

### When ChatGPT wins (route to ChatGPT)
- Image generation, video generation, voice
- Agentic tasks (browser automation, form filling, booking)
- Deep research (most thorough, downloadable reports)
- Coding ecosystem (Codex + Copilot IDE integration)
- Connectors / integrations (largest App Directory)
- Enterprise admin (most mature enterprise admin console)

### When Perplexity wins (route to Perplexity)
- Any research requiring citations by default
- Quick factual lookups with source verification
- Competitive intelligence and vendor scouting

### When Grok wins (route to Grok)
- Real-time X / social monitoring (exclusive firehose)
- Best value when budget is the primary constraint
- Fast image gen when already in X ecosystem

---

## Task → Platform Routing

### Research & Information
| Task | Route To | Why |
|------|----------|-----|
| Quick factual lookup with sources | Perplexity | Citations-first by default. Fastest. |
| Competitive intelligence scan | Perplexity | Deep Research mode + citation density |
| Multi-source synthesis into a report | Perplexity → Claude | Perplexity gathers cited sources; Claude synthesizes into deliverable |
| Procurement vendor scouting | Perplexity | Cited docs, fast, audit-ready sourcing |
| Real-time news / breaking events | Grok | X firehose + web search, fastest raw speed |
| School-board sentiment / X monitoring | Grok | Exclusive X stream access, no competitor matches |
| Trending topics / social pulse | Grok | Real-time X data |
| Verify a claim across multiple sources | Perplexity | Citation transparency, cross-source comparison |
| Deep research report (final deliverable quality) | ChatGPT | Deep Research mode is most thorough (20-30 min but highest quality) |
| Current pricing / product specs lookup | Perplexity | Real-time web, cited, fast |

### Writing & Reasoning
| Task | Route To | Why |
|------|----------|-----|
| Long-form strategic analysis | Claude | Highest reasoning quality, extended thinking |
| Legal contract review / risk scan | Claude | 200K context, honest uncertainty signaling, compliance posture |
| Financial modeling / projections | Claude | Extended thinking + Artifacts for spreadsheet creation |
| Nuanced policy or technical writing | Claude | Best long-form coherence and instruction-following |
| RFP / proposal spec writing | Claude | Reasoning depth + file creation (docx, xlsx, pdf) |
| Client-facing email or communication | Claude | Professional tone drafting with context awareness |
| Blog post or marketing copy | Claude (draft) → ChatGPT (if images needed) | Claude writes better; ChatGPT adds visuals |
| Quick summary of a document | Claude | Already in-platform; 200K context handles large docs |
| Brainstorming / idea generation | Claude | Reasoning quality produces more substantive ideas |
| Persuasive writing with visual elements | ChatGPT | Canvas + DALL-E in one workflow |

### Coding & Development
| Task | Route To | Why |
|------|----------|-----|
| Multi-file architecture review | Claude | Claude Code + largest context for codebase reasoning |
| Large codebase refactoring | Claude | Multi-file context + terminal workflows |
| New feature implementation (complex) | Claude | Claude Code + Cowork + Artifacts |
| Quick isolated code snippet | Claude | Default platform; already in conversation |
| Debugging with stack trace | Claude | Reasoning depth for root cause analysis |
| Code review / PR feedback | Claude | Claude Code + GitHub plugin |
| Frontend component build | Claude | Artifacts with live preview |
| Database schema design | Claude | Extended thinking for complex relationships |
| Deployment automation / browser testing | ChatGPT | ChatGPT Agent for browser-based tasks |
| IDE-integrated coding workflow | ChatGPT | Copilot ecosystem reach (same model family) |
| CI/CD pipeline configuration | Claude | Multi-file context understands full project structure |
| API integration scaffolding | Claude | Reasoning + MCP connector awareness |

### Document & File Work
| Task | Route To | Why |
|------|----------|-----|
| PDF analysis (long documents) | Claude | 200K context, best document comprehension |
| Spreadsheet creation / analysis | Claude | Code execution + xlsx skill |
| PowerPoint / presentation creation | Claude | pptx skill + Artifacts |
| Word document creation | Claude | docx skill + professional formatting |
| Multi-document cross-reference | Claude | Largest effective context window for doc comparison |
| Data extraction from uploaded files | Claude | Native file analysis + code execution |
| Spreadsheet with charts/visualization | Claude | Code execution handles this end-to-end |

### Visual & Media Creation
| Task | Route To | Why |
|------|----------|-----|
| Photo-realistic image generation | ChatGPT | DALL-E 4, most versatile for commercial use |
| Floor-graphic mockup for proposals | ChatGPT | DALL-E in-conversation editing + Canvas |
| Cinematic / social media video | ChatGPT | Sora 2 Pro, most capable narrative video |
| Quick image for X / social post | Grok | Aurora, fast, already in X ecosystem |
| Diagram / flowchart / architecture visual | Claude | Artifacts (SVG, Mermaid, React) — native |
| Interactive data visualization | Claude | React/HTML Artifacts with live preview |
| Infographic with data + images | ChatGPT | Canvas + DALL-E in one session |
| Logo or brand asset creation | ChatGPT | DALL-E image gen + editing required |
| SVG icon or simple illustration | Claude | Code-rendered SVG through Artifacts |

### Voice & Communication
| Task | Route To | Why |
|------|----------|-----|
| Voice conversation (real-time) | ChatGPT | Only full-duplex voice, sub-1s latency |
| Voice-directed coding | Claude | Claude Code voice mode (20 languages) |
| Meeting prep / talking points | Claude | Reasoning quality for strategic framing |
| Language practice / pronunciation | ChatGPT | Advanced Voice Mode with emotion/tone |
| Voice memo → action items | ChatGPT | Voice input + memory + task extraction |

### Automation & Agents
| Task | Route To | Why |
|------|----------|-----|
| Book a flight / fill a web form | ChatGPT | ChatGPT Agent, most mature browser automation |
| Multi-step web research + booking | ChatGPT | Agent mode with autonomous browser |
| Desktop file organization / automation | Claude | Cowork (research preview, ~50% complex success) |
| Scheduled recurring task | Claude | Cowork scheduled tasks |
| Browser-based testing | ChatGPT | Agent with Chrome-in-cloud |

### Enterprise & Compliance
| Task | Route To | Why |
|------|----------|-----|
| Sensitive data analysis | Claude | Zero-data-retention option, SOC 2 Type II, ISO 27001 |
| Compliance document review | Claude | Best compliance posture + document analysis |
| Audit-ready research with sources | Perplexity | Every answer cited by default |
| Team knowledge base management | Claude | Projects + memory + file persistence |
| Admin / SSO / access management | ChatGPT | Most mature enterprise admin console |

---

## Logan's Specific Workflows

### Procurement RFP
1. **Perplexity**: Scout competitors, pull cited procurement docs, check BuyBoard listings
2. **Claude**: Write specs, model financials, legal contract scan, build proposal docs
3. **Grok**: Check school-board X sentiment, trending complaints, community concerns
4. **ChatGPT**: Generate floor-graphic mockups (DALL-E), finalize visual proposal elements

### Courtside Pro Feature Build
1. **Claude**: Architecture review, feature implementation, Claude Code for full dev workflow
2. **Claude**: Write technical docs, update API specs
3. **ChatGPT**: If deployment needs browser-based testing via Agent

### Client Communication
1. **Claude**: Draft all client-facing communications
2. **Perplexity**: If current market data or competitor info needed for the communication
3. **ChatGPT**: If communication needs embedded images or visual assets

### Daily Operations
- Morning research scan → **Perplexity**
- School-board / community pulse → **Grok**
- Coding / building → **Claude**
- Document creation → **Claude**
- Image needs → **ChatGPT** or **Grok**
- Voice conversations → **ChatGPT**
- Everything else → **Claude** (default)

---

## Anti-Patterns (Never Do These)
- Never use Claude for image generation — it cannot. Route to ChatGPT or Grok immediately.
- Never use Claude for video generation — it cannot. Route to ChatGPT (Sora) or Grok (Imagine).
- Never use Perplexity for long-form writing — it's a research scout, not a writer.
- Never use Grok for enterprise compliance work — weakest compliance posture.
- Never use ChatGPT for citation-critical research — citations are mode-dependent, not default.
- Never start a multi-file code project in ChatGPT — Claude Code handles this better.
- Never use Grok for large document analysis — 256K context limits are too restrictive.
