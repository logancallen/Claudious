# Arc Raiders In-Game Walkthrough

Applies Domain 2 of `ArcRaiders_Decided_Settings.md`. Rig: RX 9070 XT, 3440×1440 240Hz OLED, Scuf Envision Pro (controller-primary).

This is the longest walkthrough by setting count. Work the sections in order — Display → Graphics → Audio → Controller — and save at each section boundary if Arc Raiders gives you a save button. Many settings are server-side (aim assist, sensitivities, audio routing) so manual entry is the only path; no ini edit substitutes for this walkthrough.

## 1. Pre-launch checks

Before launching Arc Raiders:

1. Adrenalin Arc Raiders profile exists (see `Adrenalin_Walkthrough.md`). If not, do that walkthrough first.
2. Monitor is at 3440×1440 @ 240 Hz:
   - Windows Settings → System → Display → Advanced Display → confirm **Refresh rate = 240 Hz** and **Desktop resolution = 3440 × 1440**.
   - If stuck at 165 Hz: cable is HDMI or DP 1.2 — see `OSD_Walkthrough.md` section on DP 1.4 + DSC.
3. Launch Arc Raiders, reach the main menu, then enter **Settings**. All sections below assume you are inside the in-game Settings menu.

## 2. Display

Location: Settings → Display (or Video / Graphics → Display — verify exact label in your in-game UI).

| Setting | Value | Source | Reason |
|---|---|---|---|
| Display Mode | **Exclusive Fullscreen** | (Domain 2, Display) | Lowest input latency. Borderless is close on W11 25H2 but still trails for competitive. |
| Resolution | **3440×1440** | (Domain 2, Display) | Native panel resolution. |
| V-Sync | **Off** | (Domain 2, Display) | Latency; FreeSync Premium Pro VRR handles tearing. |
| Frame Rate Limit | **138** | (Domain 2, Display) | Below the 150 realistic ceiling, inside VRR range, prevents render-queue buildup. |
| Upscaled Resolution | **100%** | (Domain 2, Display) | Never scale below 100% — upscaler handles the internal scale. Lower = double-downscale blur. |
| Resolution Scaling Method | **AMD FSR3** | (Domain 2, Display) | Driver override upgrades FSR 3.1 → FSR 4.1. FSR 4.1 beats XeSS on 9070 XT. |
| FSR Quality Tier | **Quality** | (Domain 2, Display) | At 3440×1440 output, Quality (~2580×1075 internal) is the sweet spot. Balanced introduces foliage smearing. |
| Field of View | **80** | (Domain 2, Display) | Max in-game slider. Any guide claiming 95 is wrong. |

### Frame cap sanity check

Panel is 240 Hz, which would suggest capping around 237 (3 below refresh). This rig is realistically 120–150 FPS bound in Arc Raiders, so a 237 cap is never hit anyway. Capping at **138** keeps the GPU clearly below the uncapped ceiling (prevents render-queue buildup and input-lag spikes on GPU-bound scenes), locks frametime pacing across the full raid, and sits comfortably inside the FreeSync VRR range (48–240 Hz). If a specific combat scene consistently drops below 118, lower the cap to 110 for that session — uniform pacing beats peak FPS (Domain 2, Display frame cap note).

## 3. Graphics Quality

Location: Settings → Graphics / Graphics Quality. Set every row; several are unusual competitive choices and need the full list applied to lock the preset.

