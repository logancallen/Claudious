# LG UltraGear OSD Checklist — Arc Raiders

**Source:** `ArcRaiders_Decided_Settings.md` Domain 6 (Monitor / OSD)
**Monitor:** LG UltraGear 34GS95QE (3440×1440, 240Hz OLED, WOLED)
**Access:** joystick button under the center of the monitor bezel → press in to open OSD
**Time:** ~3 min

---

## Navigation reminder

Press joystick in → full OSD appears. Joystick up/down/left/right navigates. Press in to select. Press and hold to exit.

---

## Game Mode

Menu path: `Settings > Game Adjust > Picture Mode`

| Setting | Value | Domain |
|---|---|---|
| Picture Mode | **Gamer 1** | Domain 6 |

**Why Gamer 1:** user-configurable preset. Gamer 2 is the alternate slot for non-competitive use. FPS and RTS presets have locked gamma/black levels that conflict with Black Stabilizer.

---

## Game Adjust (core competitive settings)

Menu path: `Settings > Game Adjust`

| Setting | Value | Domain |
|---|---|---|
| Response Time | **Fast** (NOT Faster) | Domain 6 |
| Adaptive-Sync / VRR | **On** | Domain 6 |
| Black Stabilizer | **70** | Domain 6 |
| Cross Hair | **Off** | Domain 6 |
| FPS Counter | **Off** (use in-game FPS counter instead) | Domain 6 |
| DAS Mode (Dynamic Action Sync) | **On** | Domain 6 |

**Response Time — Fast only:** decided doc explicitly calls out that **Faster** causes inverse-ghosting on this panel. Fast is the correct ceiling. Do not push to Faster.

**DAS On:** reduces input lag by skipping some frame processing. Small but real.

---

## Picture Adjust

Menu path: `Settings > Picture > Picture Adjust`

| Setting | Value | Domain |
|---|---|---|
| Brightness | Per decided doc (typically 80–100 for OLED HDR) | Domain 6 |
| Contrast | 70 | Domain 6 |
| Sharpness | 50 (center — no sharpening) | Domain 6 |
| Gamma | Mode 2 | Domain 6 |
| Color Temperature | Warm → Medium (Warm/50 on OLED) | Domain 6 |
| Black Level | **High** (if connected via HDMI) | Domain 6 |

---

## OLED-specific

Menu path: `Settings > General > OLED Care`

| Setting | Value | Domain |
|---|---|---|
| Uniform Brightness | **On** | Domain 6 |
| Pixel Cleaning | Run once after extended sessions (monthly-ish) | Domain 6 |
| Screen Move | On (subtle pixel shift prevents burn-in) | Domain 6 |
| Image Cleaning | Auto (runs at power-off) | Domain 6 |

**Uniform Brightness ON:** disables the OLED's automatic brightness limiter (ABL) behavior that darkens large bright areas. Decided doc requires this for competitive consistency — the ABL makes gunfire flashes inconsistently bright and can mask visibility.

---

## HDR (if using HDR in-game)

Menu path: `Settings > Picture > HDR`

| Setting | Value | Domain |
|---|---|---|
| HDR | **On** (system-level) | Domain 6 |
| Peak Brightness | **High** | Domain 6 |
| Dynamic Tone Mapping | **Off** (let game handle it) | Domain 6 |

If running Arc Raiders in SDR, leave HDR off at the OS level and the monitor auto-switches.

---

## Verify

1. Joystick → Input source shows correct DisplayPort / HDMI.
2. Top-right corner: refresh rate indicator should show **240Hz**.
3. In a dark game scene (Arc Raiders main menu loading), you should see detail in the shadows — that's Black Stabilizer 70 working.
4. NO visible flicker / banding on white surfaces = Uniform Brightness working.

---

## Notes

- If the OSD joystick is unresponsive, the monitor needs a power cycle (unplug 30 sec, replug).
- After firmware updates (if LG pushes one), re-verify every value above — firmware updates can reset to defaults.
- Pixel Cleaning runs a ~10 min maintenance cycle — don't run it mid-game.
