# Handoff — Mastery Lab

**Recommended next-chat title:** `2026-04-26 — MASTERY — DR-sweep canonical batch + handoff-index fix`

**From session:** 2026-04-26 (DR-sweep implementation kickoff — chat 1 of 4-chat plan)
**To session:** Chat A — DR-sweep canonical batch + handoff-index fix
**Generated:** 2026-04-26 UTC
**Prior handoff:** canonical/handoff-active-mastery.md replaced (prior content was 2026-04-24 PM, already archived to archive/handoffs/2026-04-24-MASTERY-prefs-amendment-handoff.md). Misrouted 2026-04-25 PM handoff archived to archive/handoffs/2026-04-25-MASTERY-PM-misrouted.md.

---

## Current focus

Implement remaining ~93% of the 4-engine DR sweep (Claude DR, ChatGPT GPT-5.5 Pro DR, Grok DR, Perplexity Model Council). Original synthesis: 27 NEW + 14 UPGRADE + 14 REDUNDANT items.

Four-chat execution plan:

1. **Chat A (next chat) — canonical batch + handoff-index fix + budget_tokens grep + stale-file cleanup.** Source data: canonical/active-findings.md (queued items), canonical/open-decisions.md (28+ proposals), canonical/briefing-today.md (priority surfaced), audits/sonnet-audit-2026-04-26.md (just produced), alerts.md (current critical alerts).
2. **Chat B — proposals batch + 2 graduations.** Phase 7 routing table proposed 11 new proposals + 2 graduations to queue. Cross-reference Phase 7 items with canonical/active-findings.md queued entries.
3. **Chat C — architectural decisions.** Managed Agents vs Claudious; Perplexity Agent API vs current FastAPI/multi-vendor SDK stack; Plugin Marketplace audit scope. Each is judgment-required, not mechanical.
4. **Chat D — Sonnet migration sprint.** Schedule for early-mid May (allow 30+ days reserve before June 15 deadline). Migration scope: 23 hits across 6 repos per audit.

Three time-sensitive deadlines drive overall sequencing:
1. **CRITICAL — June 15, 2026 (50 days):** claude-sonnet-4-20250514 and claude-opus-4-20250514 retire. 23 hits in 6 repos. Migration target: claude-sonnet-4-6 / claude-opus-4-7. Breaking API change: extended-thinking budget_tokens parameter deprecated on 4.6+, switch to thinking={"type":"adaptive"}.
2. **HIGH — May 5, 2026 (9 days):** Pro/Max /ultrareview 3-free-runs trial closes.
3. **LOW — May 31, 2026 (35 days):** ChatGPT Pro 10× Codex usage promo closes.

Note: April 30, 2026 1M-context beta header retirement has ZERO impact on Logan's code (audit Group C = 0 hits). Original 2026-04-25 handoff overstated this; corrected in alerts.md commit 3a0b336.

---

## Completed this chat (2026-04-26)

### Commits to Claudious origin/main
1. **e155e25** — alerts: add 5 entries from 2026-04-25 DR sweep (Sonnet retirement controlling constraint)
2. **3a0b336** — alerts: correct Sonnet retirement deadline (June 15 model-ID retirement is the real bite; April 30 beta-header retirement has zero scope hits)
3. **{this handoff commit SHA}** — handoff regen + audit file commit + index drift resolution

### Other work
4. **Sonnet pin audit complete.** 12-repo scope (skipped 2 stale duplicates after integrity check). Inventory: 23 Group A hits (all `claude-sonnet-4-20250514`) + 1 Group B hit + 0 Group C hits. Largest clusters: Documents/GitHub/asf-graphics-app backend/ (9 hits, 4 files) and Projects/courtside-pro app.jsx (7 hits). Report at audits/sonnet-audit-2026-04-26.md (now committed).
5. **Repo discovery output.** 14 repos found (4 in Projects/, 10 in Documents/GitHub/). 2 known duplicates (asf-graphics-app, courtside-pro). ASF active work is canonical in Documents/GitHub/ (88458cc, 2026-04-24, "feat(intake): IntakeFormV3 shell + ComponentCard + live-preview (6a)"); courtside-pro Projects/ canonical (4263629, 2026-04-17). Disconfirms userMemory note about Documents/GitHub migration not being executed for ASF.
6. **Windows PC Claudious clone repaired.** Corrupt local origin/HEAD ref. Fix: `git remote set-head origin -d && git remote set-head origin -a`. fsck clean otherwise.
7. **Three-chat split → four-chat split decision.** Sonnet migration moved to its own dedicated session (Chat D) due to scope (23 hits, 6 repos), breaking API change (budget_tokens), and 50-day window enabling proper testing.

