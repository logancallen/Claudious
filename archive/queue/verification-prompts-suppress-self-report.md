# Verification Prompts Suppress Self-Report
**Source:** archive/intake/2026-04-24.md section D
**Finding id:** constitutional-rule-verification-prompts-suppress-self-report
**Impact:** HIGH | **Effort:** TRIVIAL | **Risk:** SAFE | **Type:** TECHNIQUE
**Target file:** learnings/techniques.md
**Canonical mirror:** canonical/prompting-rules.md

## Change

```markdown
## Verification Prompts Suppress Self-Report — 2026-04-24

**Pattern:** Prompts that request verification output (commit SHAs, file contents, git status, grep counts, test output) must explicitly instruct Claude Code to suppress the Confidence/Assumptions/Context-health self-report block. Without the suppression directive, the self-report overrides the requested literal output and the caller must re-run the prompt.

**Why it works:** CC defaults to emitting a self-report block after verification-style prompts. The self-report is useful interactively but destroys the contract when a downstream script is grep-parsing the literal output. Suppression directive restores determinism in headless routines.

**Template:** `[output-only mode] Run <command>. Print raw output only. Do not emit Confidence, Assumptions, or Context-health self-report.` Re-seeded from 2026-04-19 handoff generation session.
```

**Canonical mirror block (append under `## Verification Culture`):**

```markdown
### verification-prompts-suppress-self-report
Prompts requesting verification output (commit SHAs, file contents, git status, grep counts) must explicitly instruct Claude Code to suppress the Confidence/Assumptions/Context-health self-report block. Without suppression, the self-report overrides the requested literal output and forces a re-run. Suppression directive: "print raw output only; do not emit self-report."
*Source: `learnings/techniques.md` — Verification Prompts Suppress Self-Report (2026-04-24).*
```

## Verification
grep -c "Verification Prompts Suppress Self-Report" learnings/techniques.md → must ≥1 after deploy
grep -c "verification-prompts-suppress-self-report" canonical/prompting-rules.md → must ≥1 after deploy
