# Updates this machine's heartbeat in .claudious-heartbeat/
# Run from inside the Claudious repo.

$ErrorActionPreference = "Stop"

$repoRoot = git rev-parse --show-toplevel 2>$null
if (-not $repoRoot) { Write-Error "Not in a git repo"; exit 1 }
Set-Location $repoRoot

# Sanity check
$isClaudious = (Test-Path "CLAUDE.md") -and (Select-String -Path "CLAUDE.md" -Pattern "Claudious" -Quiet)
if (-not $isClaudious) { Write-Error "Not the Claudious repo"; exit 1 }

# Detect machine
$rawHost = $env:COMPUTERNAME
if (-not $rawHost) { $rawHost = "unknown" }
$machineSlug = $rawHost.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-'
$machineSlug = $machineSlug.Trim('-')
if (-not $machineSlug) { $machineSlug = "unknown-machine" }

$heartbeatDir = Join-Path $repoRoot ".claudious-heartbeat"
$heartbeatFile = Join-Path $heartbeatDir "$machineSlug.json"
New-Item -ItemType Directory -Force -Path $heartbeatDir | Out-Null

$os = "Windows"
$timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$homeDir = $env:USERPROFILE
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
    try { $ahead = [int](git rev-list --count '@{u}..HEAD' 2>$null) } catch {}
    try { $behind = [int](git rev-list --count 'HEAD..@{u}' 2>$null) } catch {}

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
  machine_id     = $machineSlug
  hostname       = $rawHost
  os             = $os
  last_seen      = $timestamp
  tracked_repos  = $tracked
}

$json = $payload | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText($heartbeatFile, $json, (New-Object System.Text.UTF8Encoding $false))

Write-Host "Heartbeat written: $heartbeatFile"
Write-Host "Machine: $machineSlug ($os)"
Get-Content $heartbeatFile
