# Add bundled prompt-skills technique (W16 /simplify, /batch, /debug, /loop, /claude-api)

**Source:** alerts.md 2026-04-22 HIGH SCOUT
**Impact:** H
**Effort:** T
**Risk:** SAFE
**Routing:** SAFE + H + md-only → QUEUE

## Rationale
Claude Code W16 shipped a bundled set of prompt-skills exposed as slash commands: `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`. These are workflow-changing built-ins (`/debug` and `/loop` especially) and deserve a durable home in `learnings/techniques.md`, not just an alert line. The alert will be cleared separately after the technique lands.

## Implementation
Append to `learnings/techniques.md` (before the `## Archive` section):

```markdown
### 2026-04-22 — TECHNIQUE — Bundled Prompt-Skills (`/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`)
**Severity:** HIGH
**Context:** Claude Code W16 bundled five prompt-skills as first-class slash commands. Run `/help` to verify the command list in any current session.
**Learning:** `/simplify` condenses over-engineered responses back to the core answer; `/batch` queues multiple independent asks into one execution pass; `/debug` runs a structured error-diagnosis prompt scaffold; `/loop` self-paces a multi-turn session without manual re-prompting; `/claude-api` spins up API-specific helpers (headers, streaming, tool_use). These replace ad-hoc prompt patterns Logan already uses — reach for the built-in first. Add `/loop` and `/debug` references to `canonical/prompting-rules.md` on next curate pass so they surface in prompting guidance, not just technique log.
**Applies to:** All Claude Code sessions — ASF Graphics, Courtside Pro, Claudious, Claude Mastery Lab
```

## Verification
- `grep -c "Bundled Prompt-Skills" learnings/techniques.md` → 1
- File remains under 200-line cap (`wc -l learnings/techniques.md` → <200)

<!-- PROMOTE TO CLAUDIOUS: already in Claudious -->
