# PROPOSAL — GrowthBook Runtime Feature Gates (Remote Kill-Switch Awareness)

**Finding-ID:** 2026-04-16-growthbook-tengu-feature-gates
**Disposition:** INTELLIGENCE — informs troubleshooting, not config
**Category:** PATTERN / TROUBLESHOOTING
**Source:** https://theplanettools.ai/blog/claude-code-330-env-variables-32-feature-flags

## Rationale
Anthropic operates 22+ runtime feature gates (prefix `tengu_`, evaluated hourly via GrowthBook) that can be toggled remotely without a Claude Code update. 6+ of these are remote kill-switches with the power to bypass permission prompts, disable features, or force exits. If a feature suddenly breaks, the cause may be remote — not local config drift.

**Critical gates:**
- `tengu_amber_flint` — Agent Teams / Swarm coordination
- `tengu_penguins_off` — Fast Mode kill-switch
- `tengu_onyx_plover` — AutoDream memory consolidation
- `tengu_kairos` — main persistent-assistant gate
- `tengu_amber_quartz_disabled` — Voice Mode
- `tengu_anti_distill_fake_tool_injection` — decoy tools for competitor-training-data poisoning (may surface phantom tools in `tools/list`)

## Risks
None to apply. Risk of NOT capturing this: wasted hours debugging a feature that was disabled by Anthropic, not by Logan.

## Required Actions (for Logan's review)
1. **Add to `learnings/gotchas.md`** a new entry: "When Agent Teams / Fast Mode / AutoDream / Voice break unexpectedly — check remote `tengu_*` gate status as troubleshooting Step 0 before debugging local config."
2. **Anti-distill awareness:** if anomalous tools appear in `tools/list` that don't match installed plugins, suspect `tengu_anti_distill_fake_tool_injection` rather than file a bug.
3. **No automation possible** — GrowthBook gates aren't user-visible. Treat as a stability variable.

## Rollback Plan
N/A — informational.

**Recommend:** small gotcha entry. Routes debugging effort correctly when an unexplained feature break occurs.
