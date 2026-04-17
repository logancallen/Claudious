# PROPOSAL — Background Monitor Plugin Manifest Key (v2.1.105)

**Finding-ID:** 2026-04-16-background-monitor-plugin-manifest
**Disposition:** TEST-FIRST — new plugin surface; verify no regression in existing plugins
**Category:** PLUGIN
**Source:** https://releasebot.io/updates/anthropic/claude-code

## Rationale
Plugins can now declare a top-level `monitors:` manifest key that auto-arms background scripts at session start or on skill invocation. Enables event-streaming (file watchers, webhook polls, log tails) without user action. Supersedes manual `background` invocations.

**Logan's candidate use cases:**
- Tail Supabase logs during active ASF Graphics dev sessions.
- Poll GitHub Actions for Courtside Pro CI status; surface failures mid-session.
- Watch `docs/learnings.md` across active projects for drift (complement to monthly `drift-check.sh`).

## Risks
- **Background scripts escape the main prompt loop** — can cost tokens without clear attribution, or thrash on hot-loop file changes.
- **Security surface:** a misconfigured monitor could exfiltrate data or DoS a remote endpoint.
- **Plugin interaction unknown** — adding `monitors:` to an existing plugin may or may not break compat if the runtime parses strictly.

## Required Actions (for Logan's review)
1. **Read the v2.1.105 release notes / docs** for the exact `monitors:` schema (scout report didn't include it verbatim).
2. **Pilot on one throwaway plugin** first — e.g., a dummy that writes a heartbeat to `/tmp/`.
3. **Verify trigger semantics:** `onSessionStart: true` fires once per session or on every restart?
4. **Budget enforcement:** decide a default poll interval floor (e.g., ≥ 5s) before first real monitor ships.
5. If useful: document as a pattern in `learnings/patterns.md` with a template manifest.

## Rollback Plan
Remove `monitors:` block from plugin yaml; restart session.

## Open Questions
- Are monitors scoped to the current project or global?
- Does Claude see monitor output in-context, or only when skill asks?
- Cost accounting for background tokens vs main thread?

**Recommend:** defer until a concrete monitor use case hits. Supabase log tail during ASF debugging is the most likely first.
