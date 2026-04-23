# Brief — In-Game Walkthrough (Domain 2)

**Output file:** `InGame_Walkthrough.md`
**Source domain:** ArcRaiders_Decided_Settings.md Domain 2 (lines 100-178 of the decided doc)
**Target user:** Logan. Controller-primary (Scuf Envision Pro). 3440×1440 240Hz OLED.

## Context

Phase 0 research confirmed `GameUserSettings.ini` editing is community-safe for Arc Raiders (Nexus Mods author explicitly says no ban/achievement impact), BUT:
- Arc Raiders uses a PER-ACCOUNT suffix (`GameUserSettings_<ID>.ini`), adding brittleness
- Audio routing, controller sensitivities, aim assist are server-side — only manual in-game entry works
- The .ini path covers only graphics; walkthrough is faster than maintaining a forked ini

Therefore this walkthrough is the deliverable for Domain 2.

## Required sections, in order

1. **Pre-launch checks**
   - Confirm Adrenalin Arc Raiders profile exists (from Adrenalin walkthrough)
   - Confirm monitor is at 3440×1440 @ 240Hz (Windows Settings → System → Display → Advanced Display)
   - Launch Arc Raiders, let it reach main menu

2. **Display section** (Settings → Display, or whatever the in-game menu labels are)
   Every row of Domain 2's Display table. For each:
   - Setting name as it appears in-game
   - Target value
   - One-line reason cross-referencing decided doc

   - Display Mode = Exclusive Fullscreen
   - Resolution = 3440×1440 (native)
   - V-Sync = Off
   - Frame Rate Limit = 138
   - Upscaled Resolution = 100%
   - Resolution Scaling Method = AMD FSR3 (driver upgrades to 4.1)
   - FSR Quality tier = Quality
   - Field of View = 80 (max)

   Include the "Frame cap sanity check" paragraph from Domain 2 — it explains the 138 choice vs 237.

3. **Graphics Quality section**
   Every row of Domain 2's Graphics Quality table. Use a table format since there are ~17 settings.

   Critical settings to highlight (bold in the table, short reasoning after):
   - Global Illumination = **Static** (biggest FPS lever)
   - Post-Processing = **Low** (second-biggest FPS lever)
   - Foliage = **Low** (visibility advantage — see through bushes others think are cover)
   - Shadows = Medium, View Distance = High, AA = Medium, Textures = High
   - Effects = Low, Reflections = Low
   - Motion Blur, Depth of Field, Film Grain, Chromatic Aberration, Vignette, Lens Flares = all Off

4. **Audio (In-Game) section**
   Every row of Domain 2's Audio table. Critical routing detail:
   - Output Device = **Sonar Virtual Playback (Game)** — not Arctis direct
   - Audio Mode = Stereo / Headphones
   - Night Mode = **OFF** (this is the decided-doc position given Sonar EQ will handle footstep boost)
   - Music Volume = 0
   - Proximity Chat Mode = Push-to-Talk
   - Other volume sliders per the table

   Include the Night Mode conditional: "If NOT using Sonar custom EQ, flip Night Mode ON." Since we ARE using custom EQ (Sonar walkthrough), keep it OFF.

5. **Controller (In-Game) section**
   This is where the decided doc's central principle applies: EVERY deadzone and curve lives in-game, NOTHING in iCUE.
   Every row of Domain 2's Controller table:
   - Aim Assist = Enabled
   - Aim Assist Strength = Medium
   - Horizontal Sensitivity = 75
   - Vertical Sensitivity = 60
   - ADS Sensitivity Multiplier = 40%
   - Scoped Sensitivity Multiplier = 50%
   - Look Response Curve = Linear
   - Look Boost / Acceleration = Off
   - Right Stick Inner Deadzone = 5% (bump to 7% if drift)
   - Right Stick Outer Deadzone = Default (~98%)
   - Left Stick Inner Deadzone = 8%
   - Left Stick Outer Deadzone = Default
   - Trigger Inner Deadzone = 3%
   - Vibration / Rumble = **Off** (masks low-end audio cues)
   - Gyro Aim = Off (not supported on Envision Pro)
   - Interact Priority = Prioritize Reload

   After the table: the "Reverse conditions for sensitivity block" paragraph about tuning after 5 raids.

6. **Post-setup verification**
   - Spawn Practice Range
   - Confirm FSR 4.1 active via Alt+R overlay
   - Test aim feel: bot at 25m, left/right tracking
   - Test audio: bot footsteps audible at 15m with Sonar EQ active (Sonar walkthrough section)
   - Confirm Win+G registers Arc Raiders as a game (for CCD parking). If not: decided doc notes "Win+G during a raid → confirm Remember this is a game"

## Traceability rule

Every setting cites its decided-doc source. Format: `(Domain 2, Display)` / `(Domain 2, Graphics Quality)` / `(Domain 2, Audio)` / `(Domain 2, Controller)`.

## Do NOT include

- ❌ Any M+KB-specific settings (DPI, mouse smoothing, raw input). Controller-primary only.
- ❌ Bindings for paddles (those are iCUE walkthrough — in-game uses face buttons, iCUE remaps to paddles)
- ❌ Graphics presets higher than Quality FSR tier
- ❌ HDR enable (decided doc: HDR off)
- ❌ Motion Blur as anything but Off

## Tone

Direct. Tables for every settings block. Prose only for reasoning callouts.

## Length target

250-400 lines.
