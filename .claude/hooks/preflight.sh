#!/usr/bin/env bash
# Session start preflight — Claudious
# Fail-open: infra errors exit 0 so CC stays usable. Only drift conditions halt.

set +e

CURRENT_REPO="Claudious"

CLAUDIOUS_PATH=""
for p in "$HOME/Documents/GitHub/Claudious" "$HOME/Projects/Claudious" "$HOME/Projects/claudious"; do
  [ -d "$p/.git" ] && CLAUDIOUS_PATH="$p" && break
done

if [ -z "$CLAUDIOUS_PATH" ] || [ ! -x "$CLAUDIOUS_PATH/scripts/update-heartbeat.sh" ]; then
  echo "[WARN] preflight-degraded: Claudious or heartbeat script not found"
  exit 0
fi

"$CLAUDIOUS_PATH/scripts/update-heartbeat.sh" --preflight "$CURRENT_REPO"
EXIT_CODE=$?

if [ "$EXIT_CODE" -ge 2 ] && [ "$EXIT_CODE" -le 4 ]; then
  exit "$EXIT_CODE"
fi
exit 0
