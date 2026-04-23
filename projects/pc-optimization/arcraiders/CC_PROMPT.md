# Claude Code Prompt — Arc Raiders Walkthroughs Generation

**Paste this entire file as the first message to Claude Code.**
**Prerequisites:** All 6 brief files + `ArcRaiders_Decided_Settings.md` must be accessible to CC at the paths listed below.

---

You are generating 6 markdown files that document how to apply Arc Raiders optimization settings to specific applications. This is Batch B + Batch C of a larger project — Batch A (Windows system tweaks via PowerShell) is already complete and deployed.

## Your inputs

**Source of truth (read-only, DO NOT modify):**
- `ArcRaiders_Decided_Settings.md` — the locked decided-settings document. Every setting in every output must trace back to a specific line in this file. No freelancing, no additions.

**Task briefs (one per output file, read each before generating the corresponding output):**
- `briefs/01_Adrenalin_Brief.md` → generates `Adrenalin_Walkthrough.md`
- `briefs/02_InGame_Brief.md` → generates `InGame_Walkthrough.md`
- `briefs/03_Sonar_Brief.md` → generates `Sonar_Walkthrough.md`
- `briefs/04_OSD_Brief.md` → generates `OSD_Walkthrough.md`
- `briefs/05_iCUE_Brief.md` → generates `iCUE_Walkthrough.md`
- `briefs/06_README_Brief.md` → generates `README.md`

## Your outputs

Six markdown files in the working directory (or subdirectory `walkthroughs/` — match the convention of the host project):

1. `Adrenalin_Walkthrough.md`
2. `OSD_Walkthrough.md`
3. `Sonar_Walkthrough.md`
4. `iCUE_Walkthrough.md`
5. `InGame_Walkthrough.md`
6. `README.md`

## Workflow

Generate files in this order. After each file, do a self-check pass (below) before moving to the next.

1. Read `ArcRaiders_Decided_Settings.md` in full. Hold it in mind as reference.
2. For each output in the order listed above:
   - Read the corresponding brief.
   - Generate the output markdown following the brief's "Required sections" exactly.
   - Every setting must cite its decided-doc source (format specified in each brief).
   - Self-check pass (see below).
   - Move to the next file.
3. When all 6 are done, do a final cross-file review: are there inconsistencies between walkthroughs that reference the same setting? Fix any found.

## Self-check pass (run after each file)

Before moving to the next file, verify:

- **Traceability**: Every setting / value in the output has a parenthetical citation pointing to its domain + table in `ArcRaiders_Decided_Settings.md`. If you can't cite it, it doesn't belong.
- **No placeholders**: Zero `{{VARIABLE}}`, zero `[FILL IN]`, zero "replace this with your value" strings. If uncertain about a specific menu label or path, write `(verify exact label in your app version)` as a standalone note rather than using a placeholder.
- **No forbidden additions**: Check the brief's "Do NOT include" section. Nothing from that list should appear in the output.
- **No freelancing**: If a setting is not in the decided doc and not in the brief, it should not be in the output. "While we're at it" additions are explicitly forbidden.
- **Controller-primary**: All walkthroughs assume Scuf Envision Pro controller. Strip any mouse DPI, raw input, or M+KB-specific instructions.
- **Consistency with other outputs**: If the file cross-references another walkthrough (e.g., Sonar walkthrough references "Output Device = Sonar Virtual Playback (Game)" set in Arc Raiders in-game audio), the cross-reference must match what the other walkthrough actually says.

## Hard rules (violations are immediate stop-and-fix)

1. **Decided doc is read-only.** Never edit it, never regenerate it. Only reference.
2. **No placeholders anywhere.** If you don't know a specific UI label, either (a) look it up if you have web access, or (b) write a clear "(verify in your UI)" note. Never a `{{}}`.
3. **One file at a time.** Do not batch-generate all six in one shot. Complete one, self-check, move on.
4. **BIOS is explicitly deferred.** Do not generate a BIOS walkthrough even if Domain 4 of the decided doc would support one. The user will request it in a separate session.
5. **"Scuf G-App" terminology in the decided doc is incorrect.** The Envision Pro uses Corsair iCUE. Use "iCUE" in the iCUE walkthrough; when citing the decided doc, use the format: `(Domain 7, Scuf G-App → iCUE in this doc)`.
6. **No persuasive / salesy language.** Direct, decisive, technical. Logan's preferences require execution-first tone.

## Format conventions

- Markdown tables for settings blocks (recurring pattern across all walkthroughs)
- Fenced code blocks for CLI / paths / filenames
- Bold for critical values (**OFF**, **Linear**, **Quality**, etc.)
- `Setting = Value` inline format
- Headers: `#` for file title, `##` for top-level sections, `###` for subsections
- One blank line between sections

## Length guidance

Per-file length targets are in each brief. Total package is 1200-1700 lines of markdown. Don't pad; don't skimp. Match the target, deliver the content cleanly.

## Success criteria (what "done" looks like)

- All 6 files present in the working directory
- Every setting cites its decided-doc source
- No placeholders, no forbidden additions, no freelancing
- README.md cross-links to the 5 walkthroughs by filename
- A reader who has never seen the decided doc could, by reading only the walkthroughs, apply every setting correctly

Begin. Generate `Adrenalin_Walkthrough.md` first.
