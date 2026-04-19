# Learnings — Allen Sports Floors Marketing Site

**Purpose:** durable record of non-obvious bugs, gotchas, decisions, and patterns. Keeps Claude Code from re-learning the same thing every session.

**Format:** newest entries at top. Each entry tagged by type (GOTCHA / DECISION / PATTERN / BUG / PERF) and severity (CRITICAL / HIGH / MEDIUM / LOW).

**Promotion:** entries that apply beyond this project end with a `<!-- PROMOTE TO CLAUDIOUS: ... -->` comment. The `scripts/sync-knowledge.sh` script picks those up and syncs to the Claudious global repo.

---

## Active entries

### 2026-04-19 — DECISION — Brand-aligned design correction after logo review

**Severity:** HIGH
**Context:** Original handoff spec called for Instrument Serif italic + warm maple (#D2B48C) accent — an editorial luxury-goods aesthetic chosen before the actual ASF logo was provided. Logo is a monochrome (black/white/grey) circular athletic seal with bold italic sans-serif wordmark and an A-monogram mountain mark. The original direction actively conflicted with the logo's typography and palette, signaling brand inconsistency.
**Learning:** Design system decisions must be grounded in the actual brand mark, not a plausible-sounding interpretation of the business. Default to "make it the best you can" prompts require first establishing brand ground-truth via logo/visual assets before committing to fonts or colors. Specific corrections: swap Instrument Serif italic → Space Grotesk bold upright (matches logo typography energy without mimicking it); swap warm-maple accent → muted warm-grey (#A69A8F) that aligns with logo's monochrome palette while preserving enough warmth to avoid clinical feel; rename "Hardwood Resonance Glass" → "ASF Glass" (concept tied to maple no longer fits). Logo SVG displayed in navbar + footer; hero relies on typography.
**Applies to:** Any greenfield brand-led web build where the design system spec arrives before the brand mark has been reviewed. Default stance: ask for the logo before writing any CSS.

<!-- PROMOTE TO CLAUDIOUS: Request the brand's logo/mark BEFORE committing to font/color decisions on greenfield web builds. A plausible-sounding aesthetic (luxury editorial, premium tech, etc.) can actively contradict the real mark and signal brand inconsistency. Two-minute logo review prevents hours of design rework. -->

---

### 2026-04-18 — GOTCHA — Scaffold shipped without .gitattributes; CRLF risk on Windows

**Severity:** MEDIUM
**Context:** Initial scaffold for allen-sports-floors included `.husky/pre-push` and `scripts/*.sh` but no `.gitattributes`. On Windows clones with default `core.autocrlf=true`, git silently converts LF→CRLF on checkout, which breaks bash execution and silently disables the pre-push hook. Caught before push; amended the root commit with `.gitattributes` and `git config core.autocrlf false`.
**Learning:** Every new repo that contains shell scripts, husky hooks, or YAML files must ship with `.gitattributes` in the root commit. Minimum content: `* text=auto`, `*.sh text eol=lf`, `.husky/* text eol=lf`, `*.yml text eol=lf`. Also run `git config core.autocrlf false` locally per-repo on Windows. Verify with `git ls-files --eol` — all shell scripts should show `i/lf w/lf`. Do NOT rely on the Claudious-global gotcha entry to remember this — encode it in the scaffold itself.
**Applies to:** Any repo created on or accessed from Windows that contains shell scripts or git hooks.

<!-- PROMOTE TO CLAUDIOUS: Every new repo with shell scripts or git hooks must ship a .gitattributes file in the root commit with explicit LF enforcement; do not defer to global config -->

---

### 2026-04-18 — DECISION — Vite over esbuild single-file

**Severity:** MEDIUM
**Context:** Logan's default build pattern for prior projects is esbuild single-file JSX → Netlify static deploy. For this marketing site, Vite + multi-file TypeScript was chosen instead.
**Learning:** Use Vite when: (1) build will exceed ~800 lines with multiple reusable components, (2) HMR during design iteration is valuable (preserves scroll position), (3) TypeScript compile-time safety is worth the file count. Use esbuild single-file when: (1) the build is a tool/utility, (2) the deliverable is genuinely one page of logic, (3) framework overhead is undesirable. Both still deploy to Netlify identically.
**Applies to:** Any future marketing site or multi-section landing page build in Logan's ecosystem.

<!-- PROMOTE TO CLAUDIOUS: Vite vs esbuild decision framework for marketing sites -->

---

### 2026-04-18 — DECISION — Kansas removed from all public ASF copy

**Severity:** HIGH
**Context:** Prior project handoff and marketing materials referenced "Texas, Oklahoma, and Kansas." ASF has completed floors in Kansas historically but has no active Kansas operations as of April 2026.
**Learning:** All ASF Sports Floors public-facing copy references **Texas and Oklahoma only.** If a future prompt, AI assistant, or collaborator suggests adding Kansas, confirm with Logan before accepting. Same applies to any state claim — confirm against `docs/architecture.md § Business facts` before publishing.
**Applies to:** allensportsfloors.com, asfgraphics.com (when built), any ASF marketing or proposal collateral.

<!-- PROMOTE TO CLAUDIOUS: ASF service area is TX+OK only as of 2026-04 -->

---

### 2026-04-18 — PATTERN — Three-property unified-design-system foundation

**Severity:** MEDIUM
**Context:** Phase 1 (allensportsfloors.com) must be built with Phase 2 (asfgraphics.com rebuild) and Phase 3 (app.asfgraphics.com integration) in mind. Design tokens, glass recipes, and typography are defined here but must be extractable.
**Learning:** All design tokens live in `src/index.css` as CSS custom properties, and Tailwind reads them via `hsl(var(--*))`. When Phase 2 begins, these become a shared package (name TBD, likely `@asf/design-tokens`). Do NOT hardcode color values in components — always use Tailwind classes that reference the tokens. Do NOT define new ad-hoc colors — extend `tailwind.config.js` first.
**Applies to:** Any visual component in this repo. Any future ASF property.

<!-- PROMOTE TO CLAUDIOUS: Multi-property design systems should centralize tokens in CSS vars from day one -->

---

## Template for new entries

```
### YYYY-MM-DD — [GOTCHA | DECISION | PATTERN | BUG | PERF] — One-line summary

**Severity:** [CRITICAL | HIGH | MEDIUM | LOW]
**Context:** What was the situation? What code/session/prompt was involved?
**Learning:** The actual durable insight. What is the rule going forward?
**Applies to:** Scope — this repo only, or cross-project?

<!-- PROMOTE TO CLAUDIOUS: [only include if cross-project; describe the generalized lesson] -->
```
