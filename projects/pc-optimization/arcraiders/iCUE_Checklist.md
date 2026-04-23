# iCUE Checklist — Scuf Envision Pro for Arc Raiders

> **DECIDED-DOC CORRECTION:** `ArcRaiders_Decided_Settings.md` Domain 7 lists the configuration software as "Scuf G-App". The actual software for the Scuf Envision Pro is **Corsair iCUE** (Scuf is owned by Corsair; the Envision Pro is managed through iCUE, not G-App). All menu paths below use iCUE. Values from Domain 7 still apply as-is.

**Source:** `ArcRaiders_Decided_Settings.md` Domain 7 (Controller)
**Device:** Scuf Envision Pro (Hall Effect sticks, USB wired)
**Software:** Corsair iCUE
**Time:** ~5 min

---

## Pre-flight

1. Plug Envision Pro into PC via USB-C cable (wired only — don't use 2.4GHz dongle for competitive play).
2. Open iCUE. Select the Envision Pro device in the left sidebar.
3. Profile menu (top) → **Create New Profile** → name it `ArcRaiders`.

---

## Sticks — Response Curves

Menu path: `iCUE > Envision Pro > Key Assignments` or `Sticks` tab (exact label varies by iCUE version)

| Setting | Value | Domain |
|---|---|---|
| Left Stick Curve | **Linear** | Domain 7 |
| Right Stick Curve | **Linear** | Domain 7 |
| Left Stick Sensitivity | **100% / 1.0×** (default) | Domain 7 |
| Right Stick Sensitivity | **100% / 1.0×** (default) | Domain 7 |

---

## Sticks — Deadzones (CRITICAL)

| Setting | Value | Domain |
|---|---|---|
| Left Stick Inner Deadzone | **0%** | Domain 7 |
| Left Stick Outer Deadzone | **0%** | Domain 7 |
| Right Stick Inner Deadzone | **0%** | Domain 7 |
| Right Stick Outer Deadzone | **0%** | Domain 7 |

**EXPLICIT DECIDED-DOC RULE — Domain 7:** deadzones are applied **in-game ONLY**. Stacking a hardware deadzone (iCUE) + a software deadzone (Arc Raiders) double-processes the stick input and breaks aim consistency at low stick deflections. Set iCUE to 0%/0% and configure Arc Raiders' in-game deadzones per `InGame_Sliders_Checklist.md`.

---

## Triggers

Menu path: `Triggers` tab

| Setting | Value | Domain |
|---|---|---|
| Left Trigger Mode | **Instant Trigger** (via physical toggle on controller back) | Domain 7 |
| Right Trigger Mode | **Instant Trigger** (physical toggle) | Domain 7 |
| Left Trigger Deadzone | **0%** | Domain 7 |
| Right Trigger Deadzone | **0%** | Domain 7 |

**Instant Trigger** is toggled via the physical switches on the back of the Envision Pro — not in iCUE. Confirm both switches are flipped to Instant Trigger mode. This shortens trigger travel to a microswitch click — ~3× faster shot-to-registration.

---

## Paddle Bindings (rear paddles P1–P4)

Menu path: `Key Assignments > Paddles`

| Paddle | Binding | Domain |
|---|---|---|
| P1 (top-left) | **Jump** (A button equivalent) | Domain 7 |
| P2 (top-right) | **Crouch** (B button equivalent) | Domain 7 |
| P3 (bottom-left) | **Reload** (X button equivalent) | Domain 7 |
| P4 (bottom-right) | **Interact** (Y button equivalent) | Domain 7 |

**Why paddles:** keeps right thumb on the aim stick during jump/crouch/reload/interact actions. Standard competitive mapping.

**Verify mapping direction:** the paddle label (P1/P2/P3/P4) corresponds to physical location — confirm by triggering each in the iCUE test panel and watching which paddle LED lights.

---

## Face Buttons, D-Pad, Bumpers

Leave at default (stock Xbox-layout mapping). Arc Raiders uses default mappings for face buttons and D-pad.

| Control | Value |
|---|---|
| Stick Layout | **Default** (left stick = move, right stick = aim) |
| Vibration | Per decided doc (typically Low or Off for competitive) |

---

## Save to Onboard

Menu path: `Profile > Save to Onboard Memory > Slot 1`

1. With the `ArcRaiders` profile active, Save to Slot 1.
2. Confirm slot indicator LED on the controller matches Slot 1.
3. Profile is now active even on PCs without iCUE installed (LAN events, loaner systems).

---

## Export Backup

Menu path: `File > Export Profile`

1. Filename: `ArcRaiders-Envision-Pro.cueprofile`
2. Save to: `C:\Users\logan\Projects\Claudious\projects\pc-optimization\arcraiders\`
3. This is your revert artifact. Re-import with `File > Import Profile` if iCUE ever wipes the profile.

---

## Verify

1. In iCUE test panel: wiggle sticks at 1% deflection — both should register (0% deadzone working).
2. Pull triggers slightly — should trigger immediately (Instant Trigger working via physical switch).
3. Press each paddle — each should light its own indicator.
4. Controller LED indicates Slot 1 is active.

---

## Notes

- Do NOT enable iCUE's "Mouse & Keyboard emulation" modes — Arc Raiders sees the controller natively as Xinput.
- Envision Pro's Hall Effect sticks don't drift; if you see drift, it's iCUE misconfiguration not hardware.
- If iCUE updates reset your profile, reimport from the `.cueprofile` backup.
