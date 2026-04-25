# HANDOFF: 2026-04-24 — PC-OPTIMIZATION — Domain 4 BIOS Complete, VBS Stuck Running

**Recommended next-chat title:** `2026-04-25 — PC-OPTIMIZATION — VBS Kill (25H2 Auto Device Encryption)`

**Generated:** 2026-04-24 ~21:50 CDT
**Session status:** Domain 4 BIOS pass executed and saved successfully on Logan's actual rig. All 11 BIOS changes committed cleanly. VBS post-BIOS verification is FAILING — `msinfo32` still reports `Virtualization-based security: Running` despite Memory Integrity Off in Windows Security GUI, three registry/bcdedit overrides applied, and three reboots. Logan is frustrated that VBS won't die. Receiving chat: solve the 25H2 VBS lock, do not re-do BIOS work.

---

## TL;DR for receiving chat

Logan's BIOS pass for Arc Raiders is done. Don't touch BIOS. The remaining problem is purely Windows-side: **Windows 11 Pro 25H2 build 26200 is keeping VBS Running despite multiple kill attempts.** Logan kept SVM Enabled in BIOS (per audit decision — preserves Docker Desktop / WSL2 for his full-stack dev work), so VBS must be killed at the OS layer. So far: GUI toggle Off, registry DeviceGuard EnableVirtualizationBasedSecurity=0, registry Lsa LsaCfgFlags=0, attempted `bcdedit /set hypervisorlaunchtype off`. None worked. The likely culprit is **Automatic Device Encryption** auto-re-enabling VBS on every boot (25H2 behavior). Receiving chat: walk Logan through identifying and disabling whatever is force-re-enabling VBS, then verify VBS = Not enabled, then resume verification protocol (CCD0 preferred-cores check + HWiNFO sensor check).

---

## Hardware lock (do not reinterpret — already verified by msinfo32)

