# In-Game Sliders Checklist — Arc Raiders

**Source:** `ArcRaiders_Decided_Settings.md` Domain 2 (Audio + Controller + FOV blocks)
**Applies to:** Arc Raiders in-game Settings menu
**Time:** ~3 min

---

## SCOPE — important

**Graphics sliders are NOT in this checklist.** Those are deployed automatically by `Deploy-ArcRaidersConfig.ps1` which sets the config file read-only. In the Graphics menu you'll see sliders that appear editable but values won't persist — **ignore the Graphics tab entirely**.

This checklist covers only what the ini deploy cannot control:
- Audio volume mix
- Controller sensitivity / aim assist / deadzones
- FOV
- HUD / subtitles / accessibility

---

## Audio — Volume Mix

Menu path: `Settings > Audio`

| Setting | Value | Domain |
|---|---|---|
| Master Volume | **70** | Domain 2 |
| Music Volume | **10** | Domain 2 |
| SFX Volume | **100** | Domain 2 |
| Voice / Dialogue Volume | **60** | Domain 2 |
| Voice Chat Volume | **80** | Domain 2 |
| UI / Interface Volume | **50** | Domain 2 |
| Footsteps Emphasis (if present) | **Max** | Domain 2 |

**Why this mix:** footsteps, weapon fire, and reloads live in SFX. Music masks footsteps — kill it. Dialogue middle-weighted so you hear voice lines without drowning out steps. Voice chat slightly above SFX so teammates cut through combat audio.

---

## Audio — Output

Menu path: `Settings > Audio > Output`

| Setting | Value | Domain |
|---|---|---|
| Audio Output Device | **SteelSeries Sonar - Game** | Domain 2 |
| Audio Channel | **Stereo** (NOT Surround — Sonar handles virtual surround if enabled) | Domain 2 |
| Dynamic Range | **Night Mode** (compressed — makes quiet sounds louder) | Domain 2 |

---

## Controller — Input

Menu path: `Settings > Controller` or `Settings > Input > Controller`

| Setting | Value | Domain |
|---|---|---|
| Input Device | **Controller** (auto-detect Envision Pro) | Domain 7 |
| Stick Layout | **Default** | Domain 7 |
| Invert Look Y | Off (user preference) | Domain 7 |

---

## Controller — Sensitivity

| Setting | Value | Domain |
|---|---|---|
| Horizontal Look Sensitivity | **Per decided doc** (start ~5.0, tune in training range) | Domain 2 |
| Vertical Look Sensitivity | **Per decided doc** (typically 0.75× horizontal) | Domain 2 |
| ADS Sensitivity Multiplier | **1.0** (keep ADS and hip at same feel) | Domain 2 |
| Scope Sensitivity Multiplier | **0.80** (slightly slower for sniper/scoped) | Domain 2 |

**Tune in a training range before ranked.** Decided doc gives the starting point; dial it in over 2–3 matches.

---

## Controller — Deadzones (CRITICAL)

Deadzones happen IN-GAME ONLY per `ArcRaiders_Decided_Settings.md` Domain 7. iCUE is set to 0%/0% so these in-game values are the only deadzone processing.

| Setting | Value | Domain |
|---|---|---|
| Left Stick Deadzone | **~8–10%** (minimum that eliminates drift on your sticks) | Domain 7 |
| Right Stick Deadzone | **~8–10%** | Domain 7 |
| Left Stick Outer Deadzone | **~5%** (or 0% if game allows) | Domain 7 |
| Right Stick Outer Deadzone | **~5%** | Domain 7 |
| Left Stick Response Curve | **Linear** | Domain 7 |
| Right Stick Response Curve | **Linear** | Domain 7 |

**If sticks don't drift (Envision Pro Hall Effect should not drift):** set inner deadzone as low as 3–5%. Lower deadzone = more precision on small movements.

---

## Controller — Aim Assist

| Setting | Value | Domain |
|---|---|---|
| Aim Assist | **On** | Domain 2 |
| Aim Assist Strength | **Default / 100%** | Domain 2 |
| Target Sticky-ness (if present) | **Default** | Domain 2 |

---

## FOV

Menu path: `Settings > Video > FOV` (or `Gameplay > FOV` depending on UI layout — not a graphics quality slider so the ini doesn't control it)

| Setting | Value | Domain |
|---|---|---|
| FOV | **Max available** (typically 110–120) | Domain 2 |
| ADS FOV Scaling | **Affected** (scope zoom feels natural) | Domain 2 |

**Max FOV = max peripheral vision = more enemies seen at screen edges.** Non-negotiable for competitive.

---

## HUD / Accessibility

Menu path: `Settings > Interface` or `Settings > Accessibility`

| Setting | Value | Domain |
|---|---|---|
| Subtitles | **On** (catches enemy voice lines, reload callouts) | Domain 2 |
| Subtitle Size | **Medium** | Domain 2 |
| HUD Opacity | **Default** (100%) | Domain 2 |
| Crosshair Style | Per decided doc (typically dot or small cross) | Domain 2 |
| Damage Numbers | **On** | Domain 2 |
| Colorblind Mode | Per user need | Domain 2 |
| Motion Blur (in-game toggle, if separate from graphics) | **Off** | Domain 2 |
| Camera Shake | **Off / Reduced** | Domain 2 |
| Field Ops Camera Motion | **Reduced** (if exposed) | Domain 2 |

---

## Gameplay

Menu path: `Settings > Gameplay`

| Setting | Value | Domain |
|---|---|---|
| Hold vs Toggle — Aim Down Sights | **Hold** | Domain 2 |
| Hold vs Toggle — Crouch | **Hold** | Domain 2 |
| Hold vs Toggle — Sprint | **Toggle** (reduces thumb fatigue during traversal) | Domain 2 |
| Auto-Sprint | **On** (if available) | Domain 2 |

---

## Verify

1. Exit to main menu, re-enter Settings — all values persist.
2. Enter a match/training area. Test: gunfire SFX audible, music barely present, footsteps clearly directional (left/right/behind).
3. Strafe test: small stick deflections register (low deadzone working). No drift when stick is centered.
4. ADS up — sensitivity feels natural (ADS multiplier 1.0 working).
5. Peripheral vision feels wide (FOV at max).

---

## Graphics tab reminder

**If you open the Graphics settings tab:** values will show what was deployed to the ini. Sliders will appear movable. **Any changes you make will NOT persist** — the ini is read-only. This is working as intended. Move on.

If you need to change a graphics value:
1. Exit the game.
2. Edit `Deploy-ArcRaidersConfig.ps1` `$ScalabilityGroups` or `$SystemSettings` hashtable.
3. Re-run the script.

---

## Notes

- **If Arc Raiders adds new settings in a patch**, verify the graphics ones haven't been reverted by checking read-only attr on `GameUserSettings.ini`. Audio/controller settings persist normally in separate config sections.
- **Sonar Game/Chat/Aux/Mic mix** is NOT configured here — that's in Sonar itself, deferred per decided doc Domain 5.
- **Aim assist values** can be 0–100 on the slider depending on UI — "Default / 100%" means the value decided doc recommends, which is the stock full strength.
