# QUEUED: Anthropic Frontend-Design Skill (277K+ Installs)
**Finding-ID:** 2026-04-12-frontend-design-skill-official
**Source:** https://skillsmp.com
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
Anthropic's official frontend-design skill gives Claude a design system and philosophy before it writes any frontend code. 277K installs — the most popular skill. Significantly improves UI output quality.

## Implementation Instructions
1. Install: `claude skills add anthropic/frontend-design`
2. Automatically activates when Claude detects frontend work (React, HTML, CSS)
3. Logan already has custom `asf-ux-design` — this layers UNDERNEATH for non-ASF projects
4. Test on a non-ASF project first to evaluate generic frontend output improvement
5. If it conflicts with `asf-ux-design` on ASF work, add exclusion to one or the other

## Where to Document
- Add note to `learnings/techniques.md` about layering official + custom skills
- Update `asf-ux-design` SKILL.md description if exclusion needed

## Verification
- Build a small non-ASF frontend component before and after install
- Confirm `asf-ux-design` still takes priority on ASF Graphics work
