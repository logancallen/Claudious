# Handoff — 2026-04-20

**Recommended next-chat title:** `2026-04-20 — ASF — PWA Implementation`

---

## Current focus

PWA implementation on ASF Graphics. Phase 1 scope: vite-plugin-pwa install, manifest configuration, service worker with sensible default caching, icon set generation, install prompt component. Netlify deploy pipeline unchanged.

## Completed this session (MASTERY)

- **Chat title convention** — format `YYYY-MM-DD — [PROJECT] — [Topic]` with em-dash separators
  - User Preferences rewritten with convention + anti-force-fit rule + fallback derivation rule
  - canonical/chat-title-convention.md created and updated (PR #10, PR #11)
- **sync-knowledge.sh Mac parity fix** — env-aware via git rev-parse --show-toplevel, --dry-run flag, --help flag, unknown-arg guard (PR #12)
- **Dissolved Claudious Claude Project** — was unused, lone chat migrated to Mastery Lab. Claudious repo untouched. All editorial + operational chats now route through Mastery Lab.

## In-flight items

None. Session closed clean.

## Pending items (user action required)

- **Mastery Lab project spec edit** — 30-second find/replace in Claude.ai project settings:
  - Find: `**8 Claude Projects:** Genesis Framework, ASF Graphics, Courtside Pro, Court Designer, GE Diesel, Forensic Investigation, Claude Mastery Lab, Claudious`
  - Replace with: `**7 Claude Projects:** Genesis Framework, ASF Graphics, Courtside Pro, Court Designer, GE Diesel, Forensic Investigation, Claude Mastery Lab` followed by a new line: `**Claudious:** GitHub repo (not a Claude Project) attached as full-repo project knowledge to Mastery Lab. All editorial + operational chats route through Mastery Lab.`

## New findings

- **sync-knowledge.sh DIRS drift** (MEDIUM) — DIRS list references top-level dirs that moved under archive/. A real run would fail at git add. Not urgent (script not in active use) but should be fixed before anyone relies on it. Flagged in PR #12 description. Queue as follow-up PR.

## Decisions made

- **PWA path chosen over React Native / Flutter / Electron** for installable-app requirement on ASF Graphics and Courtside Pro. Reasoning: both apps are React + FastAPI + Supabase already; PWA is half-day effort per app, preserves Netlify deploy pipeline, works on iOS/Android/macOS/Windows/iPad. Capacitor wrap layered on top later if App Store presence becomes necessary (primarily a Courtside Pro trust-signal question for contractor demos).
- **ASF Graphics gets PWA first, Courtside Pro second** — lower stakes, smaller user base, faster feedback loop before applying learnings to Courtside.
- **Capacitor wrap deferred** — decision gate is contractor demos explicitly asking "is this in the App Store." If yes ≥2 times, greenlight. If no, PWA only.
- **Claudious Claude Project dissolved, not renamed** — Logan confirmed he does all Claude work in Mastery Lab. Editorial (Mastery Lab chat) vs infrastructure (Claudious repo) separation preserved.
- **Chat title convention applies cross-project** — enforced via User Preferences so every chat inherits the rule, not just Mastery Lab.

## Files recently changed

- User Preferences — full rewrite (applied in Claude.ai Settings, not in repo)
- canonical/chat-title-convention.md — created, then updated with fallback (PR #10 commit 4e0046a, PR #11 commit 98dd823)
- canonical/handoff-active.md — header field added for "Recommended next-chat title" (PR #10 commit 4e0046a)
- scripts/sync-knowledge.sh — env-aware rewrite (PR #12 commit 4e3c1fb)

## Unresolved questions

None from this session.

## Frustration signals (avoid next chat)

- **Verbose strategic responses** — Logan flagged an early PWA response as "rambled on and wasted context and usage." Next PWA session: keep each turn tight, match response length to whether Logan is iterating or passing downstream. Strategic decisions already made this session — next session is execution, not re-deliberation.
- **Ambiguous CC prompts** — first chat-title-convention CC prompt was incomplete; CC correctly pushed back asking for file contents, paths, branch flow. All CC prompts now must be fully self-contained with explicit file contents, paths, and branch flow instructions.

## User Preferences changes pending

None. Preferences were rewritten and applied during this session.

## Next session prep (ASF PWA)

First message in fresh ASF chat should read canonical/handoff-active.md and proceed directly to Phase 1 plan for PWA implementation:
1. Add vite-plugin-pwa to ASF Graphics build
2. Configure manifest (name, icons, theme color, display mode: standalone)
3. Service worker with network-first API, cache-first assets
4. Icon set (~12 sizes) via pwa-asset-generator
5. Install prompt component (listens for beforeinstallprompt)
6. Test on iOS Safari, Chrome Android, desktop Chrome/Edge/Safari
7. Ship

Plan-first per User Preferences — do not write code until Logan approves the Phase 1 plan.
