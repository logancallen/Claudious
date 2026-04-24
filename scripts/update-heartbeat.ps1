# Updates this machine's heartbeat in .claudious-heartbeat/
#
# USAGE
#   .\scripts\update-heartbeat.ps1                         # manual: write heartbeat, print JSON, exit 0
#   .\scripts\update-heartbeat.ps1 -Preflight <repo-name>  # hook mode: write, commit+push, fetch current repo,
#                                                          # evaluate halt conditions, print status line
#
# Exit codes (preflight mode only):
#   0 = clean / warnings only / infra-degraded (fail-open)
#   2 = STALE REPO   3 = STALE WIP   4 = SIBLING AHEAD
#
# ASCII-only strings for Windows PowerShell 5.1 (UTF-8-no-BOM .ps1 files get
# mis-decoded as Windows-1252 when they contain emoji/em-dashes; see
# docs/learnings.md em-dash gotcha 2026-04-22).

param(
  [string]$Preflight,
  [switch]$Verbose
)

$ErrorActionPreference = "Continue"

try {
  $preflightMode = -not [string]::IsNullOrWhiteSpace($Preflight)
  $currentRepo   = $Preflight

  $homeDir = $env:USERPROFILE
  if ($preflightMode) {
    $claudiousCandidates = @("$homeDir\Documents\GitHub\Claudious", "$homeDir\Projects\Claudious", "$homeDir\Projects\claudious")
    $repoRoot = $null
    foreach ($p in $claudiousCandidates) { if (Test-Path (Join-Path $p ".git")) { $repoRoot = $p; break } }
    if (-not $repoRoot) { Write-Host "[WARN] preflight-degraded: Claudious repo not found"; exit 0 }
  } else {
    $repoRoot = git rev-parse --show-toplevel 2>$null
    if (-not $repoRoot) { Write-Host "Not in a git repo"; exit 1 }
  }
  Set-Location $repoRoot

  if (-not $preflightMode) {
    $isClaudious = (Test-Path "CLAUDE.md") -and (Select-String -Path "CLAUDE.md" -Pattern "Claudious" -Quiet)
    if (-not $isClaudious) { Write-Host "Not the Claudious repo"; exit 1 }
  }

  $rawHost = $env:COMPUTERNAME
  if (-not $rawHost) { $rawHost = "unknown" }
  $machineSlug = $rawHost.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-'
  $machineSlug = $machineSlug.Trim('-')
  if (-not $machineSlug) { $machineSlug = "unknown-machine" }

  $heartbeatDir  = Join-Path $repoRoot ".claudious-heartbeat"
  $heartbeatFile = Join-Path $heartbeatDir "$machineSlug.json"
  New-Item -ItemType Directory -Force -Path $heartbeatDir | Out-Null

  $os = "Windows"
  $timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

  $repoNames = @("Claudious", "asf-graphics-app", "courtside-pro")

  function Get-RepoStats($name) {
    $candidates = switch ($name) {
      "Claudious"         { @("$homeDir\Documents\GitHub\Claudious", "$homeDir\Projects\Claudious", "$homeDir\Projects\claudious") }
      "asf-graphics-app"  { @("$homeDir\Documents\GitHub\asf-graphics-app", "$homeDir\Projects\asf-graphics-app") }
      "courtside-pro"     { @("$homeDir\Documents\GitHub\courtside-pro", "$homeDir\Projects\courtside-pro") }
    }

    $foundPath = $null
    foreach ($p in $candidates) {
      if (Test-Path (Join-Path $p ".git")) { $foundPath = $p; break }
    }
    if (-not $foundPath) { return $null }

    Push-Location $foundPath
    try {
      git fetch --quiet 2>$null | Out-Null

      $headSha = (git rev-parse --short HEAD 2>$null)
      if (-not $headSha) { $headSha = "unknown" }
      $headSubject = (git log -1 --pretty=%s 2>$null)
      if (-not $headSubject) { $headSubject = "" }
      if ($headSubject.Length -gt 80) { $headSubject = $headSubject.Substring(0, 80) }
      $branch = (git branch --show-current 2>$null)
      if (-not $branch) { $branch = "detached" }
      $dirty = (git status --porcelain 2>$null | Measure-Object -Line).Lines
      $ahead = 0; $behind = 0
      try { $ahead  = [int](git rev-list --count '@{u}..HEAD' 2>$null) } catch { $ahead = 0 }
      try { $behind = [int](git rev-list --count 'HEAD..@{u}' 2>$null) } catch { $behind = 0 }

      return [ordered]@{
        path          = $foundPath
        head_sha      = $headSha
        head_subject  = $headSubject
        branch        = $branch
        dirty_files   = [int]$dirty
        ahead         = [int]$ahead
        behind        = [int]$behind
        last_fetch    = $timestamp
      }
    } finally {
      Pop-Location
    }
  }

  $tracked = [ordered]@{}
  foreach ($name in $repoNames) {
    $stats = Get-RepoStats $name
    if ($stats) { $tracked[$name] = $stats }
  }

  $payload = [ordered]@{
    machine_id    = $machineSlug
    hostname      = $rawHost
    os            = $os
    last_seen     = $timestamp
    tracked_repos = $tracked
  }

  $json = $payload | ConvertTo-Json -Depth 5
  [System.IO.File]::WriteAllText($heartbeatFile, $json, (New-Object System.Text.UTF8Encoding $false))

  if (-not $preflightMode) {
    Write-Host "Heartbeat written: $heartbeatFile"
    Write-Host "Machine: $machineSlug ($os)"
    Get-Content $heartbeatFile
    [Console]::Out.Flush()
    exit 0
  }

  # -------------------- PREFLIGHT MODE --------------------

  Push-Location $repoRoot
  try {
    $branchNow = (git branch --show-current 2>$null)
    $hbStatus  = (git status --porcelain .claudious-heartbeat/ 2>$null)
    if ($branchNow -eq "main" -and $hbStatus) {
      git add ".claudious-heartbeat/$machineSlug.json" 2>$null | Out-Null
      $claudiousSha = (git rev-parse --short HEAD 2>$null)
      if (-not $claudiousSha) { $claudiousSha = "unknown" }
      git commit -m "heartbeat: $machineSlug @ $claudiousSha" --quiet 2>$null | Out-Null
      try { git push origin main --quiet 2>$null | Out-Null } catch { Write-Host "[WARN] heartbeat push failed (continuing)" }
    }
  } finally { Pop-Location }

  $currentPath = $null
  switch ($currentRepo) {
    "Claudious"        { $currentPath = $repoRoot }
    "asf-graphics-app" { foreach ($p in @("$homeDir\Documents\GitHub\asf-graphics-app","$homeDir\Projects\asf-graphics-app")) { if (Test-Path (Join-Path $p ".git")) { $currentPath = $p; break } } }
    "courtside-pro"    { foreach ($p in @("$homeDir\Documents\GitHub\courtside-pro","$homeDir\Documents\courtside-pro","$homeDir\Projects\courtside-pro")) { if (Test-Path (Join-Path $p ".git")) { $currentPath = $p; break } } }
    default            { Write-Host "[WARN] preflight-degraded: unknown current repo '$currentRepo'"; [Console]::Out.Flush(); exit 0 }
  }
  if (-not $currentPath) { Write-Host "[WARN] preflight-degraded: $currentRepo not found on this machine"; [Console]::Out.Flush(); exit 0 }

  Push-Location $currentPath
  try {
    git fetch --all --prune --quiet 2>$null | Out-Null
    $curBranch = (git branch --show-current 2>$null)
    $curDirty  = (git status --porcelain 2>$null | Measure-Object -Line).Lines
    $curAhead  = 0; $curBehind = 0
    try { $curAhead  = [int](git rev-list --count '@{u}..HEAD' 2>$null) } catch {}
    try { $curBehind = [int](git rev-list --count 'HEAD..@{u}' 2>$null) } catch {}

    $curOldestH = 0
    $porcelain = git status --porcelain 2>$null
    if ($porcelain) {
      $oldest = [DateTime]::UtcNow
      foreach ($line in $porcelain) {
        $rel = $line.Substring(3)
        $full = Join-Path $currentPath $rel
        if (Test-Path $full) {
          $mt = (Get-Item $full).LastWriteTimeUtc
          if ($mt -lt $oldest) { $oldest = $mt }
        }
      }
      $curOldestH = [int]([DateTime]::UtcNow - $oldest).TotalHours
    }
  } finally { Pop-Location }

  $sibName = $null; $sibAgeH = 9999.0; $sibSha = ""
  $nowUtc = [DateTime]::UtcNow
  Get-ChildItem $heartbeatDir -Filter "*.json" | ForEach-Object {
    if ($_.BaseName -eq $machineSlug) { return }
    try {
      $sib = Get-Content $_.FullName -Raw | ConvertFrom-Json
      if (-not $sib.last_seen) { return }
      $ts = [DateTime]::Parse($sib.last_seen, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal)
      $ageH = ($nowUtc - $ts).TotalHours
      $entry = $null
      if ($sib.tracked_repos -and $sib.tracked_repos.PSObject.Properties.Name -contains $currentRepo) {
        $entry = $sib.tracked_repos.$currentRepo
      }
      if (-not $entry) { return }
      if ($ageH -lt $sibAgeH) {
        $sibAgeH = $ageH
        $sibName = $sib.machine_id
        $sibSha  = $entry.head_sha
      }
    } catch {}
  }

  $sibRepoBehind = 0
  if ($sibName -and $sibSha) {
    Push-Location $currentPath
    try {
      git cat-file -e $sibSha 2>$null
      if ($LASTEXITCODE -eq 0) {
        try { $sibRepoBehind = [int](git rev-list --count "HEAD..$sibSha" 2>$null) } catch {}
      }
    } finally { Pop-Location }
  }

  $order = @("Claudious","asf-graphics-app","courtside-pro")
  $short = @{ "Claudious"="Claudious"; "asf-graphics-app"="asf"; "courtside-pro"="courtside" }
  $partList = @()
  foreach ($n in $order) {
    $e = $null
    if ($payload.tracked_repos.Contains($n)) { $e = $payload.tracked_repos[$n] }
    $lbl = $short[$n]
    if ($null -eq $e) { $partList += "$lbl -"; continue }
    $b = [int]$e.behind; $a = [int]$e.ahead; $d = [int]$e.dirty_files
    if ($b -eq 0 -and $a -eq 0 -and $d -eq 0)  { $sym = "OK" }
    elseif ($d -gt 0)                          { $sym = "[WARN]${d}dirty" }
    elseif ($b -gt 0)                          { $sym = "[WARN]${b}behind" }
    else                                        { $sym = "[WARN]${a}ahead" }
    $partList += "$lbl $sym"
  }
  $othersStr = $partList -join " "

  $sibSummary = "no sibling heartbeat yet"
  if ($sibName) {
    $sibAgeInt = [int][Math]::Round($sibAgeH)
    $sibSummary = "sibling $sibName fresh ${sibAgeInt}h"
    if ($sibAgeH -gt 48) { Write-Host "[WARN] $sibName stale (last seen ${sibAgeInt}h ago)" }
  }

  if ($curBehind -gt 0) {
    Write-Host "[HALT] STALE REPO - $currentRepo is $curBehind commits behind origin/main. Pull before editing."
    Write-Host "[HB] $machineSlug | $othersStr | $sibSummary"
    [Console]::Out.Flush(); exit 2
  }
  if ($curDirty -ge 5 -and $curOldestH -gt 24) {
    Write-Host "[HALT] STALE WIP - $currentRepo has $curDirty uncommitted files, oldest ${curOldestH}h old. Commit, stash, or clean before new work."
    Write-Host "[HB] $machineSlug | $othersStr | $sibSummary"
    [Console]::Out.Flush(); exit 3
  }
  if ($sibName -and $sibAgeH -lt 4 -and $sibRepoBehind -gt 0) {
    $sibAgeInt = [int][Math]::Round($sibAgeH)
    Write-Host "[HALT] SIBLING AHEAD - $sibName pushed $sibRepoBehind commits to $currentRepo ${sibAgeInt}h ago. Pull before editing."
    Write-Host "[HB] $machineSlug | $othersStr | $sibSummary"
    [Console]::Out.Flush(); exit 4
  }

  Write-Host "[HB] $machineSlug | $othersStr | $sibSummary"
  [Console]::Out.Flush(); exit 0

} catch {
  Write-Host "[WARN] preflight-degraded: $($_.Exception.Message)"
  [Console]::Out.Flush(); exit 0
}
