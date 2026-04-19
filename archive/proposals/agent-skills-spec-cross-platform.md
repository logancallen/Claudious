# PROPOSAL — Agent Skills Spec Adopted Cross-Platform (Codex CLI + ChatGPT)

**Finding-ID:** 2026-04-16-agent-skills-spec-cross-platform
**Disposition:** STRATEGIC — format standardization; reduces future platform lock-in
**Category:** CROSS-PLATFORM
**Source:** https://skillsmp.com ; https://medium.com/@unicodeveloper/10-must-have-skills-for-claude-and-any-coding-agent-in-2026-b5451b013051

## Rationale
Anthropic released Agent Skills as an open standard (Dec 2025). OpenAI adopted the identical format for Codex CLI and ChatGPT. Third-party marketplaces (SkillsMP, daymade/claude-code-skills, mhattingpete/claude-skills-marketplace) now list skills portable across Claude, Codex, and ChatGPT.

**Implications for Logan:**
- 15+ custom skills (financial-modeler, operating-system, negotiation-playbook, health-optimizer, logan-os, legal-scanner, macro-intelligence, harvest, etc.) are exportable to Codex / ChatGPT without rewrites. Hedge against Claude Code disruption.
- Gives Logan a portable IP layer — skills survive platform migrations.
- Inbound direction: any high-value skill missing from Logan's setup may already exist on the marketplaces.

## Risks
- **Marketplace skill quality varies.** Don't install blindly — same repo-audit discipline as context-mode MCP.
- **Portability ≠ parity.** Codex and ChatGPT may interpret YAML frontmatter fields differently (effort, allowed-tools, paths). Test on target platform before assuming portability.
- **Strategic risk of over-hedging:** Claude remains primary driver. Don't dilute Logan's Claude-native routing rules just because skills are portable.

## Required Actions (for Logan's review)
1. **No immediate config change required.**
2. **Inventory:** list Logan's custom skills and flag which are pure-text (financial-modeler, operating-system, negotiation-playbook — all portable) vs. which are Claude-Code-tool-dependent (harvest, setup-cowork — not portable).
3. **Exploration pass:** scan SkillsMP for skills in Logan's weak domains (intermediate-legal, mid-level tax planning). Audit before install.
4. **Routing rule update:** "Claude remains primary driver; Codex or ChatGPT for parallel execution when platform-specific capability is better; skill marketplace is a shared pool."
5. **Pre-mortem:** if Claude Code were disrupted tomorrow, which 5 skills are the highest priority to port first? Draft that list now.

## Rollback Plan
N/A — no config change.

**Recommend:** allocate 30 min to inventory + skills-marketplace scan. Skill portability is a cheap hedge with meaningful option value.
