# Handoff Package — What To Do With This

## TL;DR

Extract this package → drop the contents into a Claude Code working directory → open CC → paste `CC_PROMPT.md` as the first message → walk away → come back to 6 finished walkthrough files.

## What's in this package

```
handoff/
├── README_for_Logan.md          ← this file (not read by CC)
├── CC_PROMPT.md                 ← the single message to paste into CC
├── ArcRaiders_Decided_Settings.md   ← source of truth, CC reads this
└── briefs/
    ├── 01_Adrenalin_Brief.md
    ├── 02_InGame_Brief.md
    ├── 03_Sonar_Brief.md
    ├── 04_OSD_Brief.md
    ├── 05_iCUE_Brief.md
    └── 06_README_Brief.md
```

## Step-by-step

**1. Place the package where CC can read it.**

If you're running CC from Claudious:
- Copy the `handoff/` folder contents into: `~/claudious/projects/pc-optimization/arcraiders/`
- Your final layout should have `CC_PROMPT.md`, `ArcRaiders_Decided_Settings.md`, and `briefs/` all at that level

If you're running CC from a different directory, pick any working directory and put all these files (and the `briefs/` subfolder) at the root of it.

**2. Open Claude Code in that directory.**

```
cd ~/claudious/projects/pc-optimization/arcraiders
claude
```

Or wherever you prefer to run CC from.

**3. Paste `CC_PROMPT.md` as your first message.**

Open `CC_PROMPT.md`, copy the entire contents, paste into CC as the first message. Hit send.

**4. Walk away.**

CC will:
1. Read the decided doc
2. Read each brief one at a time
3. Generate each walkthrough file one at a time with self-check passes
4. Do a final cross-file consistency review

Expected runtime: 10-20 minutes depending on CC's pace. You can leave it unattended.

**5. When CC finishes, you'll have 6 new markdown files.**

- `Adrenalin_Walkthrough.md`
- `OSD_Walkthrough.md`
- `Sonar_Walkthrough.md`
- `iCUE_Walkthrough.md`
- `InGame_Walkthrough.md`
- `README.md`

Each file is independently actionable. Open `README.md` first — it tells you the implementation order.

## Spot-check when CC is done

Before acting on the walkthroughs, eyeball these things in each generated file:

- [ ] Every settings table has target values (no `{{TODO}}`, no `[FILL IN]`, no obvious placeholders)
- [ ] Every setting has a parenthetical citation to the decided doc (e.g., `(Domain 1, Per-Game Profile table)`)
- [ ] The iCUE walkthrough uses "iCUE" not "Scuf G-App"
- [ ] README.md links to all 5 walkthrough files by filename

If anything looks wrong: tell CC what's wrong and ask it to fix. CC will iterate.

## Scope reminder

**In scope for this package:**
- Domain 1 (Adrenalin)
- Domain 2 (in-game)
- Domain 5 (Sonar)
- Domain 6 (OSD)
- Domain 7 (iCUE — corrected from "Scuf G-App")

**Explicitly deferred (next session, not in this package):**
- Domain 4 (BIOS)

**Already complete, not in this package:**
- Domain 3 (Windows tweaks — applied via `Optimize-ArcRaiders.ps1`, verified, reversible via `Revert-ArcRaiders.ps1`)

## If something goes sideways

If CC produces output that violates a rule (placeholders, freelancing, wrong scope), the briefs contain "Do NOT include" sections that are explicit. Copy the violation back to CC and cite the brief rule.

If CC gets stuck on a missing piece of info (e.g., "what's the exact Adrenalin menu label in 26.3.1"), it should write `(verify in your UI)` per the rules rather than blocking. If it stops and asks you, give it permission to mark-as-verify and continue.

If CC regenerates the decided doc or deletes it: stop, restore from this package, and flag it to the next Claude chat so the preference gets codified.

## After the walkthroughs are done

Apply in the order specified in `README.md`. Two hours of wall time, most of it in Sonar EQ entry.

Schedule the BIOS walkthrough session for tomorrow morning — fresh eyes, no rush. That session completes the optimization stack.