- CPU: AMD Ryzen 9 9950X3D 16C/32T
- Mobo: ASUS ROG Strix B850-F Gaming WiFi
- BIOS: AMI 2.22.1284, version 0401, dated 9/6/2024 (1644 flash deferred — DO NOT propose flash unless Logan invokes)
- RAM: 64GB Corsair CMH64GX5M2B6000C30 (2x32GB DDR5-6000 CL30, Hynix A-die)
- GPU: GIGABYTE RX 9070 XT GAMING OC 16G on Adrenalin 26.3.1 WHQL
- Storage: WD_BLACK SN850X 4TB
- OS: Windows 11 Pro 25H2 (Build 26200)
- Display: LG UltraGear 34GS95QE 240Hz WOLED, DisplayPort, FreeSync Premium Pro
- Controller: Scuf Envision Pro (iCUE-managed), wired
- Game binary: `C:\Program Files (x86)\Steam\steamapps\common\Arc Raiders\PioneerGame\Binaries\Win64\PioneerGame.exe`
- BitLocker: Only on external drive D:, system C: not encrypted (per Logan's session-start brief)
- Secure Boot State: On
- Kernel DMA Protection: Off
- Automatic Device Encryption Status: **Elevation Required to View** ← THIS IS THE SUSPECTED CULPRIT

---

## What's DONE on this rig (do NOT redo, do NOT re-execute)

### BIOS changes saved at session-end commit (all 11 confirmed in Save Changes & Reset summary screen):

| # | Setting | From → To |
|---|---|---|
| 1 | Precision Boost Overdrive | Auto → Manual |
| 2 | Precision Boost Overdrive Scalar | Auto → Manual |
| 3 | Customized Precision Boost Overdrive Scalar | 2x → 1x |
| 4 | CPU Boost Clock Override | Auto → Disabled |
| 5 | Curve Optimizer | Auto → All Cores |
| 6 | All Core Curve Optimizer Sign | Positive → Negative |
| 7 | All Core Curve Optimizer Magnitude | 0 → 10 |
| 8 | CPU SOC Voltage | Auto → Manual Mode |
| 9 | VDDSOC Voltage Override | Auto → 1.15000V |
| 10 | Global C-state Control | Auto → Enabled |
| 11 | CPPC Dynamic Preferred Cores | Auto → Driver |

PPT/TDC/EDC limits left at Auto (intentional, per safe-across-silicon plan).
SVM Mode: **NOT changed, stays Enabled** (per GPT-5.5 audit recommendation — preserves Docker Desktop + WSL2).
Above 4G Decoding + Resize BAR Support: verified Enabled (no changes needed).

System POSTed cleanly after F10 Save & Exit. Cold boot worked. Display lost handshake briefly mid-reboot causing a hard-power, which triggered Windows Recovery → "Diagnosing your PC" → "couldn't be repaired" (only because online repair couldn't reach network — benign). Recovery → Continue → Windows desktop loaded normally. **BIOS is fine. System is stable.**

### Windows-side commands run before this handoff was requested:

```powershell
# Run 1 (per first attempt — operation completed)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f

# Run 2 (per first attempt — operation completed)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LsaCfgFlags /t REG_DWORD /d 0 /f

# Run 3 (FAILED — PowerShell parsed {current} as encodedCommand)
bcdedit /enum {current}
# Returned: "Invalid command line switch: /encodedCommand"
# Should be: bcdedit /enum '{current}'  (single quotes)
# OR run from cmd.exe instead of PowerShell where the braces parse cleanly.
```

Memory Integrity confirmed Off via Windows Security GUI before reg commands.
Reboot completed after reg commands.
Post-reboot msinfo32 still shows: **Virtualization-based security: Running**
A hypervisor has been detected: present
Virtualization-based security Av...: Base Virtualization Support, Secure Boot, DMA Protection, UEFI Code Readonly...

---

## What's NOT done (in priority order for next chat)

### 1. KILL VBS — primary blocker

Receiving chat must solve this BEFORE any other verification work. The chain to walk:

**Step A — Confirm whether bcdedit ever set hypervisorlaunchtype to Off:**
- Open **cmd.exe as Administrator** (not PowerShell — the brace parsing is cleaner)
- Run: `bcdedit /enum {current}`
- Look for `hypervisorlaunchtype` line. Logan never confirmed this was set to Off — first attempt failed because `bcdedit /set hypervisorlaunchtype off` was buried in advice but the actual /enum verification got eaten by PowerShell brace parsing. We do not know whether the `/set` ever ran successfully.
- If `hypervisorlaunchtype` reads `Auto` or is missing: run `bcdedit /set hypervisorlaunchtype off` from elevated cmd.exe → verify success message → reboot → recheck msinfo32.

**Step B — If Step A doesn't kill it, identify what's force-re-enabling VBS:**
- 25H2 + 9950X3D + ASUS B850-F + clean Microsoft account login = high probability **Automatic Device Encryption** is on.
- Settings → Privacy & Security → Device encryption → check status. If "Device encryption" toggle is ON, it's actively encrypting C: in the background which requires VBS, and Windows will refuse to disable VBS while AutoDE is provisioning or active.
- Logan's Aut. Device Encryption Status row in msinfo32 = "Elevation Required to View" (suggests it's active, not just available).
- Logan stated at session start: "BitLocker: only an external drive (D:) — system drive C: not encrypted, no recovery key needed for BIOS work." But 25H2 may have enabled AutoDE silently after install regardless. Verify with `manage-bde -status C:` from elevated cmd.

**Step C — Check Group Policy / DeviceGuard configured override:**
- Run `gpresult /h c:\gpreport.html` then open the report. Look for any "Turn On Virtualization Based Security" policy from local GPO or domain.
- Or check directly: `reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"` — any keys here with EnableVirtualizationBasedSecurity=1 will override the CurrentControlSet key Logan set.

**Step D — Smart App Control / Reputation-based protection:**
- 25H2 ties Smart App Control to VBS. If Smart App Control is "On" or "Evaluation," VBS cannot be disabled via standard means.
- Settings → Privacy & Security → Windows Security → App & browser control → Smart App Control settings → if On or Evaluation → set Off (note: Off is permanent, cannot re-enable without Windows reinstall, so this is a real decision Logan should make consciously).

**Step E — Last resort options if A-D all fail:**
- **Option 1 (recommended fallback):** Accept VBS Running. The 5-14% FPS hit number from older benchmarks is likely 2-6% on RDNA 4 / 25H2 in UE5 titles. Move on to verification.
- **Option 2:** Disable Auto Device Encryption (requires decrypting C: first if active — non-trivial, can take 30+ min, requires recovery key backup before).
- **Option 3:** Go back to BIOS and disable SVM. Kills VBS at firmware. Trade: WSL2 + Docker Desktop break. Logan rejected this earlier per GPT audit. Don't propose unless A-D fail and Logan accepts the dev-environment hit.

### 2. Verify CPPC=Driver actually steered preferred cores to CCD0
- Task Manager → Performance → CPU → right-click graph → Change to → Logical processors
- Idle activity should weight on cores 0–7 (CCD0, V-Cache CCD)
- Bonus: Ryzen Master Home tab — gold stars should be on cores 0–7 (NOT cores 8/12 like the pre-BIOS baseline)
- If gold stars still on CCD1: AMD 3D V-Cache Performance Optimizer service may need a kick. `services.msc` → find AMD 3D V-Cache Performance Optimizer → Restart.

### 3. Verify HWiNFO sensors
Logan should run HWiNFO64 in Sensors-only mode and confirm:
- VDDCR_SoC under load: should be ≤1.18V (was 1.288V auto pre-BIOS)
- CPU Vcore at idle: should be ~1.0-1.05V (was 1.287V from Scalar 10X effect)
- Memory Clock: 3000 MHz
- UCLK: 3000 MHz (1:1 with memory — critical, Zen 5 IMC running 1:1 confirms SoC undervolt didn't break IMC stability)
- WHEA Errors: 0 after 30 min of normal use

### 4. 30-min Arc Raiders gameplay test
- Load into a raid (or two — Logan's flow is "one raid no expectations, two raids tune FOV/sens, five raids lock")
- Watch HWiNFO during gameplay for WHEA increments, frame stutters, hitching
- Check Event Viewer → System log after — look for any WHEA-Logger source events. Zero is target.

### 5. Then resume the paused-chat checklist work (still left from prior session)
- LG OSD config (~3 min, OSD_Checklist.md)
- iCUE Scuf Envision Pro profile (~5 min, iCUE_Checklist.md)
- In-game graphics sliders (~3 min, InGame_Sliders_Checklist.md, skip graphics tab — ini is locked)
- Adrenalin Global Settings pass (~2 min)
- Frame Rate Target 237 in per-game profile (~30 sec)

---

## Pending checklist corrections to commit (still unwritten as of this handoff)

`projects/pc-optimization/arcraiders/Adrenalin_Checklist.md` needs three patches:
1. Binary name: change `ArcRaiders-Win64-Shipping.exe` → `PioneerGame.exe` at correct Steam path
2. Anisotropic Filtering: change "off" → "Enabled, 16x driver-forced" (<0.5% perf cost on RX 9070 XT)
3. AA Method row: add note "inert when AA = Use application settings — Supersampling or Multisampling both fine, no perf delta"

Receiving chat at session-end: draft Claude Code prompt to patch these + commit with rationale message.

---

## Decisions made this session (for context)

1. **VDDSOC = 1.15V instead of 1.10V** (audit-driven). GPT-5.5 audit pushed for 1.20V; Claude pushed back at 1.15V as the right safe-across-silicon point per Hynix A-die canonical doc. Currently committed at 1.15V. If 1.15V WHEAs in 30 min gameplay, walk to 1.18V first before going higher.

2. **CO All-Core -10 held** despite GPT-5.5 audit suggesting -5 first. Rationale: -5 captures only ~50% of the boost/thermal benefit; -10 is the AMD-community safe-across-silicon line; failure mode is benign (Arc Raiders crash within first hour → dial back to -5). Logan accepted the ~15-20% probability of weak-silicon walk-back.

3. **PBO Scalar = Manual 1X (not Disabled).** ASUS BIOS dropdown only exposed Auto / Manual on the Scalar field — "Disabled" was described in help text but not selectable. Manual + value 1 produces same 1X behavior.

4. **PBO mode = Manual (not "Advanced").** ASUS uses "Manual" terminology where AGESA reference uses "Advanced." Same behavior — exposes PPT/TDC/EDC limit fields below.

5. **CPPC Dynamic Preferred Cores = Driver (not Cache, not Frequency).** Driver hands authority to AMD 3D V-Cache Performance Optimizer service which is game-aware. Cache forces CCD0 always (hurts non-gaming workloads). Frequency forces CCD1 (wrong CCD for X3D gaming).

6. **SVM stays Enabled, kill VBS via Windows.** Per GPT-5.5 audit. Preserves Docker Desktop / WSL2. Trade is the current pain point — Windows 25H2 isn't cooperating.

7. **BIOS 0401 not flashed to 1644.** Project-locked deferred decision. CPPC=Driver works on 0401 per canonical doc.

8. **Skip stress testing, validate via gameplay + WHEA monitoring.** Per Logan's session-start constraint.

---

## Frustration signals (do not repeat in next chat)

- Logan called out that VBS is the single point of failure and asked for handoff explicitly: "you can't seem to fix this." Receiving chat: do NOT propose another speculative reg key without first running diagnostics (gpresult, manage-bde -status, bcdedit /enum from cmd.exe). One concrete diagnostic per turn, not three speculative writes.
- Logan was clear earlier: bullets, no walkthrough narration, one BIOS page at a time, terminology that matches what's on screen. Apply the same to Windows-side work — don't suggest "navigate to Settings → Privacy → ..." without confirming the path is current for 25H2 (Microsoft moves these around).
- Earlier in session: Claude used wrong terminology ("Advanced" for PBO mode when ASUS exposes "Manual"). Logan corrected. Receiving chat: when uncertain about exact 25H2 menu names, ask Logan to send a screenshot of the current screen rather than guess.
- Earlier in session: Logan can't take screenshots while doing PC work — uses phone pics of monitor. Receiving chat: same rule.
- Logan rejected a `bcdedit` block written with `{current}` un-escaped. PowerShell ate the braces. Use elevated cmd.exe for bcdedit going forward, or escape with single quotes in PowerShell.

---

## Files / commits state (current canonical)

- `4e9de43`: 6-file kit (Deploy-ArcRaidersConfig.ps1, 4 checklists, README.md)
- `543f2d3`: 12 prior artifacts (briefs/walkthroughs/decided-settings)
- `66b021c`: docs/learnings.md em-dash encoding gotcha
- Graphics ini: 25 values written to `%LOCALAPPDATA%\PioneerGame\Saved\Config\WindowsClient\GameUserSettings.ini`, read-only, backup `.bak-20260422-234523`
- Adrenalin per-game profile: 7 settings corrected live (prior session)
- BIOS: all 11 changes from this session committed via F10 Save & Exit, system stable post-reboot

No new files committed this session. Adrenalin_Checklist.md corrections still pending.

---

## User Preferences changes surfaced this session (defer to Mastery Lab)

- None this session. Logan's existing preferences for confidence-stating, terminology-on-screen, one-step-at-a-time all worked well. No drift requested.

---

## Quick-paste opener for receiving chat

> I paused mid-session. Read `canonical/handoff-active.md` for full context — do NOT ask me to re-explain.
>
> **What's done:** All 11 BIOS changes committed and saved. System POSTs cleanly. Windows desktop loads. Memory Integrity Off. Two reg key overrides applied. VBS still shows Running in msinfo32 after 3 reboots.
>
> **The blocker:** Windows 11 Pro 25H2 (build 26200) is force-re-enabling VBS. Likely culprit is Automatic Device Encryption per AutoDE row showing "Elevation Required to View" in msinfo32, but this is unconfirmed.
>
> **Start here:** Walk me through diagnostics in this order — bcdedit verification from cmd.exe (not PowerShell), then `manage-bde -status C:`, then check `HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard`, then Smart App Control state. ONE diagnostic per turn. I'll run + send output. Don't write speculative fix-blocks.
>
> **Hardware lock unchanged:** 9950X3D / B850-F BIOS 0401 / 64GB DDR5-6000 / RX 9070 XT / SN850X 4TB / 25H2 Pro. Already-completed BIOS changes are in the handoff — don't re-do them.
>
> **Rules:**
> - Bullets, no walkthrough narration
> - Terminology that matches what's on screen
> - When uncertain about 25H2 menu paths, ask for a screenshot
> - Use elevated cmd.exe for bcdedit, not PowerShell
>
> Start with the bcdedit /enum verification step. Go.

---

## END HANDOFF
