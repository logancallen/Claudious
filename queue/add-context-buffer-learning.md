# QUEUED: Add Context Buffer Reserve to techniques.md
**Finding-ID:** 2026-04-12-context-buffer-reserve-learning
**Risk:** SAFE | **Impact:** HIGH | **Effort:** TRIVIAL

## What It Does
Scout report found that Claude Code reserves 33K-45K tokens internally for tool definitions, system prompts, and safety. Usable context is ~955K, not 1M. This affects compaction timing and token budgets but has no corresponding learnings entry.

## Implementation
1. Append new TECHNIQUE entry to `learnings/techniques.md`:

```
### 2026-04-12 — TECHNIQUE — Context Buffer: 33K-45K Reserved Internally
**Severity:** HIGH
**Context:** Scout finding from claudefa.st architecture documentation.
**Learning:** Claude Code reserves 33K-45K tokens from the context window for internal operations (tool definitions, system prompts, safety). Usable context is ~955K, not the full 1M. Plan compaction triggers at ~900K to leave headroom. Sub-agents have the same reduction — factor into task sizing.
**Applies to:** All Claude Code sessions — compaction timing and token budget planning
```

## Verification
- Confirm the entry is properly formatted and under the 200-line file limit