| Setting | Value | Source | Reason |
|---|---|---|---|
| **Global Illumination** (RTXGI) | **Static** | (Domain 2, Graphics Quality) | +30–80% vs Dynamic Epic. RTXGI is NVIDIA-branded running via DXR on AMD — no hardware acceleration benefit. Biggest single FPS lever. |
| Global Illumination Resolution | **Medium** | (Domain 2, Graphics Quality) | Only active if GI ≠ Static; Medium for the edge case you flip back. |
| Shadows | **Medium** | (Domain 2, Graphics Quality) | ~+15% vs Epic. Low kills tactical shadow info around corners. Medium keeps shadow intel, cuts GPU cost. |
| View Distance | **High** | (Domain 2, Graphics Quality) | ~+5% vs Epic. Epic adds marginal far-LOD at real cost. High prevents long-range pop-in. |
| Anti-Aliasing | **Medium** | (Domain 2, Graphics Quality) | TAA fallback behind FSR; Medium balances edge quality without blur. |
| Textures | **High** | (Domain 2, Graphics Quality) | 16GB VRAM has the headroom. Epic is marginal visual at no perf cost either. |
| Effects | **Low** | (Domain 2, Graphics Quality) | +6%. Keeps combat readable through smoke/dust. |
| **Post-Processing** | **Low** | (Domain 2, Graphics Quality) | +15–17%. Second-biggest FPS lever after RTXGI. Kills bloom/DoF/motion-blur artifacts; improves threat tracking. |
| Reflections | **Low** | (Domain 2, Graphics Quality) | ~+3%. SSR-based; shiny surfaces are not where threats come from. |
| **Foliage** | **Low** | (Domain 2, Graphics Quality) | +2–4%. **Visibility advantage:** removes tall grass/bushes that hide enemies on High/Epic. Competitive non-negotiable. |
| Motion Blur | **Off** | (Domain 2, Graphics Quality) | +1%. Zero competitive value. |
| Depth of Field | **Off** | (Domain 2, Graphics Quality) | +1%. Hides threats at peripheral range. |
| Film Grain | **Off** | (Domain 2, Graphics Quality) | Visual noise. |
| Chromatic Aberration | **Off** | (Domain 2, Graphics Quality) | Visual noise. |
| Vignette | **Off** | (Domain 2, Graphics Quality) | Darkens peripheral — bad for awareness. |
| Lens Flares | **Off** | (Domain 2, Graphics Quality) | Distracts from muzzle-flash detection. |

**Graphics summary:** this is a competitive preset. You are trading cinematic depth for threat readability and frame consistency. Every Off in the table above exists to stop the game from hiding information from you (Domain 2, Graphics Quality summary paragraph).

## 4. Audio (In-Game)

Location: Settings → Audio. The Output Device selection here is what routes Arc Raiders through Sonar. If this is wrong, the Sonar EQ (see `Sonar_Walkthrough.md`) does nothing.

| Setting | Value | Source | Reason |
|---|---|---|---|
| **Output Device** | **SteelSeries Sonar - Game** (virtual playback device) | (Domain 2, Audio) | Routes game audio into Sonar's Game channel for EQ processing. Critical — cross-reference `Sonar_Walkthrough.md` Routing section. |
| Audio Mode | **Stereo / Headphones** | (Domain 2, Audio) | Enables Arc Raiders' native UE5 HRTF. |
| **Night Mode** | **OFF** | (Domain 2, Audio) | Dynamic range compression flattens distance cues. Sonar custom EQ handles the footstep boost without compression. If you skip the Sonar EQ entirely, flip Night Mode ON as the simpler alternative — since this package uses the custom EQ, keep it OFF. |
| Master Volume | **70–80%** | (Domain 2, Audio) | Headroom for dynamic peaks. |
| Music Volume | **0** | (Domain 2, Audio) | Music masks directional cues. |
| Proximity Chat Mode | **Push-to-Talk** | (Domain 2, Audio) | Prevents audio leak to nearby enemies. |
| Proximity Chat Volume | **100%** | (Domain 2, Audio) | Default 140% distorts incoming voice. |
| Voice Chat Volume | **80%** | (Domain 2, Audio) | Clear but non-masking. |
| Effects Volume | **100%** | (Domain 2, Audio) | Full detail on footsteps / reloads. |

**Output Device verification:** after saving, alt-tab to Windows Sound Mixer during a raid — Arc Raiders should show audio activity on the **SteelSeries Sonar - Game** playback device, not on the Arctis Nova Pro directly. If Arc Raiders is bypassing Sonar, the EQ is silent.

## 5. Controller (In-Game)

These are the game-side values for the Scuf Envision Pro. The decided-doc central principle is this:

> **Every deadzone and response curve lives in-game, nowhere else. Double-processing is the #1 cause of inconsistent controller feel.**

iCUE (Domain 7 / `iCUE_Walkthrough.md`) runs as a transparent passthrough — 0%/100% deadzones, Linear curves. That means Arc Raiders' settings below are the only layer shaping your stick signal.

Location: Settings → Controller (or Input). Labels may vary slightly; verify exact labels in your in-game UI.