---

## Pending — Chat A scope (next chat)

In priority order:

1. **Resolve handoff-routing convention.** canonical/handoff-active.md currently holds a drift-notice placeholder. Decide: (a) restore Arc Raiders content from archive if recoverable, (b) retire handoff-active.md and use only handoff-active-{project}.md, or (c) accept handoff-active.md as a duplicate/symlink of the most recent project handoff. Update CLAUDE.md SessionStart hook accordingly.
2. **Update canonical/handoff-index.md** to reflect resolution from #1 + bump Mastery row to 2026-04-26 PM (handoff regen commit handles the row bump; convention resolution is separate).
3. **CC v2.1.119 update** (DR-CC-101). Logan runs `claude update` on Mac Studio + Windows PC in side terminals, parallel. 30 sec each. Highest ROI/effort ratio in entire DR sweep.
4. **Canonical batch.** Phase 7 proposed 9 canonical updates. Source: canonical/active-findings.md queued entries (15 confirmed in project knowledge as of 2026-04-24). Process each as: classify (canonical update vs new proposal vs graduation), then ship via small CC prompts with diff-before-commit gates.
5. **budget_tokens grep** — preflight for Chat D Sonnet migration. Run:
   grep -rn "budget_tokens\|thinking.*enabled\|thinking={" /c/Users/logan/Documents/GitHub/asf-graphics-app /c/Users/logan/Projects/courtside-pro
   Inventory all extended-thinking call sites. Hits = breaking changes during migration.
