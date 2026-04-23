# Brief — iCUE / Scuf Envision Pro Walkthrough (Domain 7)

**Output file:** `iCUE_Walkthrough.md`
**Source domain:** ArcRaiders_Decided_Settings.md Domain 7 (lines 515-576 of the decided doc)
**Target user:** Logan. Scuf Envision Pro (Hall Effect sticks), wired USB-C.

## CRITICAL terminology correction

The decided doc calls the app "Scuf G-App." **This is wrong.** Phase 0 research confirmed the Scuf Envision Pro is configured via **Corsair iCUE** (not a separate Scuf app). Scuf's own support docs and quick-start guide point to iCUE. PCGamingWiki's Envision page confirms iCUE.

This walkthrough uses "iCUE" throughout. When referencing the decided doc's "Scuf G-App" nomenclature, use format: `(Domain 7, Scuf G-App → iCUE in this doc)`.

## Context

Phase 0 research confirmed iCUE has a real `.cueprofile` export/import system. The profile format is proprietary and not hand-authorable, BUT the walkthrough ends with exporting a portable `.cueprofile` the user owns for backup / reinstalls / second rig.

## Required sections, in order

1. **Connection setup** (physical)
   - Wired USB-C (NOT 2.4GHz dongle, NOT Bluetooth)
   - Reasoning: Gamepadla measured 3.7ms button latency wired vs 6.19ms dongle; wired wins on priority #1 (input latency)
   - Connectivity switch (Envision Pro back): set to USB mode
   - iCUE should auto-detect the controller

2. **Install prep**
   - Download latest iCUE from https://www.corsair.com/us/en/s/downloads
   - Install and launch
   - Connect Envision Pro wired, allow driver install
   - Update firmware if prompted

3. **Trigger stops** (physical hardware switch, NOT software)
   - Flip both trigger hardware switches to **Instant** mode
   - These are physical switches on the back of the controller, not an iCUE setting
   - Reasoning: converts analog trigger throw to near-digital activation, pure latency win for ADS + Fire

4. **iCUE navigation basics**
   - Home screen shows connected devices
   - Click the Envision Pro module to open its settings
   - Sections available: Profiles, Key Assignments (Hardware Mapping), Triggers & Thumbsticks, Vibration, Onboard Memory

5. **Create Arc Raiders profile** (iCUE → Envision Pro → Profiles)
   - Click "+" or "Create new profile"
   - Name it: `ArcRaiders_Linear`
   - Set as active

6. **Thumbstick curves** (iCUE → Triggers & Thumbsticks → Thumbsticks tab)
   Critical principle: ALL deadzone and curve work happens in-game (Domain 2). iCUE is transparent passthrough. Running 0%/100% + Linear means the stick signal reaches Arc Raiders unprocessed.

   Table per Domain 7:
   - Left Stick Curve = Linear
   - Right Stick Curve = Linear
   - Left Stick Sensitivity = Default (100%)
   - Right Stick Sensitivity = Default (100%)
   - Left Stick Inner Deadzone (iCUE) = 0%
   - Left Stick Outer Deadzone (iCUE) = 100%
   - Right Stick Inner Deadzone (iCUE) = 0%
   - Right Stick Outer Deadzone (iCUE) = 100%

   Step-by-step how to set these in iCUE's UI. Custom preset vs preset-from-dropdown.

7. **Trigger curves** (iCUE → Triggers & Thumbsticks → Triggers tab)
   - Left Trigger Curve = Linear
   - Right Trigger Curve = Linear
   - Left Trigger Inner Deadzone (iCUE) = 0%
   - Left Trigger Outer Deadzone (iCUE) = 100%
   - Right Trigger same

8. **Vibration** (iCUE → Vibration)
   - Both modules = 0% / Off
   - Reasoning: rumble masks low-end audio (ARC Machine rumble, distant explosions) — decided doc priority is audio clarity
   - Also reduces thumb fatigue over long sessions

9. **Paddle + SAX bindings** (iCUE → Key Assignments / Hardware Mapping)

   CRITICAL principle (Snip3down-style extraction economy): keep both thumbs on sticks during combat. Migrate jump/crouch/reload/interact off face buttons to paddles/SAX.

   | Input | Binding | Controller button equivalent |
   |-------|---------|------------------------------|
   | Left SAX (inner, near L1) | Crouch / Slide | B / Circle (whatever Arc Raiders uses for crouch) |
   | Right SAX (inner, near R1) | Jump | A / Cross |
   | Left Inner Paddle | Reload | X / Square |
   | Right Inner Paddle | Interact (loot/door/revive) | Y / Triangle |
   | G-Keys (if bound) | Inventory toggle / Map toggle | Non-combat actions |

   Explain the iCUE workflow: Select button on controller visualization → Assign function → Save.

   **⚠️ CRITICAL DO-NOT:** No rapid-fire / turbo macros on any paddle. Decided doc Domain 7 explicit warning — "kettle" rapid-fire macros are what Anybrain AI flags. Legitimate shoulder swap / weapon swap bindings are fine; actual rapid-fire is a ban risk.

10. **Save to onboard memory** (iCUE → Device Settings → Onboard Memory)
    - Envision Pro has 3 onboard slots
    - Save `ArcRaiders_Linear` to **Slot 1** (default-active on controller power-on)
    - Click three dots → Overwrite
    - After this save, the profile works even when iCUE isn't running (wired session still loads hardware mapping)

11. **Export portable profile backup**
    - iCUE → Envision Pro → Profiles → find `ArcRaiders_Linear`
    - Three-dot menu → Export
    - Save as: `C:\Users\logan\ArcRaiders-Configs\ArcRaiders_Linear.cueprofile`
    - This is the portable backup. To re-apply on a reinstall: iCUE → Profiles → Import → select the .cueprofile

12. **LED / visual**
    - LED brightness = dim or off (reduce desk-side distraction during gaming)
    - Not a performance setting, just a comfort call

13. **Verification**
    - Launch Arc Raiders
    - In Practice Range: test each paddle/SAX binding fires the correct in-game action
    - Tracking test: slow-pan left-to-right on a bot. No dead-feel in the middle of the stick (0% iCUE deadzone means Arc Raiders' 5% deadzone is the only one)
    - Trigger test: full ADS activates on tiny pull (instant trigger stops active)

## Traceability rule

Every setting cites `(Domain 7, Connection)` / `(Domain 7, Trigger Stops)` / `(Domain 7, Stick Curves)` / `(Domain 7, Paddle Bindings)` / etc.

## Do NOT include

- ❌ 2.4GHz dongle or Bluetooth connection (latency)
- ❌ Any deadzone > 0% in iCUE (double-processing violation — in-game owns deadzones)
- ❌ Any non-Linear curve (stacks with aim assist unpredictably)
- ❌ Rapid-fire / turbo / kettle macros on ANY button (ban risk)
- ❌ Vibration > 0
- ❌ "Scuf G-App" terminology without the iCUE correction
- ❌ Gyro Aim settings (not supported on Envision Pro)

## Tone

Step-by-step UI navigation (iCUE has a clicking-through-UI workflow). Tables for settings. Explicit about the "transparent passthrough" principle — this is the #1 thing new iCUE users get wrong.

## Length target

200-350 lines.