| Setting | Value | Source | Reason |
|---|---|---|---|
| Aim Assist | **Enabled** | (Domain 2, Controller) | Controller-primary in a shooter with aim-assist opponents — disabling self-handicaps. |
| Aim Assist Strength | **Medium** | (Domain 2, Controller) | Tracks ARC Machines cleanly without High's sticky target-lock feel. |
| Horizontal Sensitivity | **75** | (Domain 2, Controller) | Starting point; tune ±5 after 2 live raids. |
| Vertical Sensitivity | **60** | (Domain 2, Controller) | 80% of horizontal is the competitive norm. |
| ADS Sensitivity Multiplier | **40%** | (Domain 2, Controller) | Scales down for precision at scope magnification. |
| Scoped Sensitivity Multiplier | **50%** | (Domain 2, Controller) | Slightly higher than ADS for tracking at max zoom. |
| Look Response Curve | **Linear** | (Domain 2, Controller) | UE5 aim-assist velocity model works predictably with Linear. Exponential stacks with aim-assist slow zones and produces jerky corrections. |
| Look Boost / Acceleration | **Off** | (Domain 2, Controller) | Any acceleration fights aim assist engagement. |
| Right Stick Inner Deadzone | **5%** (bump to 7% if drift) | (Domain 2, Controller) | Hall-effect sticks on Envision Pro tolerate lower deadzones than potentiometer sticks. |
| Right Stick Outer Deadzone | **Default (~98%)** | (Domain 2, Controller) | Don't clip the outer edge. |
| Left Stick Inner Deadzone | **8%** | (Domain 2, Controller) | Movement tolerance higher than aim — minor drift during strafe should not trigger movement. |
| Left Stick Outer Deadzone | **Default** | (Domain 2, Controller) | — |
| Trigger Inner Deadzone | **3%** | (Domain 2, Controller) | Ensures instant-trigger click isn't misread as drift. |
| **Vibration / Rumble** | **Off** | (Domain 2, Controller) | Rumble masks low-end audio cues (ARC Machine rumble, distant explosions). Audio clarity is priority; also reduces thumb fatigue. |
| Gyro Aim | **Off** | (Domain 2, Controller) | Not supported on Envision Pro. |
| Interact Priority | **Prioritize Reload** | (Domain 2, Controller) | Panic reload > accidental loot interact in most fight scenarios. |

### Reverse conditions for sensitivity

After 5 live raids, reassess:
- If long-range tracking feels slow → bump horizontal **+5** (to 80). One-step only.
- If close-range overshoot → drop horizontal **-5** (to 70).
- Do not adjust two sensitivity values in the same session. Identify one feel problem, change one value, test for 2 raids (Domain 2, Controller reverse-conditions paragraph).

### Bindings note

Paddle and SAX bindings are handled in iCUE (`iCUE_Walkthrough.md`). In-game, keep the **default face-button bindings** — iCUE remaps paddles/SAX to mirror the face-button inputs, so Arc Raiders sees a standard Xbox controller signal regardless of which physical input you press.

## 6. Post-setup verification

Before committing to a full raid, run this verification pass:

1. **Spawn Practice Range** from the main menu.
2. **FSR 4.1 active:** press **Alt+R** → Performance → Overlay. Confirm "FSR Upscaling 4.1" active. If inactive, see `Adrenalin_Walkthrough.md` Troubleshooting.
3. **Aim feel:** spawn a bot at ~25m, perform slow left-right tracking and a quick flick. No dead-feel in stick center (deadzone double-processing issue — see `iCUE_Walkthrough.md` Verification). No overshoot on flicks (Look Boost still Off).
4. **Audio routing:** listen for bot footsteps at ~15m. They should be audible and directional. If flat or muddy: Sonar EQ is either not active or routing is wrong — see `Sonar_Walkthrough.md` Verification.
5. **Audio output device sanity check:** alt-tab → Windows Sound Mixer. Arc Raiders process should show meter activity on **SteelSeries Sonar - Game**, not on the Arctis Nova Pro.
6. **Xbox Game Bar game registration (enables CCD parking):** press **Win+G** while Arc Raiders has focus. If the bar opens and asks "Remember this is a game," confirm **yes**. This registers Arc Raiders with the AMD 3D V-Cache Performance Optimizer service so game threads get steered to CCD0 (V-Cache). If Win+G does not open: Xbox Game Bar is uninstalled or disabled — required for CCD parking, reinstall from Microsoft Store.
7. **Frame cap:** stand still in Practice Range and watch the Adrenalin overlay framerate. Should sit at **138** with 0% overshoot. If it drifts above 138, the in-game cap did not take — re-enter 138 and save.

### Final live-fire tune

1. One raid, no expectations. Observe aim feel, footstep audibility, frame stability.
2. After raid 2: if sensitivity feels off, apply one ±5 step (horizontal only). Do not touch graphics or audio yet.
3. After raid 5: lock all settings. Any further changes should be deliberate and documented.

If anything regresses your baseline after applying this walkthrough, revert the most recent change first (Arc Raiders Settings → Reset section to default) before stacking further changes. Don't stack multiple tweaks before validating.
