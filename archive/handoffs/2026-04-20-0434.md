# Handoff — Active Session State

**Updated:** 2026-04-19 (post-UI-sync session)
**From chat:** Claude Mastery Lab (routine UI-sync + Grok pipeline coordination + adaptability audit)
**Status:** Routine UI pastes mid-flight, Grok pipeline coordination complete, constitutional rule pending graduation

## Current Focus

Three threads, in priority order:

1. Complete the Routines UI paste sync. All three Claudious routines (Intake, Process, Curate) in the UI run stale pre-canonical-restructure prompts on Sonnet 4.6. Canonical versions in repo at scheduled-tasks/ are current and correctly specify Opus 4.7 in header metadata. UI does not auto-sync from repo — manual paste + manual model-dropdown change required per routine. Status at chat close: Process and Curate paste status unconfirmed. Intake held per sequencing constraint (parallel chat modifies scheduled-tasks/intake.md).
2. Coordinate Grok daily scan pipeline build with parallel Mastery Lab chat. Verdict given: ENHANCE. 6 fragility fixes sent back. 1 CRITICAL (OAuth Publish App — pipeline dies Day 7 without it; confirmed via Google developer docs and Nango blog). Parallel chat is implementing fixes and drafting Intake patch.
3. Graduate new constitutional rule no-hardcoded-entities-in-routines to canonical/prompting-rules.md via normal Intake/Process pipeline.

## Completed This Session

- Gmail secrets added to Claudious repo GitHub Secrets: GMAIL_USER=loganallensf@gmail.com, GMAIL_APP_PASSWORD=<app password generated against loganallensf@gmail.com with 2FA>. Logan confirmed both appear in Repository secrets list.
- Diagnosed Routines UI staleness. All three Claudious routines run the old pre-canonical-restructure prompts on Sonnet 4.6. Evidence: Logan's screenshot of Claudious Intake routine edit screen showed old prompt text and "Sonnet 4.6" in the bottom-right model selector.
- Confirmed today 6:15 AM scheduled Intake and 11:16 AM manual Intake ran on stale prompt. Evidence: archive/runs/2026-04-19.md ledger entry shows "outputs: intake/2026-04-19.md" (old path, not archive/intake/). canonical/active-findings.md accordingly still shows 2026-04-17 data — the stale prompt has no canonical update section.
- Generated CC prompt that displays all 3 routine prompts via CC view tool (preserves formatting past the chat rendering layer that strips code fences). Logan has the raw file contents ready to paste.
- Resolved routine notifications question. No per-routine or account-level notification toggle exists in Claude Code Routines UI for success/failure. Sourced: Google searches + GitHub issue #29928 (open feature request from March 2026). Functional equivalent already wired: daily email briefing as success signal, GitHub Actions failure email as failure signal. Do not search for this feature again — it does not exist.
- Parallel Mastery Lab chat coordination. Verdict: ENHANCE. 4 enhancements accepted by parallel chat: vocab alignment (credibility + type), kebab-id contract, Dead Zones routing to ledger not briefing. Bonus gist-based kebab-id exclusion list: SKIPPED by both chats — low marginal dedup value plus 5th failure mode. Revisit after 30 days of deployed.log data.
- Adaptability audit on Grok pipeline plan. Found 1 CRITICAL + 5 HIGH/MEDIUM hardcoded-entity fragilities. Full list sent back to parallel chat. See Grok Pipeline Coordination section below.
- Drafted constitutional rule no-hardcoded-entities-in-routines for canonical/prompting-rules.md graduation. Rule text recorded in this handoff (see section below).
- Answered parallel chat two open questions. Q1 Intake patch timing — draft after handoff not before, to avoid merge friction with UI paste. Q2 handoff generation — yes, via CC before new chat per User Preferences mandate.

## In-Flight Items

