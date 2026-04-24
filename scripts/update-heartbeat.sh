#!/usr/bin/env bash
# Updates this machine's heartbeat in .claudious-heartbeat/
# Safe to run from anywhere — cds to Claudious repo root first.
#
# USAGE
#   scripts/update-heartbeat.sh                         # manual: write heartbeat, print JSON, exit 0
#   scripts/update-heartbeat.sh --preflight <repo-name> # hook mode: write, commit+push, fetch current repo,
#                                                        # evaluate halt conditions, print status line
#
# Exit codes (preflight mode only):
#   0 = clean / warnings only / infra-degraded (fail-open)
#   2 = STALE REPO (current repo behind origin)
#   3 = STALE WIP (>=5 dirty, oldest >24h)
#   4 = SIBLING AHEAD (other machine pushed <4h ago, this machine behind)

# NOTE: manual mode keeps set -e for existing-behavior fidelity; preflight mode
# explicitly swaps to set +e and wraps sensitive steps to preserve fail-open.
set -e

PREFLIGHT_MODE=0
CURRENT_REPO=""
while [ $# -gt 0 ]; do
  case "$1" in
    --preflight) PREFLIGHT_MODE=1; CURRENT_REPO="${2:-}"; shift 2 ;;
    --verbose)   VERBOSE=1; shift ;;
    *)           shift ;;
  esac
done

# Locate Claudious repo root
if [ "$PREFLIGHT_MODE" = "1" ]; then
  set +e
  REPO_ROOT=""
  for p in "$HOME/Documents/GitHub/Claudious" "$HOME/Projects/Claudious" "$HOME/Projects/claudious"; do
    [ -d "$p/.git" ] && REPO_ROOT="$p" && break
  done
  if [ -z "$REPO_ROOT" ]; then
    echo "⚠️ preflight-degraded: Claudious repo not found"
    exit 0
  fi
else
  REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo" >&2; exit 1; }
fi
cd "$REPO_ROOT" 2>/dev/null || { [ "$PREFLIGHT_MODE" = "1" ] && { echo "⚠️ preflight-degraded: cd Claudious failed"; exit 0; }; exit 1; }

# Verify we're in Claudious (sanity check, manual mode only — preflight trusts path lookup)
if [ "$PREFLIGHT_MODE" = "0" ]; then
  if ! grep -q "Claudious" CLAUDE.md 2>/dev/null && ! grep -q "claudious" README.md 2>/dev/null; then
    echo "ERROR: This doesn't appear to be the Claudious repo (no Claudious marker in CLAUDE.md or README.md)" >&2
    exit 1
  fi
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

