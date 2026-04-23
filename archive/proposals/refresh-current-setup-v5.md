# Proposal — Refresh logan-current-setup to v5

**Source:** pioneer-2026-04 re-run
**Impact:** H (infrastructure-truth snapshot is stale 8+ days)
**Effort:** M (requires manual env-var audit on both machines)
**Risk:** SAFE
**Routing reason:** EFFORT=M + requires cross-machine manual verification → PROPOSAL (not queue)

## Description
`mastery-lab/logan-current-setup-v4.md` was last meaningfully updated 2026-04-14. Material drift since then:

1. **Model:** says Opus 4.6 / 4.7 preview. Actual 2026-04-22: Opus 4.7 is GA (`learnings/platforms/claude.md` 2026-04-19 entry).
2. **CC version:** says v2.1.104. Actual 2026-04-22: v2.1.116 (evidence: `archive/proposals/superpowers-trial-log.md` baseline).
3. **Plan price:** says Max $200/month. Actual plan price in `learnings/platforms/claude.md` entry (2026-04-11) is $100/month. Discrepancy needs resolution — either the file is wrong or the claude.md entry is wrong. Cross-check with Anthropic billing.
4. **Sonnet 4.5/4 1M context retirement (2026-04-30) absent** — should be called out in Known Gaps until actioned.
5. **Cowork Computer Use + Persistent Agent Thread** not reflected.
6. **Gap #1 (ASF Migrations 026-028) still CRITICAL 8+ days later** — needs either status update or explicit "blocked pending dedicated session."
7. **Gap #7 (Mac Studio env vars) still pending** — per last pioneer report Top-Leverage #1 was a one-sitting sweep; did it happen?
8. **MCP count discrepancy** (5+ / 7 / 12 across docs) — reconcile at source-of-truth moment.

## Proposed action
Create `mastery-lab/logan-current-setup-v5.md` with sections:
- Current models (Opus 4.7 GA, Sonnet 4.6, Haiku 4.5, `xhigh` effort)
- Current CC version (verify via `claude --version` on Mac + PC)
- Plan (verify price from billing; document if different on the two machines)
- Env vars: actual state on Mac Studio AND PC (source `env | grep CLAUDE_CODE` on each)
- MCP inventory: authoritative count with names
- Known gaps: explicitly re-state ASF 026-028 as blocker; note Mac Studio env var status; add Sonnet retirement action
- Replace v4 at same path; move v4 to `mastery-lab/archive/logan-current-setup-v4.md` for history

## Why not queued
Cannot be done from markdown-only changes within Claudious repo — requires running commands on both Logan's machines, reading billing, and verifying MCP list. This is a session task, not a processor auto-deploy.

## Dependencies
- Must be done AFTER the bundled-prompt-skills and bash-permission-alert-cleanup queue items deploy (so v5 reflects the clean state).
- Pairs with `close-bash-permission-bypass-proposal.md` (this run) — closing that proposal is a prereq for dropping it from v5's Known Gaps.

## Rollback
If v5 captures wrong state, revert commit; v4 is preserved at archive path.
