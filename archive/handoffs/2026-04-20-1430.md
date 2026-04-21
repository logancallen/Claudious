# Handoff — 2026-04-20 (PM)

**Recommended next-chat title:** `2026-04-20 — ASF — PWA iOS Polish + Step 3 Service Worker`

---

## Current focus

Phase 1 PWA implementation on ASF Graphics. Steps 1-2 and Step 2.5 shipped. Desktop PWA installable and verified. iPhone install working but has 3 UX issues that need fixing before moving to Step 3 (service worker, install prompt, update notification, iOS install fallback).

## Completed this session (ASF)

- **Phase 1 Step 1-2 shipped as commit `a8e849e`** — vite-plugin-pwa@^1.2.0 installed, web app manifest configured (name, theme color `#1D1D1F`, standalone display, 10 icons + 2 maskable), Apple touch icons + PWA meta tags in index.html, 18 icon assets in `public/icons/`
- **Phase 1 Step 2.5 shipped as commit `442ad71`** — orphan root-level icon files removed (`public/favicon.ico`, `public/favicon.svg`, `public/apple-touch-icon.png`), reusable monogram SVG sources added to `docs/brand/` (`monogram.svg` white variant, `monogram-black.svg`, `icon-source-1024.png`, README)
- **Netlify deploy unblock as commit `c21c5ff`** — `.npmrc` with `legacy-peer-deps=true` added. Root cause: vite-plugin-pwa@1.2.0 peer deps don't cover Vite 8 (upstream issue [vite-pwa/vite-plugin-pwa#923](https://github.com/vite-pwa/vite-plugin-pwa/issues/923)), Netlify's plain `npm install` failed with ERESOLVE on both earlier pushes. `.npmrc` applies the `--legacy-peer-deps` flag repo-wide (local + CI).
- **Icon design + generation** — extracted ASF monogram (top "ASF + mountains" portion) from horizontal `ASF_GRAPHICS_LOGO_BLACK_copy.svg` into square asset. Generated 21-file icon set (standard 72–512, maskable 192+512, Apple touch 120/152/167/180/default, favicons 16/32/.ico). Dark `#1D1D1F` background chosen from 3 candidates (vs white, vs red) with iOS mask preview at 180/120/60px. Maskable variant verified against all 4 Android crop shapes.
- **Desktop PWA install verified on Mac** — standalone mode, dark status bar, manifest populated in Chrome DevTools, all 10 icons load
- **iPhone PWA install verified as installable** but with UX issues (see "In-flight items" below)

## In-flight items

3 iOS UX issues identified from iPhone install screenshots. ALL confirmed real, all specified below. These are the first action in the next chat.

### Issue 1: Status bar blends with page content (P0)
- **Symptom:** iPhone status bar text (time, signal, wifi, battery) sits on the white/light page background with no separation. Dynamic Island cutout visible but top edge looks like it bleeds into UI.
- **Cause:** `<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />` in `index.html`. `black-translucent` makes the status bar transparent, drawing the app's own background underneath — designed for dark app shells. ASF Graphics has a dark sidebar but light main content (`bg-[#F5F6F8]`), so white content collides with white status bar icons.
- **Fix:** Change `content="black-translucent"` → `content="default"` in `index.html`. `default` = white bg + black text, iOS-native look, safe on any page background.
- **File:** `index.html`
- **Confidence:** 90%

### Issue 2: Safari opens page zoomed in (P0)
- **Symptom:** When accessing `app.asfgraphics.com` via Safari (not the installed PWA), the page renders zoomed in. User has to pinch-zoom out.
- **Cause:** Viewport meta tag is minimal — `<meta name="viewport" content="width=device-width, initial-scale=1.0" />` — missing `viewport-fit=cover`. iOS Safari on notched devices heuristically zooms pages that don't declare safe-area awareness.
- **Fix:** Update viewport to `<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />`
- **File:** `index.html`
- **Confidence:** 85% (standard 2024+ PWA viewport directive)

