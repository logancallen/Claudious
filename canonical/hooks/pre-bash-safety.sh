#!/usr/bin/env bash
# Pre-bash safety hook.
#
# Repo policy: direct-to-main is the workflow — no PRs, no feature branches.
# So `git push origin main`, `git fetch`, `git rebase origin/main`, and
# compound commands using them MUST pass.
#
# What gets blocked: only operations that are genuinely hard to undo —
# force pushes, hard resets, root/home filesystem deletes, destructive SQL.
#
# Patterns use [^&|;] to keep matches inside a single command segment,
# so a benign first segment can't pull a destructive flag from a later one.

set -euo pipefail
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Each entry is a POSIX-extended regex matched case-insensitively.
PATTERNS=(
  # Filesystem deletes targeting root or home directly (not subpaths)
  'rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*[[:space:]]+/([[:space:]]*$|[[:space:]]*[;&|]|\*)'
  'rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*[[:space:]]+~([[:space:]]*$|[[:space:]]*[;&|]|/\*)'
  'rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*[[:space:]]+\$HOME([[:space:]]*$|[[:space:]]*[;&|]|/\*)'

  # Destructive git operations (segment-scoped)
  'git[[:space:]]+reset[[:space:]][^&|;]*--hard'
  'git[[:space:]]+push[[:space:]][^&|;]*--force(-with-lease)?'
  'git[[:space:]]+push[[:space:]]([^&|;]*[[:space:]])?-f([[:space:]]|$)'

  # Destructive SQL
  'DROP[[:space:]]+(TABLE|DATABASE)'
  'TRUNCATE[[:space:]][^&|;]*CASCADE'
)

for pat in "${PATTERNS[@]}"; do
  if printf '%s' "$COMMAND" | grep -qEi "$pat"; then
    echo "BLOCKED: destructive pattern matched" >&2
    echo "  pattern: $pat" >&2
    echo "  command: $COMMAND" >&2
    exit 2
  fi
done

exit 0
