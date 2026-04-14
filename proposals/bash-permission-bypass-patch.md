# PROPOSED: Update Claude Code to v2.1.98+ (Bash Permission Bypass Patch)
**Finding-ID:** 2026-04-13-bash-permission-bypass-patch
**Source:** https://releasebot.io/updates/anthropic/claude-code
**Classification:** PROPOSED
**Risk:** SAFE (fix); vulnerability itself was CRITICAL
**Priority:** HIGH — Security

## What It Does
v2.1.98 patched a security vulnerability: backslash-escaped flags could bypass Bash tool permission checks. Compound command safety checks strengthened. Network redirects to `/dev/tcp` and `/dev/udp` now prompt for approval.

## Why Not Queued
- Requires manual CLI action (`claude update`) — outside Implementer auto-deploy scope
- Needs audit of any custom permission rules that rely on flag detection
- Must be run on both Mac and PC

## Implementation Instructions
1. Run `claude update` on Mac — confirm `claude --version` is v2.1.98 or later (v2.1.105+ preferred for full set of recent fixes)
2. Run `claude update` on PC — same check
3. Audit any custom `permissions` or `allow`/`deny` rules in `~/.claude/settings.json` and per-project settings for flag-based detection
4. Re-test any workflow involving `curl` or network shell operations — new prompt for `/dev/tcp`/`/dev/udp` may surprise hooks
5. Log deploy result in `queue/deployed.log`

## Gotcha to Add
Append to `learnings/gotchas.md`:
> v2.1.98+ prompts for network redirects to `/dev/tcp` and `/dev/udp`. Any prior-approved bash rules assuming unrestricted network redirects will now block until re-approved.

## Verification
- `claude --version` shows v2.1.98+ on both machines
- Trigger a bash command that uses compound flags — confirm it still works under new safety checks

## Action Required
Logan: run `claude update` on both machines.