- Routine UI paste. Process status unconfirmed. Curate status unconfirmed. Intake held.
- Parallel chat implementing 6 fragility fixes and shipping non-Intake deliverables (GitHub Action, Python fetcher, archive/scan-inbox/ directory, scheduled-tasks/process.md schedule comment change, OAuth guide with corrected Publish App step, Grok Task prompt, Gmail filter recipe). Intake patch drafted to feature branch, held for Logan signal.
- Constitutional rule no-hardcoded-entities-in-routines pending entry to scheduled-tasks/intake.md Section D as a config proposal on next Intake cycle.

## Pending Items (queued, not started)

- Manual force-trigger sequence once all 3 routines pasted with new prompts plus Opus 4.7 model AND parallel chat Intake patch merged: trigger Intake → verify writes to archive/intake/ and canonical/active-findings.md → trigger Process → verify writes to archive/queue/ and archive/proposals/ and regenerates canonical/open-decisions.md → trigger Curate → verify writes archive/digest/ and canonical/briefing-today.md → confirm daily briefing email arrives within 5-10 min.
- Parallel chat OAuth walkthrough must include Publish App to Production step. Logan has not executed OAuth setup yet. Do not execute until parallel chat updates the walkthrough. Without this step, pipeline silently dies on Day 7.
- Extract hardcoded entity lists from scheduled-tasks/ prompts and canonical/toolchain.md into dedicated canonical config files. Target files: canonical/logan-current-stack.md (for the already-has list referenced by Grok), canonical/drift-check-targets.md (for intake.md Section C paths), canonical/grok-scan-sources.md (for Grok source list, only if Grok pipeline ships).
- Quarterly staleness-audit cadence for all canonical config files. Add as recurring agenda item in canonical/open-decisions.md.

## Deferred (consciously pushed to later)

- Drafting the Intake patch for Grok scan-inbox integration. Parallel chat owns this, drafts to feature branch, signals when ready to merge. Do not draft independently from this/new chat.
- 30-day revisit on Grok dedup REDUNDANT rate. Only meaningful after 30 days of deployed.log post-Grok-ingestion data exists.
- OneDrive mirror retirement. Known stale, tracked in userMemories, not touched this session.
- Migrations 026-028 ASF Graphics employee permission break. CRITICAL alert active since 2026-04-14. Separate dedicated audit session required. Out of scope here.

## Unresolved Questions

- Did Logan paste Process and Curate UI prompts before this chat ended? New chat MUST ask this as first substantive question. If yes, proceed to Intake sequencing wait. If no, provide Process and Curate canonical prompts via CC view tool pattern.

## Decisions Made This Session