6. **userMemory edit (queued from this chat).** ASF Graphics PC migration to Documents/GitHub/ is partially executed: asf-graphics-app active work is in Documents/GitHub/, courtside-pro still in Projects/. Update via memory_user_edits during Chat A.
7. **Stale-file cleanup** (per Logan's chat-close directive). See "Stale files to remove or replace" below.

---

## Pending — Chat B scope

8. **11 new proposals** from Phase 7 routing table. Cross-reference with canonical/active-findings.md queued items (15 known) and canonical/open-decisions.md (28+ existing proposals). Likely overlap — Chat B should triage before drafting net-new.
9. **2 graduations to queue** from Phase 7 routing table. Source: canonical/open-decisions.md proposals that have hit citation/evidence threshold.
10. **Linear MCP SSE → HTTP migration scheduling.** Final SSE removal date pending Linear announcement. Monitor Linear changelog; schedule migration when published.

---

## Pending — Chat C scope

11. **Architectural decision: Managed Agents vs Claudious.** Public beta announcement triggered evaluation tier per the 2026-04-25 DR sweep. Anthropic ships Managed Agents as a fully managed agent harness (sandboxing + tools + SSE streaming). Question: does Claudious's nervous-system architecture migrate to Managed Agents, coexist, or remain independent?
12. **Architectural decision: Perplexity Agent API vs current FastAPI/multi-vendor SDK stack.** Logan's research stack uses FastAPI + multi-vendor SDKs. Perplexity Agent API surfaces an alternative. Evaluate cost, latency, capability fit.
13. **Architectural decision: Plugin Marketplace audit scope.** Plugin Marketplace went GA in DR sweep window. Decide which plugins to evaluate vs ignore.

---

## Pending — Chat D scope (Sonnet migration sprint)

14. **23-hit migration across 6 repos.** Order from audit (largest cluster first):
    - Documents/GitHub/asf-graphics-app backend/ (9 hits, 4 files) — includes multi_agent.py:34 SYNTHESIZER (existing comment: "switch to opus if quality needs improvement" → candidate for Opus 4.7 upgrade)
    - Projects/courtside-pro app.jsx (7 hits)
    - prospect-signal (verify exact hit count from audit report)
    - cattle-signal trio (verify exact hit count from audit report)
    - allen-sports-floors / alpha-1 / floortrack-api / prospect-signal-api / prospect-signal-etl — clean, no migration
15. **Migration map:**
    - claude-sonnet-4-20250514 → claude-sonnet-4-6
    - claude-opus-4-20250514 → claude-opus-4-7 (or claude-opus-4-6 for conservative)
16. **Breaking API change:** budget_tokens parameter deprecated on 4.6+. Switch to thinking={"type":"adaptive"}. Inventory exposure via Chat A budget_tokens grep first.
17. **Per-repo workflow:** branch → /codex:review adversarial → manual test → PR → merge. Codex review especially valuable on multi_agent.py (concurrent Sonnet/Opus calls).
18. **Reserve buffer:** 30+ days between Chat D completion and June 15 deadline.

---

## Stale files to remove or replace in Chat A

Per project description: "This is NOT a transcript archive. Raw inputs are processed through a distillation pipeline and discarded." Audit-and-clean targets for Chat A:

1. **canonical/handoff-active.md** — currently a drift-notice placeholder per Phase 2 of this handoff regen. Resolve per Chat A pending #1.
2. **mastery-lab/research-prompt-kit.md** — likely stale post-DR-sweep. Verify currency: if the kit defines reusable instructions for future sweeps, retain. If it captures one-time DR sweep prep, archive to archive/research/.
3. **mastery-lab/supplemental-intelligence-bootstrap.md** — userMemory flagged as "not yet fully merged into the Mastery Lab playbook." Either merge into claude-mastery-playbook-v2.md (or v3 if it exists) or archive.
4. **mastery-lab/implementation-log-v4.md** — userMemory mentions logan-current-setup-v5 work; v4 implementation log may be superseded. Verify against latest version; archive prior versions.
5. **April 30 framing artifacts.** Run: grep -rn "April 30\|2026-04-30" canonical/ archive/active/ briefings/
   Each hit: verify whether it correctly frames April 30 as "1M-beta header retires (zero scope impact)" or incorrectly as "Sonnet model retirement deadline." Replace incorrect framings with June 15 model-ID retirement reference.
6. **canonical/briefing-today.md dated 2026-04-20** — verify whether this auto-regenerates daily (intake routine) or has stale content lingering. If stale, the next briefing run should refresh; if briefing pipeline is broken, that's a separate finding.
7. **Old DR sweep raw input dumps in mastery-lab/.** Project description says raw inputs should be discarded after distillation. Locate any DR sweep transcript dumps (Claude DR, ChatGPT GPT-5.5 Pro DR, Grok DR, Perplexity Model Council outputs from 2026-04-25). If still present, archive to archive/research/2026-04-25-{source}-sweep.md and remove from mastery-lab/.
8. **userMemory entries about Documents/GitHub migration "not executed."** Partial drift confirmed today. Update via memory_user_edits in Chat A.

These are scope flags only; actual cleanup happens in Chat A as discrete CC prompts with diff-before-commit gates.

---

## Decisions made this chat with reasoning

1. **Three-chat split → four-chat split.** Audit revealed Sonnet migration scope (23 hits + breaking API change + 50-day window) warrants a dedicated session. Splitting prevents canonical batch fragmentation.
2. **Audit scope: 12 repos, swap Group A clone for asf-graphics-app.** Integrity check disconfirmed canonical assumption (Documents/GitHub is active for ASF). Confirmed for courtside-pro (Projects/ canonical). 2 stale duplicates skipped.
3. **alerts.md correction.** Group C = 0 audit finding revealed April 30 deadline doesn't bite Logan's code. Corrected from CRITICAL Apr 30 to LOW Apr 30 (tracking only) + new CRITICAL June 15 (real bite).
4. **Audit file path: audits/, not archive/audits/.** Active-tracking visibility; retention pattern revisit deferred.
5. **alerts.md location: root, not canonical/.** Established file, prior task already edited it. Canonical/ namespace question logged as separate refactor candidate.
6. **End chat at ~73% context.** Canonical batch is 9 distinct routing decisions; partial completion = fragmented state. Fresh chat with full context wins.
7. **canonical/handoff-active.md as drift-notice placeholder.** Did not unilaterally restore Arc Raiders content (may not be recoverable) or retire the convention (Logan's call). Drift-notice surfaces the question without committing to either path.

---

## Frustration signals / lessons — this chat

1. **Path-bug pattern repeated.** I prompted CC against canonical/alerts.md when the actual file is at root. CLAUDE.md from prior session already had a "verify path against project knowledge first" rule — repeated anyway. Stronger fix candidate: any CC prompt that names a file path must include `cat $PATH || ls -la $(dirname $PATH)` preflight before write/edit. Surfaced as User Preferences candidate #6.
2. **Deadline framing without verification.** I shipped alerts.md initial entries framing April 30 as 4-day fire drill. Audit revealed it doesn't bite. Mitigation: evidence-gate any "controlling deadline" framing via inventory audit before alerts.md commit. Surfaced as User Preferences candidate #7.
3. **Repo-discovery scope-gate fired correctly** but didn't anticipate the duplicate-clone case. Could have been preempted with one git remote get-url check at audit-prompt drafting time.
4. **CC's diff-before-commit gate caught SYSTEM tag and severity vocabulary mismatches.** Pattern is working — keep as standard for any canonical write.
5. **Group C = 0 was a high-value scout finding** that prevented a 4-day fire drill on a 50-day problem. Audit-before-alert ordering would have caught this earlier.
6. **Chat-paste truncation of long CC prompts.** First chat-end-handoff attempt arrived at CC truncated (Phases 0-3 + most of HEREDOC body lost). Fix used: write full prompt to /mnt/user-data/outputs/ and have Logan paste from file. Surfaced as User Preferences candidate #8.

---

## User Preferences changes pending

Carry-forward candidates from prior handoffs (not addressed this chat):
1. Workflow-permission-preflight rule.
2. Archive filename convention reconciliation (User Prefs spec vs actual repo drift).
3. Memory vs canonical conflict resolution protocol.
4. Sunday-bias override.
5. Zero-bracketed-TODOs rule for canonical writes.

New candidates from this chat:
6. **Path-existence preflight rule for CC prompts.** Add to "Code and build" section: "Any CC prompt that writes to or edits a specific file path must include `cat $PATH || ls -la $(dirname $PATH)` preflight before the write/edit. Non-existent paths silently mask 'no match' as 'no result' and have caused real bugs." Twice-burned in 24 hours; warrants codification.
7. **Audit-before-alert rule.** Add to "Tool discipline" section: "Before shipping a CRITICAL or HIGH alerts.md entry framed around a deadline, verify the deadline against an inventory audit of affected code. Alerts framed around deadlines that don't bite scope inflate urgency."
8. **File-output channel for long CC prompts.** Add to "Code and build" section: "Any CC prompt longer than approximately 5K characters should be written to /mnt/user-data/outputs/ and the file path provided to Logan, not pasted directly into chat. Chat paste has lost prompt content silently in past sessions; file output bypasses the truncation path."

All candidates pending Mastery Lab review. Chat A or B can absorb the userPreferences edit if scoped early.

---

## Files changed this handoff commit

- canonical/handoff-active-mastery.md (overwritten — this file)
- canonical/handoff-active.md (replaced with drift-notice placeholder)
- canonical/handoff-index.md (Mastery row date bump to 2026-04-26 PM; handoff-active.md row updated to reflect drift state)
- archive/handoffs/2026-04-25-MASTERY-PM-misrouted.md (new — archive of misrouted prior handoff content)
- archive/handoffs/2026-04-26-MASTERY-DR-sweep-kickoff.md (new — archive of THIS handoff for retention)
- audits/sonnet-audit-2026-04-26.md (new — committed previously untracked audit report)

---

## Files NOT changed this chat

- canonical/active-findings.md
- canonical/open-decisions.md
- canonical/prompting-rules.md
- canonical/antipatterns.md
- canonical/claude-state.md
- canonical/claude-code-state.md
- canonical/toolchain.md
- canonical/briefing-today.md
- alerts.md (root) — changed earlier this chat in commits e155e25 and 3a0b336
- All proposals/*.md
- All learnings/*.md
- mastery-lab/* — flagged for stale-file audit in Chat A

---

## Immediate next actions for Chat A

1. Read this handoff (auto via SessionStart hook).
2. Read canonical/active-findings.md for queued items (canonical batch source).
3. Read canonical/open-decisions.md for proposal triage state.
4. Resolve handoff routing convention (Pending #1) — small early decision that unblocks the rest.
5. Logan kicks off `claude update` on Mac Studio + Windows PC in side terminals (parallel, no chat impact).
6. Canonical batch — one CC prompt per item, diff-before-commit gate each.
7. budget_tokens grep.
8. memory_user_edits for ASF Documents/GitHub partial-migration drift.
9. Stale-file cleanup audit per "Stale files to remove or replace" list.
10. End-of-chat handoff regen for Chat B.

---

## END OF HANDOFF
