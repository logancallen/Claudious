# PROPOSAL — Evaluate ant CLI (Native Claude API Command-Line Client)

**Finding-ID:** 2026-04-17-ant-cli
**Impact:** M | **Effort:** T | **Risk:** SAFE
**Source:** Section B-1 — official Claude API release notes

## Finding
`ant` CLI launched: command-line Claude API client with native Claude Code integration and YAML file versioning of API resources. Positioned as the developer-facing companion to Claude Code.

## Key Capabilities
- YAML-versioned API resource management (prompts, tools, workflows)
- Native Claude Code integration — pipe claude output to ant, or vice versa
- CLI-native API testing without Python/Node SDK scaffolding

## Proposed Action
Logan to evaluate in next API-heavy build session. If useful, add a TECHNIQUE entry:

**Learning:** Use `ant` CLI for rapid Claude API prototyping and YAML-versioned resource management. Replaces ad-hoc curl/SDK scaffolding for API testing. Integrates natively with Claude Code sessions.

## Why Proposal (not Auto-Queue)
Requires Logan to test and validate utility before adding to learnings. Medium impact — not yet confirmed as a workflow improvement.
