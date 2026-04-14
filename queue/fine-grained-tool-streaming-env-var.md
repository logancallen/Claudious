# QUEUED: Add CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING Env Var
**Finding-ID:** 2026-04-13-fine-grained-tool-streaming
**Source:** https://www.turboai.dev/blog/claude-code-environment-variables-complete-list
**Classification:** QUEUED (SAFE + HIGH + TRIVIAL)
**Risk:** SAFE (no known downsides — strictly latency optimization)

## What It Does
Enables eager input streaming for tool calls. Reduces Bedrock permission prompt latency from 10-20 seconds to 1-3 seconds. Modest improvement on direct API.

## Why Queued
- SAFE: no known downsides per source
- HIGH impact: eliminates 10-20s freezes on permission prompts
- TRIVIAL: single env var, no config conflicts

## Implementation Steps
1. Add `CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING=1` to shell profile (Mac and PC)
2. Append new entry to `learnings/techniques.md` documenting the env var under the existing "Env Var Layer for Claude Code Tuning" technique

## Proposed learnings/techniques.md Edit
Append to the Env Var Layer entry's Learning field:
> Additionally: `CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING=1` enables eager input streaming, dropping Bedrock permission prompt latency from 10-20s to 1-3s.

## Verification
- After setting, trigger any tool that prompts for permission
- Confirm perceived latency drop

## Applies To
All Claude Code sessions globally — shell profile on Mac and PC.
