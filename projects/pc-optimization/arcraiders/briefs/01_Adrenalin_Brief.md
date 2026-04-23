# Brief — Adrenalin Walkthrough (Domain 1)

**Output file:** `Adrenalin_Walkthrough.md`
**Source domain:** ArcRaiders_Decided_Settings.md Domain 1 (lines 45-98 of the decided doc)
**Target user:** Logan. Controller-primary (Scuf Envision Pro). RX 9070 XT. Adrenalin 26.3.1 WHQL.

## Context

Logan wanted an importable Adrenalin profile file. Phase 0 research (previous Claude session) confirmed AMD Adrenalin 26.x does NOT support hand-authored profile imports. Snap Settings exists but is a round-trip export/zip format — not an author-from-scratch path. Per-game profiles are GUI-authored in the Adrenalin UI. Therefore this walkthrough is the deliverable for Domain 1.

## Required sections, in order

1. **Install + clean-slate prep**
   - Verify current driver: should be 26.3.1 WHQL (2026-03-19 release). If upgrading from <26.0, run AMD Cleanup Utility FIRST.
   - Install mode: Factory Reset via Adrenalin installer.
   - Reboot recommended after install.

2. **Global settings — apply once**
   Table of settings with the exact menu path to each. Every setting from Domain 1's "Global / Driver" table:
   - HAGS (Windows Settings → System → Display → Graphics → Advanced → Hardware-accelerated GPU scheduling = On)
   - Enhanced Sync OFF (Adrenalin → Settings → Graphics → global)
   - Radeon Chill OFF
   - Radeon Boost OFF

3. **Create Arc Raiders per-game profile**
   - Path: Adrenalin → Gaming tab → "+" or "Add Game" button → browse to Arc Raiders EXE
   - Steam path: `C:\Program Files (x86)\Steam\steamapps\common\ARC Raiders\ARC-Win64-Shipping.exe` (confirm actual EXE name via Steam → right-click Arc Raiders → Properties → Installed Files → Browse)
   - Name the profile "Arc Raiders" (Adrenalin may auto-name)

4. **Per-game profile settings**
   Every row of Domain 1's "Arc Raiders Per-Game Profile" table with exact menu path. For each:
   - Setting name as it appears in Adrenalin 26.3.1 UI
   - Target value
   - Menu path (e.g., "Gaming → Arc Raiders → Graphics → Anti-Lag")
   - One-sentence reason cross-referencing the decided doc

   Settings to cover:
   - Anti-Lag = OFF
   - AFMF 2 / Fluid Motion Frames = OFF
   - HYPR-RX = OFF (manual profile)
   - FSR 4 Upgrade = ON  ← critical, driver-level DLL upgrade
   - Image Sharpening / RIS = 60%
   - Enhanced Sync = OFF
   - V-Sync = Off / Use Application Setting
   - Tessellation = AMD Optimized
   - Surface Format Optimization = ON
   - Texture Filtering Quality = High Quality
   - Morphological Anti-Aliasing = OFF
   - Wait for V-Sync (OpenGL) = Off
   - Triple Buffering (OpenGL) = Off
   - Anisotropic Filtering = Override 16x
   - Frame Rate Target Control = Disabled

5. **Verify FSR 4.1 is active**
   Critical post-setup check. This is one of the three verify-on-boot checks at the top of the decided doc.
   - Launch Arc Raiders
   - Press Alt+R (Adrenalin overlay hotkey)
   - Navigate Performance → Overlay
   - Confirm "FSR Upscaling 4.1" shows active
   - If inactive: known BF6-specific bug (not yet confirmed on Arc Raiders). If it appears, see troubleshooting section

6. **Troubleshooting**
   - FSR shows inactive: try reinstalling driver (Factory Reset option), confirm FSR 3 is selected in-game (driver auto-upgrades FSR 3.x to 4.1 only if game requests FSR)
   - Overlay won't open: check Adrenalin → Settings → Preferences → Hotkeys
   - Profile not applying in-game: confirm EXE path matches (Adrenalin matches by exact EXE name)

## Traceability rule

Every setting MUST cite its decided-doc source. Format: at end of each setting's reason, add `(Domain 1, Per-Game Profile table)` or `(Domain 1, Global / Driver table)`.

## Do NOT include

- ❌ Anti-Lag 2 as ON (decided doc is explicit: OFF due to FSR 3.1.1 UE5 RHI plugin incompatibility)
- ❌ AFMF 2 as ON
- ❌ HYPR-RX as ON
- ❌ Any settings not in Domain 1
- ❌ Any "while you're at it" additions
- ❌ Placeholders like `{{YOUR_VALUE}}` — if uncertain on menu path naming in 26.3.1, note it as "(verify menu label in your UI)" rather than inventing

## Tone

Direct, decisive. Bulleted tables for settings. Prose only for context (reasoning paragraphs, troubleshooting). Markdown headers for sections. No preamble fluff.

## Length target

150-250 lines of markdown.
