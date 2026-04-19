# Proposal — vite-vs-esbuild-decision-framework

**Source:** intake/2026-04-19.md — cross-project.md PROMOTE directive (allen-sports-floors 2026-04-18)
**Impact:** M
**Effort:** T
**Risk:** SAFE
**Routing reason:** IMPACT=M; domain-specific decision → PROPOSE for Logan to validate scope

## Description
PROMOTE TO CLAUDIOUS directive from allen-sports-floors: Vite vs esbuild decision framework for marketing sites. Cross-project learning from the ASF build.

## Proposed change block for learnings/patterns.md

```
### 2026-04-18 — PATTERN — Vite vs esbuild: Build Tool Decision Framework
**Severity:** MEDIUM
**Context:** allen-sports-floors chose Vite over Logan's default esbuild single-file pattern for the marketing site build.
**Learning:** Use Vite when: (1) build exceeds ~800 lines with multiple reusable components, (2) HMR during design iteration is valuable (preserves scroll position), (3) TypeScript compile-time safety is worth the file count. Use esbuild single-file when: (1) build is a tool/utility, (2) deliverable is genuinely one page of logic, (3) framework overhead is undesirable. Both deploy to Netlify identically.
**Applies to:** Any future marketing site or multi-section landing page in Logan's ecosystem
```
