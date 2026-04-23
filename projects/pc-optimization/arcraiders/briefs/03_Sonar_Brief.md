# Brief — Sonar Walkthrough (Domain 5)

**Output file:** `Sonar_Walkthrough.md`
**Source domain:** ArcRaiders_Decided_Settings.md Domain 5 (lines 370-455 of the decided doc)
**Target user:** Logan. Arctis Nova Pro headset via SteelSeries GG / Sonar.

## Context

Phase 0 research confirmed SteelSeries Sonar has no hand-authorable preset file — supported import path is a URL share link from an already-configured GG install. Therefore this walkthrough is the deliverable for Domain 5.

Ends with Logan configuring once and using Sonar's built-in "Share" button to generate a portable URL for backup / second-rig re-application.

## Required sections, in order

1. **Pre-setup**
   - Confirm SteelSeries GG is installed and up to date (Arctis Nova Pro detected)
   - Confirm Arctis Nova Pro is the physical audio device (USB or GameDAC connected)
   - Open GG → Sonar tab

2. **Routing setup** (Sonar → Mixer / Routing tab)
   Every row of Domain 5's Routing table. Critical order: routing FIRST, EQ LAST.
   - Sonar main output → Arctis Nova Pro (GameDAC)
   - Game channel → Arc Raiders output
   - Chat channel → Discord/voice app output
   - Streamer routing: Media → default, Game → Arctis Nova Pro

   After routing is set: the in-game "Output Device = Sonar Virtual Playback (Game)" setting from Domain 2 is what makes this work. Cross-reference the in-game walkthrough.

   Verification: During a raid, open Windows Sound Mixer. Arc Raiders audio should show activity on Sonar Game playback device, NOT on Arctis directly. If bypassing: routing is misconfigured.

3. **Spatial + Processing settings** (Sonar → Game channel)
   Every row of Domain 5's Spatial + Processing table:
   - Sonar Spatial Audio = **OFF** (Arc Raiders has native UE5 HRTF; double-HRTF corrupts imaging)
   - Smart Volume (compressor) = **OFF**
   - AI Voice Clarity = ON (mic only, suppresses fan/ambient)
   - Sidetone = Low 20-30%
   - ANC = On during gaming
   - Mic Noise Gate = Low threshold

   Include the "One compressor max rule" callout — don't double-process audio.

4. **Night Mode decision** — critical, single-section explanation
   Decided doc Domain 5: **Night Mode OFF** when running the custom EQ.
   Reasoning (from decided doc): Night Mode compresses dynamic range, flattening distance cues. Custom EQ does the footstep boost transparently without compression.
   Alternative: If Logan skips the custom EQ entirely → flip Night Mode ON as the simpler path.
   Reverse if: A/B in Practice Range shows Night Mode ON + EQ produces clearer long-range footsteps for Logan's specific hearing.

5. **Custom EQ — Arc Raiders footstep preset** (Sonar → Game channel → Equalizer)
   This is THE critical section. 10-band parametric EQ from Domain 5.

   Present as a table the user reads band-by-band:

   | Band | Frequency | Gain | Q | Purpose |
   |------|-----------|------|---|---------|
   | 1 | 60 Hz | -4 dB | 1.0 | Sub rumble — ARC Machine low-end mask |
   | 2 | 120 Hz | -3 dB | 1.2 | Explosion low-mid mask |
   | 3 | 250 Hz | -2 dB | 1.0 | Explosion upper-low gentle cut |
   | 4 | 500 Hz | 0 dB | — | Neutral |
   | 5 | 1000 Hz | +1 dB | 1.0 | Early footstep presence |
   | 6 | 1500 Hz | **+3 dB** | 1.2 | Footstep presence — primary |
   | 7 | 2500 Hz | **+4 dB** | 1.0 | Footstep transient clarity |
   | 8 | 4000 Hz | **+3 dB** | 1.0 | Surface texture / reload detail |
   | 9 | 6500 Hz | +1 dB | 1.5 | Distance cues |
   | 10 | 10000 Hz | 0 dB | 1.0 | Keep clean, avoid harshness |

   Explicit step-by-step: open Game channel → EQ → switch to parametric/10-band mode → enter each band's Frequency/Gain/Q by clicking the band and typing values.

   NOTE: If Sonar's EQ is fixed-Q graphic (not parametric), document this as a limitation and suggest the closest-achievable approximation. Flag for Logan to check.

6. **Save + Share the preset**
   - Save the configured Game channel preset with a name: `ArcRaiders_Footsteps`
   - Click the "Share" button on the preset → Sonar generates a URL
   - Copy the URL and save it in: `C:\Users\logan\ArcRaiders-Configs\sonar-preset-url.txt`
   - Future use: clicking the URL in any browser with GG installed auto-imports the preset

7. **Mic settings** (Sonar → Mic channel)
   Quick section. Every row of Domain 5's Mic table:
   - Mic Volume = 70%
   - Mic EQ = Mid-range boost preset (voice clarity)
   - AI Voice Clarity = On
   - Noise Gate = Low threshold (-50 to -45 dB)
   - Sidetone = 20-30%

8. **Mix Ratios** (Sonar → Mixer)
   - Game = 100%
   - Chat = 70%
   - Media = 40%
   - Aux = Off

9. **Verification**
   - Spawn Arc Raiders Practice Range
   - Stand still, have bot walk at 15-20m distance
   - Confirm footsteps audible, directional, and clearly distinct from ambient
   - If 2.5 kHz feels too sharp: drop +4 → +3 dB per decided doc tuning note
   - If footsteps feel distant: add +1 dB at 1500 Hz

## Traceability rule

Every setting cites `(Domain 5, Routing)` / `(Domain 5, Spatial + Processing)` / `(Domain 5, Game EQ)` / `(Domain 5, Mic)` / `(Domain 5, Mix Ratios)`.

## Do NOT include

- ❌ Night Mode ON (decided position is OFF with custom EQ)
- ❌ Sonar Spatial Audio ON (double-HRTF violation)
- ❌ dovesonic's preset URL (decided doc mentions it as alternative; walkthrough implements the synthesized 10-band)
- ❌ Any suggestion to bypass Sonar and output directly to Arctis (routing requirement)

## Tone

Technical precision for the EQ table. Conversational for the routing/verification sections. Logan is intermediate-advanced on audio.

## Length target

200-350 lines.