# Oldest-dirty-file age in hours for a given repo path (0 if clean or can't compute)
oldest_dirty_h() {
  local repo="$1"
  local oldest_epoch="" now
  now=$(date +%s)
  local paths
  paths=$(cd "$repo" 2>/dev/null && git status --porcelain 2>/dev/null | awk '{print substr($0,4)}') || return 0
  [ -z "$paths" ] && { echo 0; return 0; }
  while IFS= read -r rel; do
    [ -z "$rel" ] && continue
    local full="$repo/$rel"
    [ -e "$full" ] || continue
    local mtime
    mtime=$(stat -c %Y "$full" 2>/dev/null || stat -f %m "$full" 2>/dev/null || echo "")
    [ -z "$mtime" ] && continue
    if [ -z "$oldest_epoch" ] || [ "$mtime" -lt "$oldest_epoch" ]; then
      oldest_epoch="$mtime"
    fi
  done <<EOF_PATHS
$paths
EOF_PATHS
  [ -z "$oldest_epoch" ] && { echo 0; return 0; }
  echo $(( (now - oldest_epoch) / 3600 ))
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

if [ "$PREFLIGHT_MODE" = "0" ]; then
  echo "Heartbeat written: $HEARTBEAT_FILE"
  echo "Machine: $MACHINE_SLUG ($OS)"
  cat "$HEARTBEAT_FILE"
  exit 0
fi

# -------------------- PREFLIGHT MODE FROM HERE --------------------
# All remaining work is wrapped for fail-open. Any uncaught error exits 0 with a warning.
set +e

preflight_main() {
  local current_repo="$1"

  # 1) Auto-commit + push heartbeat to Claudious main (best-effort)
  if [ -n "$(git -C "$REPO_ROOT" status --porcelain .claudious-heartbeat/ 2>/dev/null)" ]; then
    local branch
    branch=$(git -C "$REPO_ROOT" branch --show-current 2>/dev/null)
    if [ "$branch" = "main" ]; then
      git -C "$REPO_ROOT" add ".claudious-heartbeat/${MACHINE_SLUG}.json" >/dev/null 2>&1
      local claudious_sha
      claudious_sha=$(git -C "$REPO_ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")
      git -C "$REPO_ROOT" commit -m "heartbeat: ${MACHINE_SLUG} @ ${claudious_sha}" --quiet >/dev/null 2>&1
      git -C "$REPO_ROOT" push origin main --quiet >/dev/null 2>&1 || echo "⚠️ heartbeat push failed (continuing)"
    fi
  fi

  # 2) Locate current repo, fetch
  local current_path=""
  case "$current_repo" in
    Claudious)         current_path="$REPO_ROOT" ;;
    asf-graphics-app)  for p in "$HOME_DIR/Documents/GitHub/asf-graphics-app" "$HOME_DIR/Projects/asf-graphics-app"; do
                         [ -d "$p/.git" ] && current_path="$p" && break
                       done ;;
    courtside-pro)     for p in "$HOME_DIR/Documents/GitHub/courtside-pro" "$HOME_DIR/Documents/courtside-pro" "$HOME_DIR/Projects/courtside-pro"; do
                         [ -d "$p/.git" ] && current_path="$p" && break
                       done ;;
    *)                 echo "⚠️ preflight-degraded: unknown current repo '$current_repo'"; return 0 ;;
  esac
  if [ -z "$current_path" ]; then
    echo "⚠️ preflight-degraded: $current_repo not found on this machine"
    return 0
  fi

  git -C "$current_path" fetch --all --prune --quiet 2>/dev/null

  # 3) Re-read current repo stats post-fetch
  local cur_branch cur_dirty cur_behind cur_ahead cur_oldest_h
  cur_branch=$(git -C "$current_path" branch --show-current 2>/dev/null || echo "detached")
  cur_dirty=$(git -C "$current_path" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  cur_ahead=$(git -C "$current_path" rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
  cur_behind=$(git -C "$current_path" rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
  cur_oldest_h=$(oldest_dirty_h "$current_path")

  # 4) Sibling-ahead detection via node (universal; python3 is a Windows Store stub on some PCs)
  local sib_name="" sib_age_h=9999 sib_repo_behind=0
  local sib_info
  sib_info=$(HEARTBEAT_DIR="$HEARTBEAT_DIR" MACHINE_SLUG="$MACHINE_SLUG" CURRENT_REPO="$current_repo" node -e '
const fs=require("fs"),path=require("path");
const d=process.env.HEARTBEAT_DIR, me=process.env.MACHINE_SLUG, cur=process.env.CURRENT_REPO;
let best=null;
const now=Date.now();
for (const f of fs.readdirSync(d).filter(x=>x.endsWith(".json"))) {
  const stem=f.replace(/\.json$/,"");
  if (stem===me) continue;
  let data; try { data=JSON.parse(fs.readFileSync(path.join(d,f),"utf8")); } catch { continue; }
  if (!data.last_seen) continue;
  const ts=Date.parse(data.last_seen); if (Number.isNaN(ts)) continue;
  const ageH=(now-ts)/3600000;
  const entry=(data.tracked_repos||{})[cur];
  if (!entry) continue;
  if (best===null || ageH<best[0]) best=[ageH, data.machine_id||stem, entry.head_sha||""];
}
if (best===null) console.log("NONE");
else console.log(`${best[0].toFixed(1)}\t${best[1]}\t${best[2]}`);
' 2>/dev/null)
  if [ -n "$sib_info" ] && [ "$sib_info" != "NONE" ]; then
    sib_age_h=$(printf '%s' "$sib_info" | awk -F'\t' '{print $1}')
    sib_name=$(printf '%s' "$sib_info" | awk -F'\t' '{print $2}')
    local sib_sha
    sib_sha=$(printf '%s' "$sib_info" | awk -F'\t' '{print $3}')
    if [ -n "$sib_sha" ]; then
      git -C "$current_path" cat-file -e "$sib_sha" 2>/dev/null
      if [ $? -eq 0 ]; then
        sib_repo_behind=$(git -C "$current_path" rev-list --count HEAD.."$sib_sha" 2>/dev/null || echo 0)
      fi
    fi
  fi

  # 5) Halt evaluation (priority: stale repo > stale WIP > sibling ahead)
  local per_repo_sym=""
  case "$cur_behind" in 0) per_repo_sym="✅" ;; *) per_repo_sym="⚠️${cur_behind}↓" ;; esac
  [ "$cur_dirty" != "0" ] && per_repo_sym="⚠️${cur_dirty}dirty"
  [ "$cur_ahead" != "0" ] && [ "$cur_behind" = "0" ] && [ "$cur_dirty" = "0" ] && per_repo_sym="⚠️${cur_ahead}↑"

  # Build other-repo status string via node
  local others_str=""
  others_str=$(HEARTBEAT_FILE="$HEARTBEAT_FILE" node -e '
const fs=require("fs");
let data; try { data=JSON.parse(fs.readFileSync(process.env.HEARTBEAT_FILE,"utf8")); } catch { process.exit(0); }
const order=["Claudious","asf-graphics-app","courtside-pro"];
const short={Claudious:"Claudious","asf-graphics-app":"asf","courtside-pro":"courtside"};
const parts=[];
for (const name of order) {
  const e=(data.tracked_repos||{})[name];
  const lbl=short[name];
  if (!e) { parts.push(`${lbl} ➖`); continue; }
  const behind=e.behind||0, ahead=e.ahead||0, dirty=e.dirty_files||0;
  let sym;
  if (behind===0 && ahead===0 && dirty===0) sym="✅";
  else if (dirty>0) sym=`⚠️${dirty}dirty`;
  else if (behind>0) sym=`⚠️${behind}↓`;
  else sym=`⚠️${ahead}↑`;
  parts.push(`${lbl} ${sym}`);
}
console.log(parts.join(" "));
' 2>/dev/null)

  # Sibling summary
  local sib_summary="no sibling heartbeat yet"
  if [ -n "$sib_name" ]; then
    local sib_age_int
    sib_age_int=$(printf '%.0f' "$sib_age_h" 2>/dev/null || echo "?")
    sib_summary="sibling ${sib_name} fresh ${sib_age_int}h"
    # Non-halting warning if sibling >48h
    awk -v a="$sib_age_h" 'BEGIN{exit !(a>48)}' 2>/dev/null && echo "⚠️ ${sib_name} stale (last seen ${sib_age_int}h ago)"
  fi

  # Halt 2 — STALE REPO (behind)
  if [ "$cur_behind" != "0" ]; then
    echo "🛑 STALE REPO — ${current_repo} is ${cur_behind} commits behind origin/main. Pull before editing."
    echo "🫀 ${MACHINE_SLUG} | ${others_str} | ${sib_summary}"
    return 2
  fi

  # Halt 3 — STALE WIP (>=5 dirty AND oldest >24h)
  if [ "$cur_dirty" -ge 5 ] 2>/dev/null && [ "$cur_oldest_h" -gt 24 ] 2>/dev/null; then
    echo "🛑 STALE WIP — ${current_repo} has ${cur_dirty} uncommitted files, oldest ${cur_oldest_h}h old. Commit, stash, or clean before new work."
    echo "🫀 ${MACHINE_SLUG} | ${others_str} | ${sib_summary}"
    return 3
  fi

  # Halt 4 — SIBLING AHEAD (sibling pushed <4h AND this machine behind on current repo)
  if [ -n "$sib_name" ] && awk -v a="$sib_age_h" 'BEGIN{exit !(a<4)}' 2>/dev/null && [ "${sib_repo_behind:-0}" -gt 0 ] 2>/dev/null; then
    local sib_age_int
    sib_age_int=$(printf '%.0f' "$sib_age_h" 2>/dev/null || echo "?")
    echo "🛑 SIBLING AHEAD — ${sib_name} pushed ${sib_repo_behind} commits to ${current_repo} ${sib_age_int}h ago. Pull before editing."
    echo "🫀 ${MACHINE_SLUG} | ${others_str} | ${sib_summary}"
    return 4
  fi

  # Clean
  echo "🫀 ${MACHINE_SLUG} | ${others_str} | ${sib_summary}"
  return 0
}

preflight_main "$CURRENT_REPO"
exit $?
