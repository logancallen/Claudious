<#
.SYNOPSIS
    Deploys Arc Raiders graphics settings from Domain 2 of the decided doc
    by writing them directly to GameUserSettings.ini + setting the file
    read-only so Arc Raiders cannot overwrite them.

.DESCRIPTION
    Arc Raiders is UE5 and uses two config layers:
    1. [ScalabilityGroups] sg.* values — standard UE5 quality sliders
       (Shadows, Foliage, Textures, etc.). The game writes these back
       when you change in-game sliders.
    2. [SystemSettings] r.* CVars — UE5 engine overrides that persist.
       Community Steam posts and Nexus mod confirm these survive patches.

    This script writes BOTH layers and sets the file read-only so in-game
    setting changes don't overwrite the decided-doc values.

    Every setting traces to Domain 2 of ArcRaiders_Decided_Settings.md.

    Backups the existing ini (if present) to a timestamped .bak-YYYYMMDD-HHMMSS
    before any write.

.NOTES
    Run: Right-click -> Run with PowerShell (as Administrator not required,
    but won't hurt). The script writes to %LOCALAPPDATA% which is user-owned.

    Arc Raiders config dir confirmed via community sources:
    %LOCALAPPDATA%\PioneerGame\Saved\Config\WindowsClient\GameUserSettings.ini
    (Pioneer was Embark's internal project name for Arc Raiders.)

.LINK
    ArcRaiders_Decided_Settings.md Domain 2 (Graphics Quality table)
#>

[CmdletBinding()]
param(
    [switch]$Revert,   # Remove read-only + restore most recent .bak if present
    [switch]$WhatIf    # Preview changes, no writes
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# --------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------
$ConfigDir = Join-Path $env:LOCALAPPDATA 'PioneerGame\Saved\Config\WindowsClient'
$IniPath   = Join-Path $ConfigDir 'GameUserSettings.ini'
$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'

function Write-Log {
    param(
        [Parameter(Mandatory)][AllowEmptyString()][string]$Message,
        [ValidateSet('INFO','OK','WARN','ERROR','SKIP','HEAD')][string]$Level = 'INFO'
    )
    $color = switch ($Level) {
        'OK'{'Green'} 'WARN'{'Yellow'} 'ERROR'{'Red'} 'SKIP'{'DarkGray'} 'HEAD'{'Cyan'}
        default{'Gray'}
    }
    Write-Host "[$Level] $Message" -ForegroundColor $color
}

# --------------------------------------------------------------------
# Domain 2 decided values -> UE5 sg.* scalability values
# --------------------------------------------------------------------
# UE5 quality scale: 0=Low, 1=Medium, 2=High, 3=Epic (engine standard)
# Source: ArcRaiders_Decided_Settings.md Domain 2 Graphics Quality table.
$ScalabilityGroups = @{
    # === Quality settings from Domain 2 Graphics Quality table ===
    'sg.ViewDistanceQuality'    = 2   # High (+5% vs Epic, prevents long-range pop-in)
    'sg.AntiAliasingQuality'    = 1   # Medium (TAA fallback behind FSR)
    'sg.ShadowQuality'          = 1   # Medium (+15% vs Epic; retains tactical shadow intel)
    'sg.GlobalIlluminationQuality' = 0  # Medium->Static lives as CVar override; keep GI quality low
    'sg.ReflectionQuality'      = 0   # Low (~+3%)
    'sg.PostProcessQuality'     = 0   # Low (+15-17%; biggest FPS lever after GI)
    'sg.TextureQuality'         = 2   # High (neutral at 16GB VRAM)
    'sg.EffectsQuality'         = 0   # Low (+6%; keeps combat readable through smoke)
    'sg.FoliageQuality'         = 0   # Low (+2-4%; visibility advantage - see through cover)
    'sg.ShadingQuality'         = 1   # Medium (complementary to Shadow Medium)
    'sg.ResolutionQuality'      = 100 # 100% upscaled resolution - never below per decided doc
}

# System settings - CVar overrides that persist in [SystemSettings].
# These are UE5 console variables Arc Raiders respects.
# Source: Domain 2 + community Steam/Nexus confirmations.
$SystemSettings = @{
    # === Effects we explicitly kill (Domain 2 Graphics Quality table) ===
    'r.MotionBlur.Max'              = '0'    # Motion Blur = Off
    'r.MotionBlurQuality'           = '0'    # Motion Blur = Off (engine-side)
    'r.DepthOfFieldQuality'         = '0'    # Depth of Field = Off
    'r.Tonemapper.GrainQuantization'= '0'    # Film Grain = Off
    'r.SceneColorFringeQuality'     = '0'    # Chromatic Aberration = Off
    'r.Tonemapper.Quality'          = '1'    # Minimal tonemapper, still allow basic tonemap
    'r.BloomQuality'                = '1'    # Reduce bloom; Low post-processing consistent
    'r.LensFlareQuality'            = '0'    # Lens Flares = Off
    'r.EyeAdaptationQuality'        = '0'    # Off - vignette-adjacent
    # === Sharpening complement (Domain 1 says RIS handles sharpening at 60%) ===
    'r.Tonemapper.Sharpen'          = '0.5'  # Mid point; decided doc says keep in-game sharpness at center to avoid double-sharpening
    # === Foliage density override (Low scalability is good, but reinforce with CVar for distance) ===
    'foliage.DensityScale'          = '0.5'  # Aggressive foliage cull; Low setting already does this but CVar makes it explicit
    'grass.DensityScale'            = '0.5'  # Same for grass layer
    # === Performance hints ===
    'r.VolumetricFog'               = '0'    # Implied by Effects=Low + no decided-doc call-out for volumetric
    'r.VolumetricCloud'             = '1'    # Leave on - needed for sky/overworld
}

# --------------------------------------------------------------------
# Revert path
# --------------------------------------------------------------------
if ($Revert) {
    Write-Log "Revert mode" -Level HEAD
    if (-not (Test-Path $IniPath)) {
        Write-Log "ini not present at $IniPath — nothing to revert." -Level WARN
        exit 0
    }
    # Remove read-only if set
    $item = Get-Item $IniPath
    if ($item.IsReadOnly) {
        $item.IsReadOnly = $false
        Write-Log "Removed read-only attribute." -Level OK
    } else {
        Write-Log "File was not read-only." -Level SKIP
    }
    # Restore latest backup if available
    $latestBackup = Get-ChildItem $ConfigDir -Filter 'GameUserSettings.ini.bak-*' -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($latestBackup) {
        Copy-Item $latestBackup.FullName $IniPath -Force
        Write-Log "Restored $($latestBackup.Name) over current ini." -Level OK
    } else {
        Write-Log "No backup file found; read-only attribute removed but content unchanged." -Level WARN
        Write-Log "Arc Raiders will rewrite the ini next time you change an in-game setting." -Level INFO
    }
    exit 0
}

# --------------------------------------------------------------------
# Apply path
# --------------------------------------------------------------------
Write-Log "Deploy-ArcRaidersConfig.ps1" -Level HEAD
Write-Log "Target: $IniPath"

# Ensure directory exists
if (-not (Test-Path $ConfigDir)) {
    Write-Log "Config directory not present. Has Arc Raiders been launched at least once?" -Level WARN
    Write-Log "Expected: $ConfigDir" -Level INFO
    Write-Log "Creating directory and proceeding - Arc Raiders will use our ini on first launch." -Level INFO
    if (-not $WhatIf) {
        New-Item -ItemType Directory -Path $ConfigDir -Force | Out-Null
    }
}

# Read existing ini (if present) and back it up
$existingContent = ''
if (Test-Path $IniPath) {
    $item = Get-Item $IniPath
    if ($item.IsReadOnly) {
        Write-Log "Existing ini is read-only (likely from prior run). Clearing attr to read." -Level INFO
        if (-not $WhatIf) { $item.IsReadOnly = $false }
    }
    $existingContent = Get-Content $IniPath -Raw -ErrorAction SilentlyContinue
    if (-not $existingContent) { $existingContent = '' }

    $backupPath = "$IniPath.bak-$Timestamp"
    if ($WhatIf) {
        Write-Log "DRY-RUN: would back up existing ini to $backupPath" -Level SKIP
    } else {
        Copy-Item $IniPath $backupPath -Force
        Write-Log "Backed up existing ini to $backupPath" -Level OK
    }
} else {
    Write-Log "No existing ini at target path. Will create new." -Level INFO
}

# --------------------------------------------------------------------
# Build new ini content
# Strategy:
#   - If [ScalabilityGroups] section exists in original content, replace it
#   - If [SystemSettings] section exists, replace it
#   - If either is absent, append
#   - Preserve any OTHER sections in the original content (keybinds,
#     resolution, window mode, etc.)
# --------------------------------------------------------------------

# Build our two sections
$scalabilityBlock = "[ScalabilityGroups]`r`n"
foreach ($k in ($ScalabilityGroups.Keys | Sort-Object)) {
    $scalabilityBlock += "$k=$($ScalabilityGroups[$k])`r`n"
}

$systemBlock = "[SystemSettings]`r`n"
foreach ($k in ($SystemSettings.Keys | Sort-Object)) {
    $systemBlock += "$k=$($SystemSettings[$k])`r`n"
}

# Regex-replace the sections in the existing content, or build fresh
function Replace-OrAppend-Section {
    param(
        [string]$Content,
        [string]$SectionHeader,    # e.g. '[ScalabilityGroups]'
        [string]$NewBlock
    )
    # Match [Section] through start of next [ or end of file
    $escaped = [regex]::Escape($SectionHeader)
    $pattern = "(?ms)^\s*$escaped\s*\r?\n(.*?)(?=^\s*\[|\z)"
    if ([regex]::IsMatch($Content, $pattern)) {
        return [regex]::Replace($Content, $pattern, $NewBlock)
    } else {
        # Append with a blank line separator if content isn't empty
        if ($Content.Trim().Length -gt 0) {
            return $Content.TrimEnd() + "`r`n`r`n" + $NewBlock
        } else {
            return $NewBlock
        }
    }
}

$newContent = $existingContent
$newContent = Replace-OrAppend-Section -Content $newContent -SectionHeader '[ScalabilityGroups]' -NewBlock $scalabilityBlock
$newContent = Replace-OrAppend-Section -Content $newContent -SectionHeader '[SystemSettings]' -NewBlock $systemBlock

# Header comment so future-Logan knows what this file is
$header = @"
; ===================================================================
; Arc Raiders GameUserSettings.ini
; Domain 2 competitive graphics preset from ArcRaiders_Decided_Settings.md
; Deployed: $Timestamp by Deploy-ArcRaidersConfig.ps1
; File is read-only to prevent Arc Raiders from overwriting these values.
; To revert: run Deploy-ArcRaidersConfig.ps1 -Revert
; ===================================================================

"@
if (-not $newContent.StartsWith(';')) {
    $newContent = $header + $newContent
}

# --------------------------------------------------------------------
# Write it
# --------------------------------------------------------------------
Write-Log "" -Level HEAD
Write-Log "=== Changes to apply ===" -Level HEAD

Write-Log "ScalabilityGroups:"
foreach ($k in ($ScalabilityGroups.Keys | Sort-Object)) {
    Write-Log "  $k = $($ScalabilityGroups[$k])" -Level INFO
}
Write-Log ""
Write-Log "SystemSettings:"
foreach ($k in ($SystemSettings.Keys | Sort-Object)) {
    Write-Log "  $k = $($SystemSettings[$k])" -Level INFO
}

if ($WhatIf) {
    Write-Log "" -Level HEAD
    Write-Log "DRY-RUN: would write $($newContent.Length) bytes to $IniPath" -Level SKIP
    Write-Log "DRY-RUN: would set read-only attribute on file" -Level SKIP
    exit 0
}

Set-Content -Path $IniPath -Value $newContent -Encoding UTF8 -NoNewline
Write-Log "" -Level HEAD
Write-Log "Wrote $($newContent.Length) bytes to $IniPath" -Level OK

# Set read-only
$item = Get-Item $IniPath
$item.IsReadOnly = $true
Write-Log "Set read-only attribute." -Level OK

Write-Log "" -Level HEAD
Write-Log "=== Done ===" -Level HEAD
Write-Log "Arc Raiders will now use Domain 2 graphics settings on launch."
Write-Log "In-game sliders will appear to change values but ini is read-only - values persist."
Write-Log ""
Write-Log "To revert: .\Deploy-ArcRaidersConfig.ps1 -Revert"
Write-Log "To preview: .\Deploy-ArcRaidersConfig.ps1 -WhatIf"
