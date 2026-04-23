# Brief — LG OSD Walkthrough (Domain 6)

**Output file:** `OSD_Walkthrough.md`
**Source domain:** ArcRaiders_Decided_Settings.md Domain 6 (lines 458-512 of the decided doc)
**Target user:** Logan. LG UltraGear 3440×1440 240Hz OLED — assumed 34GS95QE, with ~95% OSD consistency across 39/45 variants.

## Context

LG UltraGear monitors use a joystick at the bottom-center of the panel. No app, no USB utility — all navigation is physical. This walkthrough is mechanical: "push joystick down, push right, select X."

Flag the model assumption up front. If Logan has a different LG UltraGear variant (39" / 45"), menu paths should be ~95% identical but note any deviation.

## Required sections, in order

1. **Before starting**
   - Power on monitor, ensure display cable is DP 1.4 (NOT HDMI — HDMI caps at 165Hz for 3440×1440)
   - Confirm 240Hz active: Windows Settings → System → Display → Advanced Display → Refresh rate = 240 Hz
   - Joystick location: bottom-center of monitor, just under the panel

2. **Joystick basics**
   Brief explanation:
   - **Push in** (click) = open menu / confirm selection
   - **Up/Down** = navigate menu / adjust value
   - **Left** = back/cancel
   - **Right** = enter submenu / confirm

3. **Picture Mode** (OSD → Game Adjust → Picture Mode)
   - Set: **Gamer 1**
   - NOT FPS1 / FPS2 — those lock Black Stabilizer and other settings
   - Reasoning: only Gamer 1 allows full independent tuning of Black Stabilizer + Response Time + Sharpness

   Step-by-step joystick sequence to get there.

4. **Response & Motion** (OSD → Game Adjust)
   Table with joystick navigation + target values:
   - Response Time = **Fast** (not Faster — Faster causes inverse-ghosting overshoot at 240Hz on LG OLED)
   - Dynamic Action Sync (DAS) = **On** (low-latency input mode)
   - Black Stabilizer = **70** (default 50; brightens 0-30% luminance, critical for industrial interiors)
   - Sharpness = 50 (default; FSR 4.1 + RIS already sharpen)

5. **Sync settings** (OSD → Game Adjust → Adaptive-Sync, and Settings → Input)
   - Adaptive-Sync / FreeSync Premium Pro = **On**
   - DisplayPort Version (OSD setting) = **1.4**
   - Cable check: certified DP 1.4 cable (not DP 1.2 or HDMI)
   - DSC = Auto (should engage automatically at 240Hz — 3440×1440@240Hz needs ~26 Gbps, DP 1.4 native is 32.4 Gbps, DSC visually lossless at this ratio)

   Reverse condition: if visual compression artifacts at 240Hz → drop to 165Hz to eliminate DSC or verify cable rating.

6. **HDR** (OSD → Picture + Arc Raiders + Windows)
   - In-monitor HDR = Off (in Gamer 1 mode)
   - Windows HDR global = Off
   - Arc Raiders in-game HDR = Off

   Reasoning from decided doc: UE5 HDR in competitive shooters not validated; tone mapping crushes shadow detail; OLED SDR has effectively infinite contrast already.

7. **OLED-specific settings** (OSD → OLED Settings or similar)
   Table per Domain 6:
   - Local Dimming (if menu exists) = Off (WOLED zone-level dimming blooms in combat)
   - Uniform Brightness = **On** (prevents ABL auto-dimming during bright scene changes — critical for consistent visibility)
   - Pixel Refresher = run weekly (panel maintenance)
   - Logo Luminance Adjustment = Off or Low
   - Screen Saver = Off (use Windows screen saver w/ 10min timer instead)
   - Peak Brightness = High
   - Brightness = 40-60
   - Contrast = 70-75
   - Color Temperature = Warm 2 or Medium

   Callout: Uniform Brightness ON is critical. It's easy to miss and trades a small peak brightness loss for massive consistency gain — competitive priority.

8. **Verification**
   - Test motion clarity: open the UFO test (https://testufo.com) in browser at 240Hz. Confirm smooth motion, no pronounced ghosting at Response Time = Fast.
   - If ghosting visible → check Response Time is Fast (not Standard/Normal)
   - If inverse-ghosting / trailing visible → Response Time is set to Faster; drop to Fast
   - Confirm Black Stabilizer change by loading a dark scene (Windows lock screen works, or any dark wallpaper) — shadow detail should be visible without black crush

## Traceability rule

Every setting cites `(Domain 6, Picture Mode)` / `(Domain 6, Response & Motion)` / `(Domain 6, Sync)` / `(Domain 6, HDR)` / `(Domain 6, OLED-Specific)`.

## Do NOT include

- ❌ FPS1 or FPS2 picture modes (locked controls)
- ❌ Monitor Local Dimming ON (blooming in combat)
- ❌ HDR ON
- ❌ HDMI connection (bandwidth-capped at 165Hz)
- ❌ Pixel Refresher disabled (OLED burn-in risk)

## Flag explicitly up front

Model caveat: assumed 34GS95QE based on decided doc. If Logan has 39GS95QE or 45GS95QE, OSD labels should be ~95% identical but exact menu tree may differ slightly. Flag any section where menu labels might vary.

## Tone

Step-by-step. Joystick sequences explicit ("push joystick right twice, then down three times, click"). Troubleshooting section for common "my menu doesn't look like yours" cases.

## Length target

150-250 lines.
