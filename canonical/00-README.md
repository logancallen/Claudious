# Canonical — Claudious Current State

**Last updated:** 2026-04-19
**Owner:** Logan Allen (logancallen)
**Scope:** Source-of-truth files attached as project knowledge to all 8 of Logan's Claude Projects.

---

## What Claudious Is

Claudious is the shared nervous system across Logan's 8 Claude Projects (ASF Graphics, Courtside Pro, Genesis Advisory, Claude Mastery Lab, etc.). It captures learnings, tracks platform state, queues improvements, and runs scheduled routines (intake → process → curate) that keep the system current without manual tending.

## What `canonical/` Means

Every file in this directory is:
- **Authoritative** — the current truth, not a log of prior truths.
- **Always fresh** — updated in place by scheduled routines or manual edits. Never append-dated.
- **Claude-Project-loadable** — designed for attachment as project knowledge. Each file is self-contained, RAG-friendly (H2 section headers, key facts front-loaded), and signal-dense (no run-by-run operational noise).

When you load Claudious as project knowledge in a Claude Project, **only attach the `canonical/` directory**. Do not attach the full repo — that dilutes RAG retrieval with operational history.

## What `archive/` Means

Operational history (dated intake files, daily runs ledger, weekly digests, resolved proposals, snapshot backups). Not attached to Claude Projects. Reference only — readable by Claude Code sessions when a historical question arises. Git history is the full audit trail regardless.

## Source-of-Truth Hierarchy

1. **`canonical/`** — authoritative current state.
2. **`learnings/*.md`** — raw capture stream, feeds canonical during curate.
3. **`queue/`, `proposals/`** — pending changes (surfaced in `canonical/open-decisions.md`).
4. **`archive/`** — historical record, not load-bearing.
5. **Git history** — ultimate audit trail; nothing is ever truly deleted.

## File Index

| File | What it holds | Refreshed by |
|---|---|---|
| `claude-state.md` | Current Anthropic models, pricing, API deltas | manual + intake |
| `claude-code-state.md` | CLI version, env vars, features, routines | manual + intake |
| `prompting-rules.md` | Universal graduated techniques | process (graduation) |
| `antipatterns.md` | Known failure modes and token-waste traps | process + deploy calibration |
| `toolchain.md` | Active MCP servers, skills, plugins, research stack | manual |
| `active-findings.md` | Last 7 days of ungraduated intake findings | intake (daily) |
| `open-decisions.md` | Proposals awaiting Logan review | process (daily) |
| `briefing-today.md` | Daily phone-ready briefing | curate (daily) |

## Rules for Editing

- Update in place. Do not append dated deltas to canonical files — that reintroduces operational noise.
- Update the `Last updated` timestamp at the top whenever content changes.
- If adding a section, update the File Index above.
- If you're unsure whether a file belongs here vs `archive/`, ask. When in doubt, keep it out.
