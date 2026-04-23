# Handoff — 2026-04-22 (Mastery Lab → next Mastery Lab chat, Day-7 verdict)

**Recommended next-chat title:** `2026-04-29 — MASTERY — Superpowers Trial Day-7 Verdict`

---

## Current focus

`obra/superpowers` plugin trial running in Claudious repo only. Day-0 install clean. Observation period through 2026-04-29. Day-7 verdict chat decides EXTEND (install in ASF Graphics + Courtside Pro), SELECTIVE (keep specific superpowers skills, disable others), or ROLLBACK (uninstall entirely).

Pending downstream of verdict: build `supabase-schema-evolution` and `claudious-curator` custom skills using superpowers' `writing-skills` TDD-for-skills methodology (Jesse Vincent's approach: pressure-test scenarios for subagent → watch agent fail without skill → write skill → verify agent complies → refactor).

Original session goal: answer "what skills should we build and how do we ensure they're the best." Resolved as install-superpowers-first to get systematic-debugging, TDD, writing-plans, writing-skills, verification-before-completion, and ~15 others as one plugin install rather than building from scratch. Custom builds reserved for stack-specific gaps (Supabase migrations) and Logan-specific systems (Claudious curation).

## Completed today

- Mastery Lab review of Anthropic "Building Effective Agents" guide. Verdict: 90% redundant for Logan's existing canonical state; tool-design rigor + "think like your agent" heuristic worth extracting.
- Grok competitive intel dispatch on what high-signal Claude users are building inside Skills directories. 16 candidates surfaced. Triage produced INSTALL-via-superpowers for 6, BUILD-custom for 2-3 narrow skills, DEFER/SKIP for 8.
- Superpowers Day-0 install complete in Claudious repo. PR #14, merge SHA `bf34631eb01be57d79ae18d6544013456811fe86`. Trial log committed at `archive/proposals/superpowers-trial-log.md`.
- Five rollback criteria (R1–R5) all passed at install time.
- New skill count: 27 → 43 (+16). No cap truncation observed at 43 skills.

## In-flight (observation period 2026-04-23 through 2026-04-29)

Logan fills in `archive/proposals/superpowers-trial-log.md` Day 1–7 sections at end of each day. Template fields per day: skills fired, helpful, noisy/false-fire, friction with existing Claudious work.

Specific things to watch (per Mastery Lab chat 2026-04-22):
- Does `superpowers:test-driven-development` fire on brownfield code work or only greenfield?
- Does `superpowers:systematic-debugging` save time on a real bug, or is it ceremony tax?
- Does `superpowers:writing-skills` change how Logan would build the planned custom skills?
- Any false-trigger pattern across the 16 new superpowers skills?
- Any namespacing collision (`/superpowers:write-plan` vs anything Logan already invoked as `/write-plan` muscle-memory).

## Pending decisions (must resolve at or before Day-7 chat)

1. **`.claude/settings.json` commit decision.** Currently uncommitted in Claudious — left untracked per Day-0 task constraint (literal read of "do not modify files outside trial log"). Mac will not auto-pick-up the plugin enablement on `git pull` until this is committed. Mastery Lab recommendation: leave uncommitted through Day 7, commit if verdict is EXTEND. If Logan wants Mac in trial early, re-run `claude plugin install superpowers@claude-plugins-official --scope=project` on Mac manually instead.

