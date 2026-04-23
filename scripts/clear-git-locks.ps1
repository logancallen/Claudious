#Requires -Version 5.1
<#
.SYNOPSIS
    Remove stale .git/*.lock files when no git process is running.

.DESCRIPTION
    Sandbox shells (WSL, Claude Code) cannot delete .git lock files created
    by Windows-side git processes due to UID/mount boundaries. This script
    runs in native PowerShell, verifies no live git.exe holds the repo, and
    cleans index.lock, HEAD.lock, and refs/heads/*.lock.

    Refuses to act if any git.exe is running — that lock is live, not stale.

.PARAMETER RepoPath
    Path to the git repo. Defaults to current directory.

.PARAMETER DryRun
    Show what would be removed without deleting.

.EXAMPLE
    .\scripts\clear-git-locks.ps1
    Clean stale locks in the current repo.

.EXAMPLE
    .\scripts\clear-git-locks.ps1 -RepoPath C:\Users\logan\Projects\Claudious -DryRun
    Show what would be cleaned, without acting.

.NOTES
    Documented blocker pattern — see archive/retrospectives/pioneer-report-2026-04.md line 145.
#>

[CmdletBinding()]
param(
    [string]$RepoPath = (Get-Location).Path,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

# Resolve and validate repo
$RepoPath = (Resolve-Path -LiteralPath $RepoPath).Path
$GitDir = Join-Path $RepoPath '.git'
if (-not (Test-Path -LiteralPath $GitDir -PathType Container)) {
    Write-Error "Not a git repo: $RepoPath (no .git/ directory)"
    exit 2
}

# Refuse if any git process is live
$LiveGit = Get-Process -Name 'git' -ErrorAction SilentlyContinue
if ($LiveGit) {
    Write-Host "REFUSING: git process(es) currently running:" -ForegroundColor Yellow
    $LiveGit | Format-Table Id, ProcessName, StartTime -AutoSize | Out-String | Write-Host
    Write-Host "These locks may be live, not stale. Wait for git to finish, then re-run." -ForegroundColor Yellow
    exit 1
}

# Find candidate locks
$LockPaths = @(
    (Join-Path $GitDir 'index.lock'),
    (Join-Path $GitDir 'HEAD.lock')
)
$RefsHeadsDir = Join-Path $GitDir 'refs\heads'
if (Test-Path -LiteralPath $RefsHeadsDir -PathType Container) {
    $LockPaths += (Get-ChildItem -LiteralPath $RefsHeadsDir -Filter '*.lock' -File -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
}

$Existing = $LockPaths | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf }

if (-not $Existing) {
    Write-Host "No stale locks found in $GitDir" -ForegroundColor Green
    exit 0
}

Write-Host "Found $($Existing.Count) stale lock file(s):" -ForegroundColor Cyan
$Existing | ForEach-Object { Write-Host "  $_" }

if ($DryRun) {
    Write-Host "DryRun: no files removed." -ForegroundColor Cyan
    exit 0
}

$Removed = 0
$Failed = @()
foreach ($LockFile in $Existing) {
    try {
        Remove-Item -LiteralPath $LockFile -Force -ErrorAction Stop
        $Removed++
        Write-Host "  removed: $LockFile" -ForegroundColor Green
    } catch {
        $Failed += [PSCustomObject]@{ Path = $LockFile; Error = $_.Exception.Message }
    }
}

Write-Host ""
Write-Host "Cleared: $Removed / $($Existing.Count)" -ForegroundColor Green
if ($Failed) {
    Write-Host "Failed:" -ForegroundColor Red
    $Failed | Format-Table Path, Error -AutoSize | Out-String | Write-Host
    exit 3
}
exit 0
