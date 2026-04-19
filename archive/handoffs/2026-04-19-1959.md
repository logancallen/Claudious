# Handoff — Active Session State

**Updated:** 2026-04-20 13:40
**From chat:** Claude Mastery Lab (Opus 4.7 prompt upgrade + Claudious restructure)
**Status:** Restructure merged, pending validation

## Current Focus

Opus 4.7 prompt calibration system-wide + Claudious restructured into canonical/archive architecture so the 8 Claude Projects stop drowning in operational noise. Daily email briefing workflow added. Routines rewritten to maintain canonical files in place.

## Completed This Session

- New User Preferences live (Opus 4.7 calibration, context-aware response length, literal-interpretation clause, anti-hedging clause, plan-before-build with exemptions, Summary block for build work, handoff protocol, Mastery Lab nervous-system authority, one-step-at-a-time on sequential work)
- Claude Code upgraded to 2.1.113 on Windows
- Python SDK skipped on Windows (no Python projects there)
- Claudious architecture confirmed: cloud routines via claude.ai/code/routines
- System diagnostic complete: routines run intermittently (April 17 complete, April 18 failed silently), canonical knowledge base was stale on Opus 4.7
- CC mega-prompt executed: branch claude/canonical-restructure with 8 commits, merged to main
  - canonical/ structure: 9 files, ~12.5k tokens total
  - archive/ moves: 64 file renames, zero deletions
  - Intake/process/curate routines rewritten for canonical maintenance + Opus 4.7 calibration
  - scout-additions.md updated (removed KAIROS/Chyros, added Opus 4.7/CC 2.1.11x/Claude Design targets)
  - .github/workflows/daily-briefing.yml created (email-based Gmail SMTP)
  - CLAUDE.md + README.md updated for new architecture

## In-Flight Items

- GMAIL_USER + GMAIL_APP_PASSWORD secrets NOT yet added to GitHub Secrets
- First post-merge Intake not yet force-triggered; canonical-write behavior unvalidated
- Routine notifications (notify on completion/failure) not yet confirmed enabled at claude.ai/code/routines
- Email briefing workflow untested — first trigger fires after first curate run post-merge

## Pending Items (queued, not started)

- Claude Code upgrade on Mac Studio (npm update -g @anthropic-ai/claude-code)
- Python SDK ≥0.96.0 on Mac Studio (only needed for ASF Graphics FastAPI backend)
- Deprecated model string audit (claude-sonnet-4-20250514, claude-opus-4-20250514) in ASF Graphics and Courtside Pro codebases
- Breaking API parameter audit (temperature, top_p, top_k, thinking.budget_tokens) in ASF Graphics and Courtside Pro
- Try /less-permission-prompts skill on 12-MCP stack
- Expand skill descriptions using new 1,536-char cap on 8 custom skills
- Evaluate Task Budgets beta (task-budgets-2026-03-13) for production loops
- Opus 4.7 addendum block consideration for 8 project CLAUDE.md files (defer until User Preferences validates)

## Deferred (consciously pushed to later)

- Claude Design trial for Courtside Pro demos (low urgency)
- Claude Code desktop redesign trial on Mac Studio (UX-only)
- /ultrareview trial on real PR (wait for low-stakes PR)
- Splitting User Preferences into "always applies" vs "Mastery Lab only" vs "Claude Code only" sections (future optimization)
- Auto-regenerating handoff via CC hook at chat end (future optimization)
- Version-tracking User Preferences additions with dates/reasons (future optimization)

## Unresolved Questions

- Whether to re-attach 8 Claude Projects to canonical/ only vs keep full-repo attachment. Current state: full-repo attached, canonical/ becomes highest-signal files in the corpus. Functionally works either way. Low priority.

## Decisions Made

- Option 1 architecture chosen (canonical files updated in place). CC executed both Options 1 and 2 cleanly via canonical+archive physical split.
- Email-based briefing over Slack (no new platform)
- Handoff location: canonical/handoff-active.md with archives at archive/handoffs/YYYY-MM-DD-HHMM.md
- Mastery Lab = nervous system with final authority over User Preferences
- User Preferences changes always rewritten in full (never pasted as additions)
- One command at a time on sequential work

## Files Recently Changed

Main branch (post-merge, rebased SHAs):
- cc3fc9d — canonical seed (9 files)
- 626e082 — archive moves (64 renames)
- 78a3ec2 — intake rewrite
- 0ce8123 — process rewrite
- eb1b07a — curate rewrite
- f094bab — scout-additions update
- 19f94eb — daily-briefing.yml
- 2c85b7c — CLAUDE.md + README.md
- [handoff commit SHA — add after commit]

Note: SHAs changed from pre-rebase set (b4b2a3b, 6d08b0c, 0befd23, 0f9c36c, 4056ae5, 0e1fed1, 9c2d477, ee6cb82) because the branch was rebased onto updated main (which had the April 19 routine run already committed). Rebase resolved 12 file-location conflicts: 10 new files on main (intake/proposals/runs dated 2026-04-19) were moved to archive/ equivalents; 2 queue/ rename-delete conflicts were resolved as accept-deletion (files were legitimately deployed). Linear history preserved; no merge commit.

## Frustration Signals (what user pushed back on, do not repeat)

- Excessive questions when user says "execute" — take decisions, don't ask permission to ask permission
- Treating Claudious as autonomous agent system when it's actually shared knowledge layer for cross-project intelligence
- Checklist-style "what to update for Opus 4.7" answers when user asked for system optimization. Maintenance ≠ architecture.
- Not using project_knowledge_search when available — wasted tool calls
- Response length creep on iterative conversation (short for back-and-forth, complete for downstream-paste)
- Telling user to start new chat without preparing handoff first
- Batching multiple commands that needed sequential execution
- Pasting additions to User Preferences instead of full rewrites
- Pasting long prompts inline in chat instead of generating downloadable md files

## User Preferences Changes Pending

None. All pending changes from this session are live.

## Immediate Next Actions for New Chat

1. Read this handoff file BEFORE responding to anything else
2. Ask user: have Gmail secrets been added to GitHub Secrets? (GMAIL_USER + GMAIL_APP_PASSWORD)
3. Ask user: has first post-merge Intake been force-triggered at claude.ai/code/routines?
4. Ask user: have routine notifications been enabled (notify on completion + notify on failure)?
5. If all yes → validate email briefing arrived, confirm system working end-to-end, move to pending items
6. If any no → walk user through the setup one step at a time (follow "one command at a time" rule in User Preferences)

## System State Reference

- Repo: C:\Users\logan\Projects\Claudious
- Current branch: main (after merge)
- Canonical files: 9 files at canonical/, ~12.5k tokens total
- Archive: 11 directories moved from root to archive/, 64 files
- Routines: Intake 6am, Process 7am, Curate 8pm (verify timezone at claude.ai/code/routines)
- Auto-merge: .github/workflows/auto-merge-claude.yml for claude/* branches
- Daily briefing: .github/workflows/daily-briefing.yml triggers on canonical/briefing-today.md changes to main