### Issue 3: Bottom nav bar has no contrast with page (P0)
- **Symptom:** On iPhone, the bottom nav (Dashboard / Production / Design / More) sits on the same `#F5F6F8` background as page content. No border, no shadow, no tint shift. Red Dashboard icon is the only anchor. Brady/Chanté will miss the nav as a persistent control.
- **Cause:** Bottom nav component has no background color or border distinguishing it from page content.
- **Fix:** Give bottom nav white (`#FFFFFF`) background + 1px top border `rgba(0,0,0,0.08)`. Standard iOS tab bar pattern. Deterministic, works on any content background. NOT a shadow (harder to get right), NOT darker tint (less clear affordance).
- **Files:** Likely `src/components/BottomNav.jsx` or similar — search `src/` for the component that renders Dashboard/Production/Design/More on mobile. May be inline in `AppShell.jsx`. **First action of next chat should grep the codebase to locate the component before writing the fix.**
- **Counterargument considered and rejected:** Subtle shadow instead of border would feel more modern, but borders are deterministic and behaviorally safer. Do not dark-theme the nav (would make mobile feel cramped, no sidebar context to tie to).
- **Confidence:** 85%

### Optional Issue 4 (discuss, do not auto-fix)
The original horizontal ASF logo (`docs/brand/` or wherever it lives) may want a light-background variant for use inside the login page or letterhead. Not in scope for iOS fixes — raise if Logan wants to discuss it during Step 3.

## Pending items (not in scope for fixes, but upcoming)

- **Phase 1 Step 3 — Service worker + install prompt component.** Scope locked from prior session:
  - Register SW via `virtual:pwa-register/react` using `useRegisterSW` hook
  - Runtime caching: NetworkFirst with 5s timeout for API/Supabase calls, CacheFirst 30-day expiration for static assets, StaleWhileRevalidate for Cloudflare R2 (`asf-design-library` bucket) thumbnails
  - Precache app shell (HTML/JS/CSS bundles)
  - `<InstallPrompt />` component — listens for `beforeinstallprompt` (Chrome/Edge/Android), iOS fallback detection using `navigator.standalone === false` + iOS UA, shows "Tap Share → Add to Home Screen" instructions, dismiss persists 30 days in localStorage
  - `<UpdatePrompt />` component — `onNeedRefresh` toast with reload button using existing notification system
  - `src/lib/pwa.js` helper module for iOS detection + install event handling
  - Exclude `/auth/*` from SW runtime caching (Supabase auth callback interaction)
  - Runtime caching for GET only — POST/PUT/DELETE pass through (existing Supabase retry queue handles writes at app layer; double-handling = bug)
  - Update `docs/learnings.md` with PWA session findings
  - Open `docs/roadmap.md` RM-XXX items for Phase 2 (push notifications, background sync)
- **Capacitor native wrap deferred** — decision gate still "≥2 contractor demos ask about App Store presence," which is a Courtside Pro consideration, not ASF Graphics
- **iOS verification on Brady's actual phone** after iOS fixes deploy — Brady's iPhone is the real test, Logan's is the proxy

## New findings

- **Netlify "Why did it fail?" AI suggested bad fixes (MEDIUM severity for future reference)** — Netlify's deploy log AI recommended either "update vite-plugin-pwa to a Vite-8 compatible version" (no such version exists, upstream #923 still open) or "downgrade Vite to ^7.3.2" (loses Vite 8 Rolldown performance gains, unnecessary). Correct fix was `.npmrc` with `legacy-peer-deps=true` — repo-local, version-preserving. **Do not trust Netlify's AI recommendations for dependency conflicts without verifying against upstream issues.**
- **Logo aspect ratio trap (HIGH severity for future brand/icon work)** — The ASF Graphics full logo is horizontal 1.74:1 (`viewBox="0 0 434.04 249.4"`). Cannot use directly as square PWA icon without cropping or padding both looking bad. Solution: extract the square monogram portion (top "ASF + mountains" section, ~`0 0 434.04 148`) and use that for icons. Keep wordmark for headers/letterhead. **Don't try to force landscape wordmarks into square canvases for icons — this is a common amateur mistake.**
- **Safari's DevTools Manifest panel is inferior to Chrome's** — Safari shows no "Installability" indicator. Use Chrome/Edge DevTools for PWA manifest verification.
- **iOS `black-translucent` status bar style is a light-theme trap** — only works on dark app backgrounds. Default to `default` unless page top is dark.

## Decisions made

