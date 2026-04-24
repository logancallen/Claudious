# Session start preflight - Claudious
# Fail-open: infra errors exit 0. Only drift conditions halt.

$ErrorActionPreference = "Continue"

$currentRepo = "Claudious"

$candidates = @(
  "$env:USERPROFILE\Documents\GitHub\Claudious",
  "$env:USERPROFILE\Projects\Claudious",
  "$env:USERPROFILE\Projects\claudious"
)
$claudiousPath = $null
foreach ($p in $candidates) {
  if (Test-Path (Join-Path $p ".git")) { $claudiousPath = $p; break }
}

if (-not $claudiousPath) {
  Write-Host "[WARN] preflight-degraded: Claudious not found"
  exit 0
}

$script = Join-Path $claudiousPath "scripts\update-heartbeat.ps1"
if (-not (Test-Path $script)) {
  Write-Host "[WARN] preflight-degraded: heartbeat script not found"
  exit 0
}

& $script -Preflight $currentRepo
$exitCode = $LASTEXITCODE
if ($exitCode -ge 2 -and $exitCode -le 4) { exit $exitCode }
exit 0
