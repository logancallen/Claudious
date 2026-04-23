# Brief — README (master doc)

**Output file:** `README.md`
**Source domain:** Ties together all previous walkthroughs + Domain 8 (Implementation Order at lines 626-641 of decided doc) + verify-on-boot checks (lines 30-42).

## Context

This is the master guide Logan reads first. Orients him, lists what's in each walkthrough, gives implementation order, and covers troubleshooting + revert.

Should be compact. Logan doesn't need another essay — he needs a table of contents + a decision tree.

## Required sections, in order

1. **What this is + quick status**
   One paragraph.
   Pre-completed: Domain 3 (Windows system tweaks via PowerShell trio — DONE, verified).
   Walkthroughs in this package: Domain 1 (Adrenalin), Domain 2 (In-Game), Domain 5 (Sonar), Domain 6 (OSD), Domain 7 (iCUE).
   Deferred: Domain 4 (BIOS — separate session, not in this package).

2. **Implementation order**
   Numbered list, follow strictly. Each item: which file + one-line purpose.

   Per decided doc Domain 8 "Implementation Order" — order adjusted because BIOS is deferred:

   1. **Adrenalin** (`Adrenalin_Walkthrough.md`) — Driver + per-game profile. Clean install 26.3.1, create Arc Raiders profile, enable FSR 4 Upgrade.
   2. **LG Monitor OSD** (`OSD_Walkthrough.md`) — Picture mode Gamer 1, Black Stabilizer 70, DAS on, DP 1.4 + DSC.
   3. **Sonar** (`Sonar_Walkthrough.md`) — Routing first, then EQ, then spatial off / Night Mode off.
   4. **iCUE** (`iCUE_Walkthrough.md`) — Linear curves, 0%/100% deadzones, paddle bindings, save to slot 1.
   5. **Arc Raiders in-game** (`InGame_Walkthrough.md`) — Graphics, display, audio routing, controller block.
   6. **Verify on first boot** — the three checks: FSR 4.1 active, CCD1 parked, SoC ≤ 1.15V (SoC check is BIOS-dependent, flag as TBD until BIOS session).
   7. **First raid** — no expectations. Two raids: tune FOV/sensitivity. Five raids: lock settings.
   8. **DEFERRED** — BIOS walkthrough (next session): VBS disable (recovers 5-14% FPS), EXPO, PBO2 Curve Optimizer -10, Re-Size BAR.

3. **Files in this package**
   Simple table:

   | File | Purpose | Time to apply |
   |------|---------|---------------|
   | `Adrenalin_Walkthrough.md` | AMD driver + Arc Raiders per-game profile | 15-20 min (incl. Factory Reset install) |
   | `OSD_Walkthrough.md` | LG monitor joystick navigation | 10 min |
   | `Sonar_Walkthrough.md` | SteelSeries GG routing + 10-band EQ | 20-30 min (EQ entry is slow) |
   | `iCUE_Walkthrough.md` | Scuf Envision Pro via Corsair iCUE | 15-20 min |
   | `InGame_Walkthrough.md` | Arc Raiders in-game settings | 10-15 min |
   | `README.md` | This file | — |

4. **Verify-on-boot checklist** (from top of decided doc)
   Three manual checks Logan runs after everything is applied. Presented as actionable steps:

   - **FSR Upscaling 4.1 active**: Alt+R in-game → Performance → Overlay. Confirms driver's FSR 4.1 upgrade actually applied.
   - **CCD1 parked during gameplay**: Open Ryzen Master during a live raid. Home tab. Cores 8-15 (logical 16-31) should show sleep/low activity. Confirms 3D V-Cache CCD parking working.
   - **SoC voltage ≤ 1.15V under EXPO load**: HWiNFO sensors during a raid. Watch VDDCR_SoC. BIOS-dependent check; not applicable until BIOS session complete.
   - **Bonus**: `msinfo32` → System Summary → "Virtualization-based security" should read "Not enabled". Also BIOS-dependent (SVM off).

5. **Troubleshooting flowchart**
   If/then decisions for common regressions:

   - **FPS below 120 sustained** → Is FSR 4.1 active in the overlay? If no, check Adrenalin → Arc Raiders profile → FSR 4 Upgrade = On. If yes, check Ryzen Master → CCD1 parked? If not parked, Win+G in-game and confirm "Remember this is a game". If still not, Xbox Live Auth Manager service is required (already Manual-start; will start on-demand).
   - **Footsteps hard to hear** → Arc Raiders in-game Output Device = Sonar Virtual Playback (Game)? If outputting directly to Arctis, Sonar EQ does nothing. Also verify Sonar Spatial Audio is OFF.
   - **Controller feels "dead" in the middle** → Deadzone double-processing. iCUE should have 0%/100%; in-game owns the deadzones.
   - **Controller feels "jittery" or overcorrects** → Curves mismatched. iCUE = Linear, in-game Look Response Curve = Linear. Exponential anywhere stacks badly with aim assist.
   - **Visible motion smearing** → LG OSD Response Time on "Faster" instead of "Fast" — Faster causes inverse-ghosting on this panel.
   - **Windows gaming services stopped WARN from Verify script** → Normal, these are Manual-start and wake on Win+G. Not a problem.

6. **Revert procedure** (if anything regresses baseline)
   Per-domain revert order — each layer is independently reversible:

   - **Windows tweaks**: Run `Revert-ArcRaiders.ps1` — reads backup JSON, restores every value. Reboot.
   - **Adrenalin**: Factory Reset via Adrenalin installer, or delete the Arc Raiders per-game profile.
   - **OSD**: Picture Mode → Standard/Custom; reset Game Adjust options to default.
   - **Sonar**: Delete the `ArcRaiders_Footsteps` preset; Game channel returns to default.
   - **iCUE**: Import the original Slot-1 preset or delete `ArcRaiders_Linear` profile.
   - **In-game**: Arc Raiders Settings → Reset all sections to default.

   Note on DoSvc: the PowerShell Revert script uses `Set-Service` which was ACL-blocked on Logan's 25H2 for DoSvc. If full revert is needed, manually edit `HKLM:\SYSTEM\CurrentControlSet\Services\DoSvc\Start` back to 2 (Automatic).

7. **What's missing + next session**
   - **BIOS walkthrough** (Domain 4): deferred for a scheduled session. Covers VBS disable via SVM off (recovers 5-14% FPS), EXPO Profile 1, FCLK 2000 / UCLK 3000 1:1, SoC voltage manual 1.10V cap, PBO2 + Curve Optimizer -10, Re-Size BAR on, CPPC + Global C-States + SMT on.
   - **Post-config performance validation**: run 5 raids and confirm sustained 120+ FPS at 3440×1440 FSR Quality. Decided-doc target is 120-150.
   - **Practice Range Sonar tune**: 10 minutes of A/B testing Night Mode ON vs OFF for Logan's specific hearing (decided doc flags this as a toss-up).

## Tone

Brief. Logan doesn't re-read READMEs. Sections scannable. Tables where possible. Troubleshooting as if/then, not paragraphs.

## Length target

150-250 lines.
