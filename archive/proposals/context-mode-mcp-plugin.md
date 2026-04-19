# PROPOSAL — context-mode MCP Plugin (50-90% Token Reduction for MCP-Heavy Workflows)

**Finding-ID:** 2026-04-16-context-mode-mcp-plugin
**Disposition:** TEST-FIRST — high-upside but new third-party dependency
**Category:** PLUGIN
**Source:** https://buildtolaunch.substack.com/p/claude-code-token-optimization ; repo at https://github.com/mksglu/context-mode

## Rationale
Open-source MCP plugin that intercepts large tool outputs and routes them into a sandboxed knowledge base instead of dumping them into the conversation. Source article reports 50-90% token reduction for MCP-heavy workflows. Logan runs 5+ MCP servers (Supabase, Figma, Cloudflare, Gmail, Drive, Claude-in-Chrome). Direct hit on the "Connecting Unused MCP Servers" antipattern — but inverted: keeps them connected at a fraction of the token cost.

Pairs with existing 2026-04-14 gateway-pattern and circuit-breaker proposals (defense in depth on MCP stability + cost).

## Risks
- **New third-party MCP dependency.** Repo quality, maintenance, security posture all unknown.
- **Indirection layer adds failure modes.** If context-mode misbehaves, every MCP tool call becomes a debugging target.
- **Possible incompatibility with existing MCP servers** that expect direct stdout return paths.

## Required Actions (for Logan's review)
1. **Audit the repo** — check commit cadence, issue tracker, license, maintainer reputation, supply-chain hygiene. Do not install blindly.
2. **Quarantine test first** — install on a throwaway Claude Code session (not tied to ASF/Courtside workflows). Run a heavy Supabase query and compare before/after token consumption via billing dashboard.
3. **Success criteria:** >40% reduction on a representative MCP-heavy session to justify the dependency. Below that, kill it.
4. **If adopted:** document install path in `learnings/techniques.md` and add a rollback note in case the plugin regresses or gets abandoned.

## Rollback Plan
MCP plugins are removable via `claude mcp remove`. Keep prior CLAUDE.md / mcp.json in `snapshots/` before install. If perf regression or unexpected behavior: `bash scripts/rollback-config.sh YYYY-MM-DD`.

## Open Questions
- Does context-mode support selective passthrough (some tools wrap, others direct)?
- Retention policy for the sandboxed KB — local disk vs remote?
- Interaction with Anthropic's own prompt cache?

**Recommend:** defer until Logan has an MCP-heavy session that hits a cost spike worth the R&D time. Budget: 30-45 min test window.