2. **Path discrepancy: Documents/GitHub/Claudious vs Projects/Claudious.** userMemories (recent_updates) says `C:\Users\logan\Documents\GitHub\` is canonical for all repos on Windows and `Projects/` is DEPRECATED. Day-0 CC trial found Projects/Claudious as the live path matching CLAUDE.md's rollback path. Either userMemories is stale specifically for Claudious, or the Windows migration never completed for Claudious. Mac canonical at `~/Documents/GitHub/Claudious` is correct and verified. Needs separate session to resolve Windows side — should not consume Day-7 verdict chat capacity. Out-of-scope for Day-7.

3. **Port 4 Desktop-only skills to CLI scope?** `logan-os`, `operating-system`, `financial-modeler`, `legal-scanner` live in Claude Desktop AppData and are NOT visible to Claude Code CLI. They never fire during build work — exactly when execution context is most needed. Discovered during Day-0 baseline (R1 scope had to be reduced from 8 canonical skills to 4 CLI-visible: `harvest`, `health-optimizer`, `macro-intelligence`, `negotiation-playbook`). Decision: post-trial. Mention at Day-7 verdict chat to not lose track.

## Day-7 verdict prompt (generate at start of next chat)

Day-7 verdict CC prompt was deliberately not pre-generated this session — it should reference actual Day 1–7 observation data, not speculate. Logan will paste the filled-in `archive/proposals/superpowers-trial-log.md` into the Day-7 chat; Mastery Lab generates the verdict CC prompt then.

Verdict options to evaluate:
- **EXTEND:** install superpowers in ASF Graphics and Courtside Pro repos. Commit `.claude/settings.json` to all three repos. Build `supabase-schema-evolution` + `claudious-curator` using `writing-skills` methodology.
- **SELECTIVE:** keep specific superpowers skills (likely candidates: `systematic-debugging`, `test-driven-development`, `writing-skills`), disable the rest via plugin config. Build the custom skills.
- **ROLLBACK:** uninstall superpowers entirely. Extract patterns from public superpowers SKILL.md files into Logan's existing 8 custom skills (folds into the pending 1,536-char audit). Build `supabase-schema-evolution` + `claudious-curator` from scratch.

## Decisions made with reasoning

- **Install superpowers vs. build from scratch:** install. Pre-built, maintained, multi-platform, in Anthropic's official marketplace. Building 6+ skills from scratch when a maintained plugin exists is wasted slot economy.
- **Scope to Claudious only for Day 0:** correct. Cap concern (later proven wrong) and methodology-clash concern (still unverified) both warranted limited blast radius.
- **Generate handoff at 70% rather than push to 75%:** Day-7 is a week out; chat would close anyway. Better to capture state at peak clarity than under threshold pressure.
- **No template addition to trial log for Day 1–7:** namespacing came in clean (R3 passed). Adding a field for a problem that didn't materialize is over-engineering. Existing "noisy/false-fire" and "friction" categories absorb any namespacing collision that emerges.

## Files recently changed

- `archive/proposals/superpowers-trial-log.md` — Day-0 baseline + install output + post-install state. PR #14, merged at `bf34631`.
- `.claude/settings.json` (uncommitted, Windows only) — superpowers project-scope enablement marker. Decision pending per Pending Decisions #1.
- `canonical/handoff-active.md` — this file. Replaces prior handoff `archive/handoffs/2026-04-22-MASTERY-superpowers-trial-day-0.md`.

## Frustration signals (do not repeat in next chat)

- **Citing constraint numbers from canonical without re-verification.** Mastery Lab cited "~34-36 skill cap" from older canonical state and built recommendation around it. Reality at install: 43 skills, no truncation. Update: re-verify cap-style numbers via current state, not memory, before letting them gate decisions. This is a Mastery-Lab-specific failure mode worth flagging.
- **Conflating Claude Desktop AppData skills with Claude Code CLI-visible skills.** Mastery Lab assumed all 8 of Logan's custom skills were CLI-visible. Only 4 are. The other 4 don't fire during build work. Implication: any Mastery Lab recommendation involving Claude Code workflows must distinguish between Desktop-resident and CLI-resident skills before claiming coverage.

## User Preferences changes pending

None from this session.

Candidate for future consideration (not yet proposed):

- Add explicit Mastery Lab rule: when citing skill cap, version, model spec, or any other Anthropic-state number in a recommendation, web_fetch or canonical-fetch the current value rather than relying on training data or stale canonical entries. Implicit in existing rules but the superpowers trial showed Mastery Lab still defaults to memory.

## Immediate next actions for new chat

1. Read this handoff BEFORE responding to anything else.
2. Acknowledge Day-7 status (paste of trial log expected).
3. Generate Day-7 verdict CC prompt referencing actual Day 1–7 data.
4. Surface the three pending decisions (settings.json commit, path discrepancy, Desktop-only skill port) before Logan moves on.
5. If verdict is EXTEND or SELECTIVE: scope the next-step CC prompt for `supabase-schema-evolution` build using `writing-skills` methodology. If ROLLBACK: scope the CC prompt for the pattern-extract-and-fold-into-existing-skills path instead.

## END OF HANDOFF
