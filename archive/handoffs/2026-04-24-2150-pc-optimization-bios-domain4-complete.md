# HANDOFF: Arc Raiders PC Optimization — Session Pause

**Recommended next-chat title:** `2026-04-24 — PC-OPTIMIZATION — Arc Raiders Finish (OSD/iCUE/InGame)`

**Generated:** 2026-04-22 (late night, Logan paused to resume later)
**Session status:** Paused mid-execution. Graphics ini deployed + Adrenalin per-game profile tuned. LG OSD, iCUE, in-game sliders still to do. BIOS + Sonar still explicitly deferred.

---

## TL;DR for receiving chat

Logan paused a multi-domain PC optimization build. Graphics ini (Domain 2) is deployed and read-only enforced. Adrenalin per-game profile (Domain 1) is tuned on the actual rig. **3 manual checklists remain** (OSD, iCUE, in-game sliders — total ~11 min of Logan's manual work). Adrenalin Global Settings pass also remains (~2 min). BIOS Domain 4 and Sonar Domain 5 are deferred separately.

Logan's frustration has shifted. He's called out that the last two chats have been mostly packaging, infrastructure, and me catching my own bugs — not a lot of durable new work beyond the ini deploy and Adrenalin profile. Receiving chat: **execute, don't narrate. Cut the walkthrough fat.** If he's at the rig and ready to do the remaining 13 min of manual work, hand him the tables and get out of the way.

---

## What's DONE (do not redo)

### Infrastructure (prior chat's handoff work)
- ✅ `Deploy-ArcRaidersConfig.ps1` built, parse-checked, wet-run tested (235 lines)
- ✅ 4 checklists written (Adrenalin, OSD, iCUE, InGame_Sliders)
- ✅ Master README.md with implementation order + revert + troubleshooting
- ✅ All 6 kit files committed to Claudious at commit `4e9de43` (split from prior sweep)
- ✅ 12 pre-existing artifacts separately committed at `543f2d3`
- ✅ Em-dash/encoding gotcha captured in `docs/learnings.md` at commit `66b021c`

### Executed on Logan's actual rig tonight
- ✅ `Deploy-ArcRaidersConfig.ps1` ran. 25 values written to `%LOCALAPPDATA%\PioneerGame\Saved\Config\WindowsClient\GameUserSettings.ini`. Read-only attribute set. Backup at `.bak-20260422-234523`. Verified with grep count = 25.
- ✅ Adrenalin per-game profile for Arc Raiders (PioneerGame.exe) tuned. 7 settings corrected via live screenshot reconciliation:
  - Gaming Experience: HYPR-RX → Default → Custom (auto, expected)
  - Radeon Anti-Lag: On → **Off**
  - Radeon Image Sharpening 2: Off → **On, 60%**
  - AMD FSR Upscaling: (briefly off by accident) → **On** (verified)
  - Wait for Vertical Refresh: "Off, unless application specifies" → **Always Off**
  - Surface Format Optimization: Off → **On**
  - Texture Filtering Quality: Performance → **Standard**
- ✅ Advanced tab reviewed — Anti-Aliasing stays "Use application settings", AA Method stays Supersampling (inert because AA is deferred to game), Anisotropic Filtering stays Enabled at 16x (intentionally overrode my checklist's "off" recommendation after pressure-testing)

### Batch A (from much earlier chat — still intact)
- ✅ 25 Windows system tweaks applied via `Optimize-ArcRaiders.ps1` (569 lines)
- ✅ Post-reboot verify: OK 26 / WARN 3 / FAIL 1 (FAIL is VBS still running — requires SVM off in BIOS, deferred to Domain 4)

---

## What's PENDING for the next session

### 1. Adrenalin Global Settings pass (~2 min, Logan at rig)
Navigate: `Gaming > Graphics` (no game selected). Verify these match:
| Global Setting | Target |
|---|---|
| Gaming Experience (if shown) | Default |
| Radeon Anti-Lag | Off |
| AMD Fluid Motion Frames | Off |
| Radeon Chill | Off |
| Radeon Boost (if shown) | Off |
| Radeon Enhanced Sync | Off |
| Wait for Vertical Refresh | Always Off |

### 2. Frame Rate Target check (~30 sec)
Scroll down in the Arc Raiders per-game profile below OpenGL Triple Buffering. If **Frame Rate Target Control** setting is exposed, set to **237 fps** (240Hz - 3 for FreeSync headroom). If not present in this Adrenalin version, skip — AMD has pruned this setting in some recent builds.

### 3. LG UltraGear OSD config (~3 min)
Logan's rig uses the joystick button under the center of the monitor bezel. Work `OSD_Checklist.md` tables. Key values:
- Picture Mode: Gamer 1
- Response Time: **Fast** (NOT Faster — inverse-ghosting)
- Black Stabilizer: 70
- Adaptive-Sync: On, DAS: On
- Uniform Brightness: On (critical for competitive — kills OLED ABL flicker)

### 4. iCUE controller profile (~5 min)
Scuf Envision Pro via iCUE (NOT Scuf G-App — decided doc says G-App but actual software is iCUE; flag this to Logan). Create `ArcRaiders` profile. Key values:
- Stick curves: Linear both
- Deadzones: **0% / 0%** in iCUE (deadzones happen in-game ONLY per decided doc Domain 7)
- Triggers: Instant Trigger mode via physical toggle
- Paddles P1-P4: Jump / Crouch / Reload / Interact
- Save to onboard Slot 1
- Export `.cueprofile` to `C:\Users\logan\Projects\Claudious\projects\pc-optimization\arcraiders\` for backup

### 5. Launch Arc Raiders → in-game sliders (~3 min)
Work `InGame_Sliders_Checklist.md`. Graphics tab is locked (ini is read-only) — skip it entirely. Key areas:
- Audio mix: Master 70, Music 10, SFX 100, Voice 60, VoiceChat 80, UI 50, FootstepsEmphasis Max
- Controller sensitivity, ADS multiplier 1.0, scope multiplier 0.80
- FOV: max available
- Deadzones in-game: 8-10% inner, tune lower if Envision Pro sticks don't drift
- Aim assist: On, default/100%

### 6. Post-session
- If Logan wants to add the `Frame Rate Target = 237` change to the decided doc and checklist, draft a diff
- If the manual checklists revealed any missing values (I know the decided doc has specifics I don't have visibility into), capture what came up

---

## Deferred (do NOT touch in next chat)

- **Domain 4 — BIOS session.** Separate dedicated session. Logan explicitly defers. Covers SVM off (kills VBS/FAIL 1), EXPO enable, SoC 1.10V cap, PBO2 -10 CO, Re-Size BAR.
- **Domain 5 — Sonar EQ.** Manual, 3 min, Logan does it whenever. Do NOT propose audio automation, Equalizer APO, or Sonar API integration.

---

## Frustration signals from THIS chat (do not repeat)

1. **Logan called out the session's low signal-to-noise ratio.** He asked "what have we accomplished the last 2 chats that wasn't already done" — fair challenge. Answer was: the ini deploy, the Adrenalin profile, the encoding bug fix, git/learnings infrastructure. Everything else was packaging or me correcting my own output.
   - **Lesson:** receiving chat should minimize packaging, skip the walkthrough fat, and go straight to execution. If Logan reads docs himself, the checklists are redundant — give him the tables, not the narration.

2. **I flip-flopped on 3 Adrenalin settings** after Logan pushed back with screenshots. The pattern: I transcribed the decided-doc / checklist values without pressure-testing them. When he challenged, I correctly reversed.
   - **Lesson:** pressure-test checklist values against actual reasoning before shipping. Specifically caught:
     - Anisotropic Filtering: checklist said "off." Real answer: 16x forced is ~free perf cost on RX 9070 XT and guarantees quality post-FSR.
     - AA Method: checklist said "change to Multisampling." Real answer: inert because AA row is "Use application settings" — either value is fine.
     - Binary name: checklist said `ArcRaiders-Win64-Shipping.exe`. Real .exe is `PioneerGame.exe` (Pioneer = Embark internal codename, matches the LOCALAPPDATA config path we've been using). Should have caught this earlier.

3. **Logan correctly objected to an encoding-diagnosis mistake.** I initially blamed LF vs CRLF line endings. CC correctly identified em-dash + UTF-8-no-BOM as the actual root cause. I propagated that learning to docs/learnings.md.
   - **Lesson:** encoded in 66b021c. Future PS1 generation on Linux → Windows deploy: ASCII-only comments, OR write with UTF-8 BOM + CRLF via byte-level rewrite.

4. **Ryzen Master hung mid-session.** Unrelated to tuning work. Recommended closing it and disabling from startup — conflicts with the 3D V-Cache Optimizer CCD0 steering that Batch A configured. Do not use Ryzen Master for monitoring going forward; HWiNFO64 or Task Manager instead.

---

## Decisions made with reasoning (forward-looking context)

- **Keep AF Enabled at 16x (override checklist).** Modern drivers don't double-process; perf cost on 9070 XT is <0.5%; improves competitive visibility on oblique surfaces post-FSR. 80% confidence. Conditions I'd be wrong: UE5 Arc Raiders explicitly overrides driver AF (uncommon), or FSR 4 has a specific AF interaction (unlikely).

- **Keep Anti-Lag Off (standard position).** The decided-doc reasoning (EAC compat) may be over-cautious on current driver builds. But asymmetric risk — "probably safe" vs. account ban — favors Off. 70% confidence. Logan can revisit after 10-20 hours of play if he wants to test Anti-Lag Standard in a session.

- **Kit commit split into 6-file kit (4e9de43) + 12-file prior-artifacts (543f2d3) instead of one 18-file sweep.** Cleaner history. Force-with-lease push was safe (most recent commit only). Accepted the small commit-hygiene issue on 66b021c (canonical/handoff-active-mastery.md swept into the learning commit) per Logan's call to not split further.

- **SSAA dropdown inert, not harmful.** When AA = "Use application settings," AA Method value doesn't matter. Logan asked about this directly — confirmed zero perf impact.

---

## Files recently changed (git SHAs)

| SHA | Files | Purpose |
|---|---|---|
| `840cd05` | prior — not this session | Prior canonical state |
| `e3a6359` | prior — not this session | Prior canonical state |
| `4e9de43` | 6 kit files | Arc Raiders morning deploy kit |
| `543f2d3` | 12 artifacts | Prior session briefs/walkthroughs/decided-settings |
| `66b021c` | docs/learnings.md + canonical/handoff-active-mastery.md | Em-dash encoding learning + incidental handoff file sweep |
| TBD this handoff | canonical/handoff-active.md (new entry) + archive of prior active | This handoff doc |

---

## Unresolved questions

1. **Should the `Adrenalin_Checklist.md` be rewritten with the three corrections?** (binary name, AF recommendation, AA Method clarification) — Logan accepted "fix at session end" but we paused before session end. Receiving chat: draft a CC prompt to patch the checklist inline, stage + commit.

2. **Is Frame Rate Target Control exposed in Logan's Adrenalin version?** Unknown — need to verify visually. If yes: set 237. If no: skip. Doesn't block anything.

3. **Does the decided doc have specific numeric values for in-game sliders?** My `InGame_Sliders_Checklist.md` has reasonable competitive defaults (Master 70, Music 10, etc.) but these are my competitive-shooter conventional wisdom, not pulled from the actual Domain 2 audio block. Receiving chat: if the decided doc is referenceable, cross-check before Logan runs the in-game checklist.

---

## User Preferences changes pending

None from this session.

---

## Context room status at handoff
- Approx. 60% used
- Many screenshots processed, some long tool responses
- Recommend fresh chat for next session (finishing work will be ~30-45 min more dialog)

---

## THE PROMPT TO PASTE IN NEXT CHAT

Everything above is context. Logan pastes this verbatim:

---

### PROMPT FOR NEXT CHAT

> Continuation of Arc Raiders PC optimization. I paused mid-session. Read `canonical/handoff-active.md` for full context — do NOT ask me to re-explain.
>
> **What's done:** Graphics ini deployed and verified (25/25 values written, read-only). Adrenalin per-game profile tuned on my rig (7 settings corrected).
>
> **What's left, in order:**
> 1. Adrenalin Global Settings pass (~2 min). I'll share a screenshot.
> 2. Frame Rate Target 237 in per-game profile if setting exists (~30 sec).
> 3. LG UltraGear OSD config via joystick (~3 min). Use `OSD_Checklist.md` values.
> 4. iCUE Scuf Envision Pro profile (~5 min). Use `iCUE_Checklist.md` values.
> 5. Launch Arc Raiders → in-game sliders (~3 min). Use `InGame_Sliders_Checklist.md` values, skip graphics tab (ini is locked).
>
> **Deferred (do NOT touch):** BIOS Domain 4, Sonar EQ Domain 5.
>
> **Rules:**
> - Skip the walkthrough narration. Hand me tables.
> - Pressure-test values before recommending them. I'll push back with screenshots if something's wrong.
> - If the `Adrenalin_Checklist.md` still has the 3 errors (binary name, AF off, AA Method), draft a CC prompt at end-of-session to patch + commit.
> - When we're done, draft a new handoff to `canonical/handoff-active.md` summarizing the finish.
>
> Start by asking me what state I'm in (at the rig, or away). Go.

---

## END HANDOFF