- Routine UI prompts require manual paste from canonical repo versions. No API path for automated sync known. LOW confidence this is exhaustive — re-check if Anthropic ships Routines API.
- All three routines switch from Sonnet 4.6 to Opus 4.7 during UI paste. scheduled-tasks/*.md header metadata already specifies Opus 4.7; UI model dropdown was the discrepancy.
- Grok pipeline builds in parallel, not serialized after this work. One file-coordination point on scheduled-tasks/intake.md managed via parallel chat PR drafted then merged before UI Intake re-paste.
- Gist-based kebab-id exclusion bonus for Grok: SKIPPED. Low marginal dedup value, introduces 5th failure mode. Revisit after 30 days.
- Constitutional rule no-hardcoded-entities-in-routines graduates via normal Intake pipeline, not direct write. Preserves graduation discipline.
- Verification prompts must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block. First handoff attempt this session produced only the self-report, not the verification outputs — forcing a re-run. Rule candidate for canonical/prompting-rules.md: verification-prompts-suppress-self-report.

## Grok Pipeline Coordination — Full Context

Parallel Mastery Lab chat is building autonomous Grok daily scan pipeline. Sends Grok ecosystem scan email at 5:30 AM CT, GitHub Action fetches via Gmail API at 6:30 AM CT, writes to archive/scan-inbox/YYYY-MM-DD-grok-scan.md. Intake routine reschedules from 6am to 10am CT (Logan starts day at 9am after daycare dropoff), reads scan-inbox as new source, dedups against canonical/active-findings.md and archive/intake/ last 7 days.

Verdict given: ENHANCE.
Sequencing constraint: parallel chat modifies scheduled-tasks/intake.md — this/new chat holds UI paste of Intake until the PR merges.

Six fragility fixes sent to parallel chat (adaptability audit):
1. CRITICAL — OAuth walkthrough must include Publish App to Production step. Testing-mode External-user-type refresh tokens expire in 7 days per Google developer docs, Nango blog, CData KB, multiple Google Groups threads, and ActivePieces GitHub issue. Without Publish step, pipeline silently dies Day 7.
2. HIGH — Replace hardcoded Anthropic staff names in Grok prompt (Alex Albert, Mike Krieger, Jared Kaplan, Cat Wu). Use role-based targeting: current Anthropic staff actively posting on X about Claude Code / model releases / developer experience, identified each scan by recent @AnthropicAI @-mentions and their followers.
3. HIGH — Replace hardcoded community X handles (@elder_plinius, @simonw, @swyx, @skirano, @kepano, @rauchg). Use signal-based identification: recent quote-tweets from @AnthropicAI staff, high-upvote r/ClaudeAI mentions, authors of MCP servers with >5 servers. List rotates; re-identify each scan.
4. HIGH — Replace hardcoded competitor list (Cursor, Windsurf, Codex CLI, Gemini CLI, Cline, Aider). Move to canonical/toolchain.md#competitors section. Reference by URL from Grok prompt.
5. HIGH — Replace hardcoded Logan already has stack list (Opus 4.7, Claude Max, Claude Code v2.1.113, Sonnet 4.6, Haiku 4.5, 12 MCPs, 8 skills). Move to canonical/logan-current-stack.md (to be created). Reference by live fetch from Grok prompt. This list rots immediately on any upgrade.
6. MEDIUM — Source list for Grok scan (subreddits, docs URLs). Move to canonical/grok-scan-sources.md. Reference by URL.

Parallel chat answered at close:
- Q1 Intake patch drafting: AFTER handoff.
- Q2 Handoff generation via CC: YES, this turn.

## Constitutional Rule Draft (for graduation on next Intake cycle)

Rule name: no-hardcoded-entities-in-routines
Target file: canonical/prompting-rules.md
Rule text:

Any routine prompt, scan, or automated pipeline that targets people, products, URLs, versions, or organizational state must reference a canonical config file by URL, not inline the list. Exceptions: entities with zero rot risk like protocol names or company names. Quarterly staleness-audit reviews all canonical config files. Rationale: personnel leave, products die, versions ship. Lists rot on insertion. Config-file indirection means one edit updates all pipelines; inline lists require N edits across N prompts. Source: 2026-04-19 Grok pipeline adaptability audit.

Companion rule for Section D of intake.md:
Hardcoded entity scan — grep -rnE any X-handle pattern or two-word-capitalized proper-name pattern across scheduled-tasks/ directory. Any hit flags a proposal to extract to canonical config file.

Second rule candidate: verification-prompts-suppress-self-report.
Rule text: Prompts that request verification outputs (commit SHAs, file contents, git status) must explicitly instruct CC to suppress the Confidence/Assumptions/Context-health self-report block. Otherwise the self-report overrides the requested verification output, forcing re-run.

## Files Recently Changed This Session

None from this session except this handoff commit and its archive companion. This session was conversation and coordination only.

Pending commits from parallel chat (not this session, not on main yet):
- archive/scan-inbox/.gitkeep and README.md
- scripts/fetch_grok_scan.py
- scripts/requirements.txt
- .github/workflows/grok-scan-ingest.yml
- scheduled-tasks/process.md schedule comment change (7am to 11am CT)
- scheduled-tasks/intake.md scan-inbox read block (drafted, held for merge signal)

## Frustration Signals (do not repeat)

- Asked Logan to hunt for UI features without searching docs first. Correct behavior: web_search Anthropic docs before asking Logan about Claude product features. User pushback was direct and justified.
- Batched multiple sequential status-check questions at chat open. Acceptable only for validation with binary answers. Never for open-ended clarifying questions.
- Proposed one-step-at-a-time for parallel-independent tasks (three UI pastes). One-step-at-a-time applies only to dependent sequential work.
- Initial handoff CC prompt omitted the explicit suppression of CC self-report block. Result: CC returned only Confidence/Assumptions/Context-health and skipped the actual handoff work. Had to re-run. Rule added above.

## User Preferences Changes Pending

None from this session. All pending from prior session remain live.

Candidate for future consideration (not yet proposed):
- Explicit rule: when asked about Claude/Anthropic product UI features, web_search first rather than asking Logan to hunt. Implicit in tool discipline rules but may warrant explicit call-out given this session's friction.

## Next Actions for New Chat

Read this handoff first before responding. Execute in order:

1. Ask Logan: were Process and Curate UI prompts pasted plus models switched to Opus 4.7 before this chat ended? Yes or no answer gates next action.
2. If yes: confirm trigger readiness. Wait for parallel chat Intake patch PR signal before touching Intake UI.
3. If no: provide Process and Curate canonical prompts via CC view tool pattern for Logan to paste. Follow the pattern from this session — use view tool not markdown render, preserve line-number prefixes for Logan to strip on paste.
4. On parallel chat signal that Intake patch PR is ready: pull latest main, merge the PR (auto-merge workflow should handle claude/* branches automatically), generate single combined Intake paste via CC view tool on the updated scheduled-tasks/intake.md, Logan pastes to UI and switches model to Opus 4.7.
5. Once all 3 routines pasted and Opus 4.7 set: manually trigger Intake. Verify output path is archive/intake/ not intake/. If wrong, re-paste.
6. On verified Intake: trigger Process. On verified Process: trigger Curate. Confirm briefing email arrives.
7. After end-to-end validation: seed constitutional rule no-hardcoded-entities-in-routines into next Intake cycle via archive/intake/${TODAY}.md Section D as config proposal.
8. Seed second rule verification-prompts-suppress-self-report same way.
9. Add quarterly staleness-audit recurring item to canonical/open-decisions.md.

## System State Reference

- Repo: C:\Users\logan\Projects\Claudious on Windows PC. Mac Studio path unknown from this session.
- Current branch: main, clean tree after this handoff push.
- Canonical: 9 files, ~12.5K tokens. Stable since 2026-04-20 canonical-restructure merge.
- Archive: populated through 2026-04-19 runs.
- Routines (UI): 1/15 daily runs used per 2026-04-19 screenshot. Scheduled: Intake 6am, Process 7am, Curate 8pm CT, ASF docs-drift-guard 7am CT.
- Today's ledger archive/runs/2026-04-19.md shows: 11:16 intake COMPLETE (stale prompt, wrong output path), 12:02 process COMPLETE, plus additional ledger entries from reruns (f6fe38a, 189ae38).
- Auto-merge workflow: .github/workflows/auto-merge-claude.yml for claude/* branches.
- Daily briefing workflow: .github/workflows/daily-briefing.yml triggers on canonical/briefing-today.md changes to main, emails loganallensf@gmail.com via Gmail SMTP.
- Gmail secrets configured: GMAIL_USER and GMAIL_APP_PASSWORD (this session).
- Routine model in UI: Sonnet 4.6 on all three Claudious routines. Must switch to Opus 4.7 during paste.
- Routine prompts in UI: stale pre-canonical-restructure versions. Paste workflow in progress.
- Routine prompts in repo: current canonical versions at scheduled-tasks/intake.md, process.md, curate.md. These are source of truth.