- **Square monogram for icon, not wordmark** — extracted from horizontal logo, 72% scale on standard icons / 56% scale on maskable (Android safe zone), dark `#1D1D1F` background for brand continuity with platform sidebar
- **`.npmrc` with `legacy-peer-deps=true` chosen over Vite downgrade or plugin swap** — one-line fix, repo-local, preserves Vite 8 performance. Remove when upstream [vite-pwa/vite-plugin-pwa#923](https://github.com/vite-pwa/vite-plugin-pwa/issues/923) ships.
- **Deferred service worker registration in Step 1-2** — deliberate scope separation. `injectRegister: false` in `vite.config.js` prevents SW registration without preventing manifest generation. SW files (`sw.js`, `workbox-*.js`) appear in `dist/` but inert — they get wired up in Step 3, not suppressed in Step 2.
- **Use `default` not `black-translucent` for iOS status bar** — light page content requires `default`, not translucent
- **Bottom nav gets white bg + 1px border, not shadow, not dark theme** — deterministic iOS-native pattern

## Files recently changed

- `package.json` + `package-lock.json` — added vite-plugin-pwa@^1.2.0 to devDependencies (commit `a8e849e`)
- `vite.config.js` — registered VitePWA plugin with manifest block, `injectRegister: false` (commit `a8e849e`)
- `index.html` — added theme-color + Apple PWA meta tags + 5 apple-touch-icon links + 3 favicon links, removed 3 old root icon references (commit `a8e849e`)
- `public/icons/` — created, 18 files (commit `a8e849e`, from zip upload)
- `public/favicon.ico`, `public/favicon.svg`, `public/apple-touch-icon.png` — removed (commit `442ad71`)
- `docs/brand/monogram.svg`, `docs/brand/monogram-black.svg`, `docs/brand/icon-source-1024.png`, `docs/brand/README.md` — added (commit `442ad71`)
- `.npmrc` — created (commit `c21c5ff`)

## Unresolved questions

None. All iOS fixes are specified and confidence-rated. Step 3 scope is already locked from prior session.

## Frustration signals (avoid next chat)

- **Safari DevTools confusion** — Logan hit the "Manifest" panel in Safari first, it's not as rich as Chrome's. Next chat: if there's a manifest question on iOS, direct to Chrome/Edge DevTools, not Safari.
- **F12 = volume on Mac** — Logan noted this in-session. Use `Cmd+Option+I` for DevTools on Mac, never reference `F12`.
- **Netlify build failures during mid-verification** — Logan was debugging the "No manifest detected" error for 20+ minutes before we hit the actual cause (deploy failing). Next chat: when diagnosing a deployment layer issue, check Netlify Deploys tab FIRST, not browser DevTools. Browser DevTools tell you the symptom; Deploy tab tells you the cause.
- **Verbose mid-decision responses** — Logan called for concise iterative turns, strategic format only for consequential decisions. Next chat is execution, not deliberation.
- **Don't scope-creep cleanup commits** — Step 2.5 was scoped to 2 tasks, Logan's preferences forbid bundling additional work in.

## User Preferences changes pending

None.

---

## Next session prep — Step 3 Service Worker + iOS Polish

First message in fresh ASF chat should read `canonical/handoff-active.md` and execute in this order:

1. **Ship the 3 iOS UX fixes FIRST as a single commit.** One prompt, one commit. File-change summary required:
   - `index.html`: change `apple-mobile-web-app-status-bar-style` from `black-translucent` to `default`
   - `index.html`: update viewport meta to include `viewport-fit=cover`
   - Bottom nav component (locate via grep): add `background: #FFFFFF` + `border-top: 1px solid rgba(0,0,0,0.08)`
   - Commit message: `fix(pwa): iOS UX polish — status bar, viewport, bottom nav contrast`
   - Push directly to main, no branch
   - Verify deploy goes green on Netlify before moving to Step 3
2. **Verify iOS fixes on iPhone** — re-install the PWA, confirm status bar has contrast, Safari no longer zooms, bottom nav has visible boundary
3. **Then write the Phase 1 Step 3 Claude Code prompt** for service worker registration + install prompt component + update prompt component. Scope already locked above.

**Plan-first per User Preferences** — propose the iOS fix prompt, wait for Logan approval, then proceed. Do not auto-ship. Same for Step 3 scope review before writing the prompt.
