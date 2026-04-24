#!/usr/bin/env bash
# Updates this machine's heartbeat in .claudious-heartbeat/
# Safe to run from anywhere — cds to Claudious repo root first.

set -e

# Locate Claudious repo root (must be run from inside it)
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo" >&2; exit 1; }
cd "$REPO_ROOT"

# Verify we're in Claudious (sanity check)
if ! grep -q "Claudious" CLAUDE.md 2>/dev/null && ! grep -q "claudious" README.md 2>/dev/null; then
  echo "ERROR: This doesn't appear to be the Claudious repo (no Claudious marker in CLAUDE.md or README.md)" >&2
  exit 1
fi

# Detect machine
RAW_HOST=$(hostname 2>/dev/null || echo "unknown")
RAW_HOST_LOWER=$(echo "$RAW_HOST" | tr '[:upper:]' '[:lower:]')
MACHINE_SLUG=$(echo "$RAW_HOST_LOWER" | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
[ -z "$MACHINE_SLUG" ] && MACHINE_SLUG="unknown-machine"

HEARTBEAT_DIR="$REPO_ROOT/.claudious-heartbeat"
HEARTBEAT_FILE="$HEARTBEAT_DIR/${MACHINE_SLUG}.json"
mkdir -p "$HEARTBEAT_DIR"

# Detect OS
case "$(uname -s 2>/dev/null)" in
  Darwin)               OS="macOS" ;;
  Linux)                OS="Linux" ;;
  MINGW*|MSYS*|CYGWIN*) OS="Windows" ;;
  *)                    OS="Unknown" ;;
esac

# Timestamp (portable UTC ISO-8601)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Determine home for repo path guessing
HOME_DIR="${HOME:-$USERPROFILE}"

# Tracked repos — check canonical path, fall back to common alternates
declare -a REPO_NAMES=("Claudious" "asf-graphics-app" "courtside-pro")

# JSON-escape helper
json_escape() {
  printf '%s' "$1" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))' 2>/dev/null || \
    printf '"%s"' "$(printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\t/\\t/g' | tr -d '\n\r')"
}

# Gather repo stats — print each repo's JSON object (no trailing comma handled by caller)
gather_repo() {
  local name="$1"
  local candidates=()

  case "$name" in
    Claudious)
      candidates=(
        "$HOME_DIR/Documents/GitHub/Claudious"
        "$HOME_DIR/Projects/Claudious"
        "$HOME_DIR/Projects/claudious"
      )
      ;;
    asf-graphics-app)
      candidates=(
        "$HOME_DIR/Documents/GitHub/asf-graphics-app"
        "$HOME_DIR/Projects/asf-graphics-app"
      )
      ;;
    courtside-pro)
      candidates=(
        "$HOME_DIR/Documents/GitHub/courtside-pro"
        "$HOME_DIR/Documents/courtside-pro"
        "$HOME_DIR/Projects/courtside-pro"
      )
      ;;
  esac

  local found_path=""
  for p in "${candidates[@]}"; do
    if [ -d "$p/.git" ]; then
      found_path="$p"
      break
    fi
  done

  [ -z "$found_path" ] && return 1  # repo not present on this machine

  (
    cd "$found_path" || return 1
    git fetch --quiet 2>/dev/null || true

    local head_sha head_subject branch dirty ahead behind last_fetch
    head_sha=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    head_subject=$(git log -1 --pretty=%s 2>/dev/null | head -c 80 || echo "")
    branch=$(git branch --show-current 2>/dev/null || echo "detached")
    dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
    last_fetch="$TIMESTAMP"

    # Escape path and subject for JSON
    path_escaped=$(printf '%s' "$found_path" | sed 's/\\/\\\\/g; s/"/\\"/g')
    subject_escaped=$(printf '%s' "$head_subject" | sed 's/\\/\\\\/g; s/"/\\"/g' | tr -d '\n\r')

    cat <<REPO_JSON
    "$name": {
      "path": "$path_escaped",
      "head_sha": "$head_sha",
      "head_subject": "$subject_escaped",
      "branch": "$branch",
      "dirty_files": $dirty,
      "ahead": $ahead,
      "behind": $behind,
      "last_fetch": "$last_fetch"
    }
REPO_JSON
  )
}

# Build the tracked_repos object
TRACKED=""
FIRST=1
for name in "${REPO_NAMES[@]}"; do
  repo_json=$(gather_repo "$name" 2>/dev/null) || continue
  if [ $FIRST -eq 1 ]; then
    TRACKED="$repo_json"
    FIRST=0
  else
    TRACKED="$TRACKED,
$repo_json"
  fi
done

# Escape hostname for JSON
HOSTNAME_ESCAPED=$(printf '%s' "$RAW_HOST" | sed 's/\\/\\\\/g; s/"/\\"/g')

# Write the heartbeat file
cat > "$HEARTBEAT_FILE" <<HEARTBEAT
{
  "machine_id": "$MACHINE_SLUG",
  "hostname": "$HOSTNAME_ESCAPED",
  "os": "$OS",
  "last_seen": "$TIMESTAMP",
  "tracked_repos": {
$TRACKED
  }
}
HEARTBEAT

echo "Heartbeat written: $HEARTBEAT_FILE"
echo "Machine: $MACHINE_SLUG ($OS)"
cat "$HEARTBEAT_FILE"
