# Adrenalin Checklist — Arc Raiders Profile

**Source:** `ArcRaiders_Decided_Settings.md` Domain 1 (Adrenalin / Driver Settings)
**App:** AMD Software: Adrenalin Edition (installed with RX 9070 XT drivers)
**Time:** ~5 min

---

## Global Settings (applies to everything, not just Arc Raiders)

Menu path: `Gaming > Graphics` (top-level, NOT inside a game profile)

| Setting | Value | Domain |
|---|---|---|
| Radeon Anti-Lag | **Off** | Domain 1 |
| AMD Fluid Motion Frames (AFMF) | **Off** | Domain 1 |
| HYPR-RX | **Off** | Domain 1 |
| Radeon Boost | **Off** | Domain 1 |
| Radeon Chill | **Off** | Domain 1 |
| Radeon Enhanced Sync | **Off** | Domain 1 |
| Wait for Vertical Refresh | **Always Off** | Domain 1 |

**Why all off globally:** every one of these injects frame pacing behavior, frame generation, or latency variability that conflicts with the competitive tuning stack. Anti-Lag specifically can trip anti-cheat on some UE5 titles — not worth the risk.

---

## Per-Game Profile: Arc Raiders

Menu path: `Gaming > Games` → if Arc Raiders not listed, click `Add A Game` → select `ArcRaiders-Win64-Shipping.exe` (in Steam install dir). Then click the Arc Raiders tile to open its profile.

### Graphics tab

| Setting | Value | Domain |
|---|---|---|
| FSR 4 Upgrade | **On** | Domain 1 |
| FSR Quality Mode | **Quality** (per decided doc — upscale from ~67%) | Domain 1 |
| Radeon Image Sharpening (RIS) | **On, 60%** | Domain 1 |
| Anti-Lag | **Off** (already off globally — confirm) | Domain 1 |
| Radeon Boost | **Off** | Domain 1 |
| Radeon Chill | **Off** | Domain 1 |
| Radeon Enhanced Sync | **Off** | Domain 1 |
| Wait for Vertical Refresh | **Always Off** | Domain 1 |
| Frame Rate Target Control | **Disabled** | Domain 1 |

### Advanced (scroll down in Graphics tab)

| Setting | Value | Domain |
|---|---|---|
| Anti-Aliasing Mode | **Use application settings** | Domain 1 |
| Anti-Aliasing Method | **Multisampling** (if exposed; otherwise leave default) | Domain 1 |
| Morphological Anti-Aliasing | **Off** | Domain 1 |
| Anisotropic Filtering Mode | **Use application settings** | Domain 1 |
| Texture Filtering Quality | **Standard** | Domain 1 |
| Surface Format Optimization | **On** | Domain 1 |
| Tessellation Mode | **AMD Optimized** | Domain 1 |
| OpenGL Triple Buffering | **Off** | Domain 1 |
| Shader Cache | **AMD Optimized** | Domain 1 |
| AMD Fluid Motion Frames | **Off** | Domain 1 |
| Frame Pacing | **Default / system controlled** | Domain 1 |

---

## Verify

1. Close Adrenalin.
2. Reopen → `Gaming > Games > Arc Raiders`. Confirm all values above persist.
3. Confirm NO HYPR-RX badge visible anywhere on the Arc Raiders tile.

## Notes

- **RIS at 60%** is the cap — above that you get oversharpen halos on foliage edges. Decided doc Domain 1 sets the ceiling.
- **FSR 4 Upgrade ON + Quality mode** is the decided render pipeline. Do NOT stack additional driver upscalers.
- If Adrenalin auto-enables HYPR-RX after a driver update, it will override Anti-Lag/Boost/AFMF settings. Re-verify the Global tab after any driver update.
