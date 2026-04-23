# Arc Raiders PC Optimization — Morning Deploy Kit

**Target:** Logan's rig — Ryzen 9 9950X3D / RX 9070 XT / 64GB DDR5-6000 / LG UltraGear 3440×1440 240Hz OLED / Scuf Envision Pro
**Source of truth:** `ArcRaiders_Decided_Settings.md` (project knowledge, 7 domains)
**Drop this folder at:** `C:\Users\logan\Projects\Claudious\projects\pc-optimization\arcraiders\`

---

## Status snapshot

| Domain | What | Status |
|---|---|---|
| 1 | Adrenalin driver + per-game profile | Checklist ready → `Adrenalin_Checklist.md` |
| 2 | Arc Raiders graphics (sg.* + r.* CVars) | **Automated** → `Deploy-ArcRaidersConfig.ps1` |
| 2 | Arc Raiders audio + controller + FOV sliders | Checklist ready → `InGame_Sliders_Checklist.md` |
| 3 | Windows system tweaks | **DONE** (Batch A deployed, verify: OK 26 / WARN 3 / FAIL 1) |
| 4 | BIOS (VBS off via SVM, EXPO, PBO2 −10 CO, SoC 1.10V, ReBAR) | **Deferred** — separate morning session |
| 5 | Sonar EQ | **Deferred** — do manually per Domain 5 table when ready (~3 min) |
| 6 | LG UltraGear OSD | Checklist ready → `OSD_Checklist.md` |
| 7 | Scuf Envision Pro via iCUE | Checklist ready → `iCUE_Checklist.md` |

---

## Implementation order (morning)

Run in this exact order. Each step takes 2–5 min.

1. **Deploy graphics ini** — from PowerShell (non-admin fine):
   ```powershell
   cd C:\Users\logan\Projects\Claudious\projects\pc-optimization\arcraiders
   .\Deploy-ArcRaidersConfig.ps1 -WhatIf     # preview first
   .\Deploy-ArcRaidersConfig.ps1             # actual write
   ```
   Backs up existing ini to `.bak-YYYYMMDD-HHMMSS`, writes `[ScalabilityGroups]` + `[SystemSettings]`, sets read-only.

2. **Adrenalin driver config** — follow `Adrenalin_Checklist.md`. ~5 min.

3. **LG UltraGear OSD** — joystick under the monitor bezel. Follow `OSD_Checklist.md`. ~3 min.

4. **iCUE controller profile** — follow `iCUE_Checklist.md`. Save to onboard Slot 1 + export `.cueprofile` backup. ~5 min.

5. **Launch Arc Raiders.** Let it load to main menu.

6. **In-game sliders** — follow `InGame_Sliders_Checklist.md` for audio + controller + FOV + HUD. Graphics sliders will look editable but the ini is read-only so values won't persist — ignore the graphics tab. ~3 min.

7. **Play.**

8. **Sonar EQ** — deferred. Do manually per decided doc Domain 5 whenever you feel like it. Not blocking.

9. **BIOS** — deferred to separate morning session (Domain 4).

---

## Per-script notes

### `Deploy-ArcRaidersConfig.ps1`

- Target path: `%LOCALAPPDATA%\PioneerGame\Saved\Config\WindowsClient\GameUserSettings.ini` (Pioneer = Embark's internal project name for Arc Raiders)
- Encodes all Domain 2 graphics values. All settings trace back to `ArcRaiders_Decided_Settings.md` Domain 2 Graphics Quality table.
- Preserves other sections (keybinds, resolution, window mode) via regex replace-or-append.
- Backs up first. Sets read-only after write so in-game slider changes can't overwrite.
- Flags: `-WhatIf` (preview, no writes), `-Revert` (clear read-only + restore most recent `.bak`).
- **Must run AFTER Arc Raiders has launched at least once** so the `PioneerGame\Saved\Config\WindowsClient\` directory exists. If it doesn't exist, the script creates it and proceeds — the values will apply on first launch.

### Batch A scripts (already deployed, reference only)

- `Optimize-ArcRaiders.ps1` (569 lines) — 25 Windows tweaks applied.
- `Revert-ArcRaiders.ps1` (364 lines) — restores all Batch A changes.
- `Verify-ArcRaiders.ps1` (309 lines) — current-state audit.
- Backups/logs live at `C:\Users\logan\Documents\ArcRaiders-Configs\`.

---

## Revert procedure

If anything goes sideways, unwind in reverse order:

| Layer | Command | What it does |
|---|---|---|
| Graphics ini | `.\Deploy-ArcRaidersConfig.ps1 -Revert` | Clears read-only, restores most recent `.bak-*` file. |
| iCUE profile | iCUE → Profile menu → switch to Default or re-import prior `.cueprofile` | Reverts controller binds. |
| LG OSD | OSD → Reset → All Reset | Factory-resets monitor settings. |
| Adrenalin profile | Adrenalin → Gaming → Arc Raiders → delete profile | Game falls back to Global defaults. |
| Windows tweaks | `.\Revert-ArcRaiders.ps1` (in Batch A folder) | Undoes all Domain 3 changes. |

Full system nuke: run Batch A `Revert-ArcRaiders.ps1` + graphics ini `-Revert`. Takes <2 min.

---

## Troubleshooting flowchart

**Arc Raiders won't launch after ini deploy**
→ `.\Deploy-ArcRaidersConfig.ps1 -Revert`. Launch game. If it launches, one of the CVars is misbehaving — comment out the most recent additions in `$SystemSettings` hashtable and redeploy one at a time.

**Graphics look wrong / settings don't match decided doc**
→ Open `%LOCALAPPDATA%\PioneerGame\Saved\Config\WindowsClient\GameUserSettings.ini`. Confirm `[ScalabilityGroups]` + `[SystemSettings]` blocks present with deployed values. If missing, re-run deploy. If present but not applied, check the file's read-only attribute — if cleared, Arc Raiders overwrote it, redeploy.

**Stutter / frame pacing worse than stock**
→ Driver issue, not ini. Check Adrenalin: Anti-Lag OFF, AFMF OFF, HYPR-RX OFF, Radeon Boost OFF (`Adrenalin_Checklist.md` Global Settings). If still bad, toggle FSR 4 Upgrade off in per-game profile — might be a driver-level incompat with current FSR 4 build.

**Input feels laggy / ADS sluggish**
→ Double-deadzone problem. Confirm iCUE deadzones are 0% / 0% (`iCUE_Checklist.md`) — deadzones happen IN-GAME ONLY per decided doc Domain 7 explicit rule.

**Controller paddles not firing**
→ iCUE: profile loaded to onboard Slot 1? Slot LED indicator matches? Physical trigger toggle on Instant Trigger mode?

**Monitor ghosting on fast pans**
→ OSD Response Time = **Fast** only. NOT Faster (`OSD_Checklist.md` — Faster causes inverse-ghosting on this panel).

**VBS still enabled after reboot (Domain 3 FAIL 1)**
→ Expected. VBS requires disabling SVM in BIOS. Deferred to morning BIOS session.

---

## Outstanding items

- **Sonar EQ** — deferred. Do manually per `ArcRaiders_Decided_Settings.md` Domain 5 when ready. ~3 min.
- **BIOS Domain 4** — deferred to separate morning session. Covers: SVM off (kills VBS), EXPO enable, SoC voltage 1.10V cap, PBO2 −10 CO, Re-Size BAR.
- **Decided-doc correction** — Domain 7 says "Scuf G-App"; actual software is iCUE. iCUE_Checklist.md flags this at the top.

---

## File inventory (this folder)

```
README.md                          <-- you are here
Deploy-ArcRaidersConfig.ps1        <-- automated graphics ini deploy
Adrenalin_Checklist.md             <-- Domain 1 driver settings
OSD_Checklist.md                   <-- Domain 6 monitor settings
iCUE_Checklist.md                  <-- Domain 7 controller settings
InGame_Sliders_Checklist.md        <-- Domain 2 audio/controller/FOV (graphics auto-deployed)
```
