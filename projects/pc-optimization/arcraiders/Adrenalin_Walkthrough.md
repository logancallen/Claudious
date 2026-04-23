# Adrenalin Walkthrough — Arc Raiders (RX 9070 XT)

Applies Domain 1 of `ArcRaiders_Decided_Settings.md`. Driver: AMD Adrenalin 26.3.1 WHQL (2026-03-19). Rig: RX 9070 XT, controller-primary (Scuf Envision Pro).

## 1. Install + clean-slate prep

1. Check current driver: Adrenalin → Home → top-right shows version. Target is **26.3.1 WHQL**.
2. If upgrading from any 25.x or earlier <26.0 build, run the **AMD Cleanup Utility** FIRST (download from AMD support site, boot into Safe Mode when prompted, let it wipe). Skipping this is the single most common cause of profile/overlay bugs on RDNA 4.
3. Run the 26.3.1 installer → select **Factory Reset** install mode (not Express, not Custom). This forces a clean driver state even if Cleanup was skipped.
4. Reboot after install completes.
5. Relaunch Adrenalin. Accept any first-run prompts. Skip the AMD account sign-in unless you want cloud profile sync.

## 2. Global settings — apply once

These apply across all games. Location labels are for Adrenalin 26.3.1; minor UI drift is possible in point releases.

| Setting | Value | Path | Source |
|---|---|---|---|
| Hardware-Accelerated GPU Scheduling (HAGS) | **ON** | Windows Settings → System → Display → Graphics → Default graphics settings → Hardware-accelerated GPU scheduling | (Domain 1, Global / Driver table) |
| Enhanced Sync | **OFF** | Adrenalin → Settings → Graphics → Enhanced Sync | (Domain 1, Global / Driver table) |
| Radeon Chill | **OFF** | Adrenalin → Settings → Graphics → Radeon Chill | (Domain 1, Global / Driver table) |
| Radeon Boost | **OFF** | Adrenalin → Settings → Graphics → Radeon Boost | (Domain 1, Global / Driver table) |

**Why HAGS ON:** Better 1% lows on modern AMD drivers; 26.3.1 specifically fixed the HAGS-related alt-tab crash on earlier RDNA 4 builds. AFMF 2 also requires HAGS on, so leave it available even though AFMF 2 is disabled in-profile (Domain 1, Global / Driver table).

**Why Enhanced Sync / Chill / Boost OFF:** Enhanced Sync fights FreeSync Premium Pro hardware VRR. Chill throttles framerate when "little movement detected" — hostile to frametime consistency in a shooter. Boost layers dynamic resolution on top of FSR, double-scaling (Domain 1, Global / Driver table).

Reboot is not required after global changes.

## 3. Create Arc Raiders per-game profile

