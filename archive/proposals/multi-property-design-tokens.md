# Proposal — multi-property-design-tokens

**Source:** intake/2026-04-19.md — cross-project.md PROMOTE directive (allen-sports-floors 2026-04-18)
**Impact:** M
**Effort:** T
**Risk:** SAFE
**Routing reason:** IMPACT=M → PROPOSE

## Description
PROMOTE TO CLAUDIOUS directive: Multi-property design systems should centralize tokens in CSS custom properties from day one. From the ASF three-property unified design system approach.

## Proposed change block for learnings/patterns.md

```
### 2026-04-18 — PATTERN — Multi-Property Design System: CSS Token Centralization
**Severity:** MEDIUM
**Context:** allensportsfloors.com (Phase 1) is the foundation for asfgraphics.com rebuild (Phase 2) and app.asfgraphics.com (Phase 3).
**Learning:** All design tokens should live in `src/index.css` as CSS custom properties from the first commit, with Tailwind reading them via `hsl(var(--*))`. When Phase 2 begins, these become a shared package (e.g. `@asf/design-tokens`). Never hardcode color values in components — always use Tailwind classes referencing tokens. Never define ad-hoc colors — extend tailwind.config.js first. Token source of truth in CSS vars makes package extraction a refactor, not a rewrite.
**Applies to:** Any Logan project where 2+ properties will share a design system
```
