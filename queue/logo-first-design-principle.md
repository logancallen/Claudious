# Queue Item — logo-first-design-principle

**Source:** intake/2026-04-19.md — Section D, cross-project.md PROMOTE directive (line ~105); allen-sports-floors 2026-04-19
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Target file:** learnings/techniques.md

## Change block

```
### 2026-04-19 — TECHNIQUE — Request Logo Before Committing to Font/Color Decisions
**Severity:** HIGH
**Context:** ASF Sports Floors greenfield build: entire design system was specced before the actual logo was reviewed, resulting in conflicts that required a full visual reset.
**Learning:** On any greenfield brand-led web build, request the actual logo/mark BEFORE writing CSS or committing to font/color choices. A plausible-sounding aesthetic (luxury editorial, premium tech, athletic etc.) can actively contradict the real brand mark and signal inconsistency. Two-minute logo review prevents hours of design rework. Specific trigger: the moment a client says "make it feel like X" — stop and ask "can I see the logo first?"
**Applies to:** Any frontend build that begins with brand/aesthetic direction — ASF, Courtside Pro, any future Logan client project
```

## Verification grep

`grep -c "logo.*before\|logo/mark BEFORE" learnings/techniques.md`
