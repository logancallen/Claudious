# Claudious — Project Learnings

## Active Learnings

### 2026-04-11 — DECISION — Claudious Architecture
**Severity:** CRITICAL
**Context:** April 11, 2026 design session.
**Learning:** Claudious connects to ALL Claude Projects as global knowledge source. Per-project learnings stay in each project's docs/learnings.md. Cross-project techniques, patterns, gotchas route to Claudious learnings/. Harvest skill produces dual CC prompts: one for project repo, one for Claudious. After both pushes, click Sync in both Claude Project UIs.
**Applies to:** All sessions — routing and sync decisions

### 2026-04-11 — DECISION — Queue vs Proposals Architecture
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** queue/ = SAFE + HIGH impact + TRIVIAL effort items Claude deploys with one-word approval. proposals/ = anything requiring human judgment (User Preferences, production code, schema, deletes). Pioneer never auto-deploys. queue/deployed.log tracks what was actually implemented and whether it worked — Pioneer reads this to calibrate future proposals.
**Applies to:** Pioneer skill, Evaluator scheduled task

### 2026-04-11 — DECISION — Primary vs Fallback Auto-Harvest
**Severity:** HIGH
**Context:** April 11, 2026 design session.
**Learning:** Primary harvest mechanism is SessionEnd directive in global CLAUDE.md (fires in-context, can read conversation). Daily scheduled task is FALLBACK only — catches sessions where SessionEnd hook was skipped. Never treat scheduled task as primary or duplicates accumulate.
**Applies to:** Auto-harvest architecture

### 2026-04-22 — GOTCHA — PowerShell file generation: encoding

**Category:** CROSS-PLATFORM / TOOLING
**Severity:** HIGH (silent failure, cascades into misdiagnosis)
**Surface:** Claude-generated .ps1 files deployed to Windows PowerShell 5.1

#### Problem
Claude's file-creation tools write UTF-8 without BOM on Linux. When a .ps1 file contains non-ASCII characters (em-dash —, smart quotes, en-dashes, ellipsis) and is executed on Windows PowerShell 5.1, WinPS defaults to Windows-1252 decoding for BOM-less files. UTF-8 byte sequences for em-dash (0xE2 0x80 0x94) get misread — byte 0x94 maps to a smart right-quote in 1252, which terminates PowerShell strings mid-parse. Parser then reports cascading "missing terminator" and "missing closing brace" errors pointing at the wrong lines, making root-cause diagnosis difficult.

#### Observed failure mode
- Parse-check fails with `The string is missing the terminator: "` on a line far from the actual non-ASCII character
- Errors cascade into phantom brace-matching failures
- Line-ending hypothesis (LF vs CRLF) is a plausible but WRONG diagnosis that wastes cycles

#### Fix (in order of preference)
1. **BEST:** Restrict .ps1 file contents to pure ASCII. No em-dashes in comments. Use regular hyphens or spelled-out equivalents.
2. **GOOD:** If non-ASCII is unavoidable, Claude must write files with UTF-8 BOM + CRLF explicitly using byte-level file write (not Get-Content/Set-Content round-trip, which may re-encode).
3. **SAFETY NET:** CC prompts that deploy generated .ps1 files should include mandatory pre-check step: `[System.IO.File]::ReadAllBytes($path)[0..2]` — verify first 3 bytes are `0xEF 0xBB 0xBF` (BOM) before parse-check.

#### Canonical fix command (CC)
```powershell
$bytes = [System.IO.File]::ReadAllBytes($path)
$bom = [byte[]](0xEF, 0xBB, 0xBF)
$text = [System.Text.Encoding]::UTF8.GetString($bytes)
$crlf = $text -replace "(?<!`r)`n","`r`n"
$out = $bom + [System.Text.Encoding]::UTF8.GetBytes($crlf)
[System.IO.File]::WriteAllBytes($path, $out)
```

#### Default routing going forward
- Future Claude sessions generating .ps1 for Windows targets: use only ASCII in comments by default
- CC prompts deploying generated .ps1 files: include BOM verification step as mandatory stop-gate

#### Discovered during
Arc Raiders PC optimization deploy (2026-04-22). Lost ~3 min to LF/CRLF hypothesis before CC correctly identified the encoding root cause. Documented so future sessions don't repeat.

**Applies to:** Any Claude-generated .ps1 destined for Windows PowerShell 5.1 execution

<!-- PROMOTE TO CLAUDIOUS: PowerShell encoding gotcha is cross-project — applies to any Claude-generated PS1 file deployed to Windows. Global relevance HIGH. -->

## Archive