1. In Adrenalin, click the **Gaming** tab (top nav).
2. Arc Raiders may auto-appear under Installed Games if Steam is detected. If yes, click it. Skip to step 5.
3. If not auto-detected: click **Add a Game** (or the `+` tile).
4. Browse to the Arc Raiders EXE. Default Steam path:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\ARC Raiders\ARC-Win64-Shipping.exe
   ```
   If your Steam library is on a different drive, confirm via Steam → right-click Arc Raiders → **Manage** → **Browse local files** → look for `ARC-Win64-Shipping.exe` in the binaries folder (verify exact EXE name in your install).
5. Name the profile "Arc Raiders" if Adrenalin doesn't auto-name it.
6. Open the new profile. You should land on a per-game Graphics pane.

Adrenalin matches per-game profiles by exact EXE name and path. If the game moves drives or the EXE is renamed after a patch, re-point the profile.

## 4. Per-game profile settings

All paths below assume you are inside **Gaming → Arc Raiders**. Tabs inside the profile are typically Graphics / Display (labels may vary by Adrenalin point release).

| Setting | Value | Path (inside Arc Raiders profile) | Source |
|---|---|---|---|
| Anti-Lag | **OFF** | Graphics → Anti-Lag | (Domain 1, Per-Game Profile table) |
| AMD Fluid Motion Frames (AFMF 2) | **OFF** | Graphics → AMD Fluid Motion Frames | (Domain 1, Per-Game Profile table) |
| HYPR-RX | **OFF** (use manual profile) | Top of Arc Raiders profile page — HYPR-RX toggle | (Domain 1, Per-Game Profile table) |
| **FSR 4 Upgrade** (driver override) | **ON** | Graphics → AMD FSR 4 Upgrade (or "Upgrade to FSR 4") | (Domain 1, Per-Game Profile table) |
| Image Sharpening (RIS / CAS) | **60%** | Graphics → Image Sharpening → Enable, slider 60 | (Domain 1, Per-Game Profile table) |
| Enhanced Sync (per-game) | OFF | Graphics → Enhanced Sync | (Domain 1, Per-Game Profile table) |
| Wait for V-Sync | **Off** / Use Application Setting | Graphics → Wait for Vertical Refresh | (Domain 1, Per-Game Profile table) |
| Tessellation Mode | **AMD Optimized** | Graphics → Tessellation Mode | (Domain 1, Per-Game Profile table) |
| Surface Format Optimization | **ON** | Graphics → Surface Format Optimization | (Domain 1, Per-Game Profile table) |
| Texture Filtering Quality | **High Quality** | Graphics → Texture Filtering Quality | (Domain 1, Per-Game Profile table) |
| Morphological Anti-Aliasing | **OFF** | Graphics → Anti-Aliasing → Morphological Filtering | (Domain 1, Per-Game Profile table) |
| Wait for V-Sync (OpenGL) | **Off** | Graphics → OpenGL section (verify label in your UI) | (Domain 1, Per-Game Profile table) |
| Triple Buffering (OpenGL) | **Off** | Graphics → OpenGL section (verify label in your UI) | (Domain 1, Per-Game Profile table) |
| Anisotropic Filtering Mode | **Override application** | Graphics → Anisotropic Filtering Mode | (Domain 1, Per-Game Profile table) |
| Anisotropic Filtering Level | **16x** | Graphics → Anisotropic Filtering Level | (Domain 1, Per-Game Profile table) |
| Frame Rate Target Control (FRTC) | **Disabled** | Graphics → Frame Rate Target Control | (Domain 1, Per-Game Profile table) |

### Why these values

**Anti-Lag = OFF.** AMD's own GPUOpen SDK docs state Anti-Lag 2 is not compatible with the RHI backend in the FSR 3.1.1 Unreal Engine plugin Arc Raiders ships. Without Embark-side SDK integration, the Adrenalin toggle falls back to Anti-Lag 1 driver-level injection into an EAC-protected process. Zero-risk call: OFF (Domain 1, Per-Game Profile table).

**AFMF 2 = OFF.** Frame generation adds latency even when it works — Tom's Hardware measured ~7.6ms → ~15ms native-to-AFMF-2. The priority order is latency first, raw FPS last. At the 120–150 FPS realistic target, there is no FPS deficit to compensate (Domain 1, Per-Game Profile table).

**HYPR-RX = OFF.** HYPR-RX is a one-click bundle of FSR + AFMF 2 + Anti-Lag. Leaving it on re-enables the two features you just disabled. Manual profile gives per-feature control (Domain 1, Per-Game Profile table).

**FSR 4 Upgrade = ON.** Arc Raiders is on AMD's FSR Redstone / ML Frame Generation supported list. The game ships a signed FSR 3.1 DLL on DX12; the Adrenalin driver auto-upgrades that to FSR 4.1 when this toggle is on. Entirely driver-side — no file swap, no EAC risk. This is the single biggest image-quality lever in the entire package. **Verify it engaged after first launch** (Section 5 below) (Domain 1, Per-Game Profile table).

**Image Sharpening 60%.** FSR Quality at 3440×1440 renders internally at ~2580×1075. FSR 4.1 output is already noticeably sharper than FSR 3.1, but adding CAS at 60% restores thin-geometry crispness and small-target clarity. Start 60, tune 55–70 by eye, halt if foliage edges show ringing. Keep the in-game sharpness slider at center/default to avoid stacking CAS on top of in-game sharpening (Domain 1, Per-Game Profile table).

**V-Sync per-game = Off / Use Application Setting.** The in-game V-Sync toggle is authoritative (Arc Raiders in-game = Off). Driver-level V-Sync stacks badly with VRR (Domain 1, Per-Game Profile table).

**Tessellation = AMD Optimized.** Default vendor behavior; AMD Optimized caps tessellation factor on pathological geometry without clipping Arc Raiders' UE5 assets (Domain 1, Per-Game Profile table).

**Surface Format Optimization = ON.** Driver-side texture format tweaks with no visible quality impact. Small free win (Domain 1, Per-Game Profile table).

**Texture Filtering Quality = High Quality.** On the 9070 XT's 16GB VRAM budget, High Quality is free. Standard/Performance would save milliwatts you do not need (Domain 1, Per-Game Profile table).

**Morphological AA = OFF.** FSR 4.1 is doing upscaling + its own temporal AA; in-game AA = Medium handles edge cases. MLAA layered on top produces blur without adding detail (Domain 1, Per-Game Profile table).

**Anisotropic Filtering override 16x.** Forces 16x regardless of what the game requests. Near-zero GPU cost on RDNA 4; texture clarity at oblique angles is the win (Domain 1, Per-Game Profile table).

**Frame Rate Target Control = Disabled.** The cap lives in-game (138 FPS, Domain 2). Driver-level FRTC stacking with an in-game cap can produce conflicting limits (Domain 1, Per-Game Profile table).

## 5. Verify FSR 4.1 is active — critical post-setup check

One of the three verify-on-boot checks (top of decided doc). If FSR 4.1 silently fails to upgrade, the whole image-quality gain from this walkthrough disappears.

1. Launch Arc Raiders. Reach the main menu, then enter a Practice Range or any scene with visible rendering.
2. Press **Alt+R** (Adrenalin overlay default hotkey).
3. If overlay does not open: Adrenalin → Settings → Preferences → Hotkeys → confirm overlay hotkey is bound.
4. In the overlay, navigate: **Performance** → **Overlay** (or the equivalent "Active Features" panel — verify exact label in your UI).
5. Confirm the overlay shows **"FSR Upscaling 4.1"** as active.
6. If overlay shows FSR inactive while the in-game resolution scaling is set to FSR3: this is the known BF6-adjacent bug. Per AMD release notes it is currently BF6-only, but watch for it to extend to Arc Raiders. See Troubleshooting below.

**If step 5 shows FSR 3.1 (not 4.1) while the FSR 4 Upgrade toggle is ON:** the driver recognizes the game but the DLL upgrade did not inject. Re-run the Factory Reset install (Section 1, step 3). This is rare but the cleanest fix.

## 6. Troubleshooting

**FSR overlay shows inactive.**
- Confirm in-game: Settings → Display → Resolution Scaling Method = AMD FSR3. Driver only upgrades FSR 3.x to 4.1 when the game actively requests FSR. If the game is on XeSS or TAA, the upgrade is dormant by design.
- If in-game is set to FSR3 and overlay still shows inactive: Factory Reset reinstall the driver (Section 1, step 3). Reboot.
- If reinstall does not fix: known-bug territory. File Alt+R screenshot and wait for the next Adrenalin point release.

**Adrenalin overlay won't open on Alt+R.**
- Adrenalin → Settings → Preferences → Hotkeys → confirm overlay hotkey is bound to Alt+R. Point releases have occasionally reset this.
- Game running in **Exclusive Fullscreen** sometimes suppresses the overlay on first open — alt-tab once to bring it up, then return to game.
- If still nothing: Adrenalin → Settings → Preferences → In-Game Overlay toggle → On.

**Per-game profile settings don't apply in-game.**
- Adrenalin matches by exact EXE path. Confirm the EXE Adrenalin is watching matches the EXE Steam actually launches. Steam → right-click Arc Raiders → Manage → Browse local files.
- If Arc Raiders has been patched to a different shipping binary (rare but happens with UE5 engine updates), delete the old profile and re-add pointing at the new EXE.
- Factory Reset reinstall clears orphaned profile bindings as a last resort.

**Image looks over-sharpened (ringing on foliage edges).**
- Drop Image Sharpening from 60% to 55% or 50%.
- Confirm the in-game sharpness slider is at center/default. Stacking CAS on top of in-game sharpening is the usual culprit.

**Reverse conditions (from decided doc):**
- **Anti-Lag OFF** → reverse if Embark patch notes confirm Anti-Lag 2 SDK integration, or AMD ships a fix for FSR 3.1.1 UE5 plugin compatibility.
- **AFMF 2 OFF** → reverse if a future patch increases GPU load and base FPS drops sustained <80.
- **HYPR-RX OFF** → reverse if AMD publishes granular controls inside the HYPR-RX bundle.
- **FSR 4 Upgrade ON** → reverse if overlay shows FSR inactive (BF6-style bug extends to Arc Raiders), or Embark patches to a Vulkan render path.
- **HAGS ON** → reverse if LatencyMon shows sustained DPC spikes >1000µs attributable to GPU driver.
