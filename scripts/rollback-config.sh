#!/bin/bash
# Restore Claude config from a snapshot
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/OneDrive/Documents/GitHub/Claudious"
    HOME_PATH="C:/Users/logan"
else
    REPO_PATH="$HOME/Projects/claudious"
    HOME_PATH="$HOME"
fi

if [ -z "$1" ]; then
    echo "Usage: bash scripts/rollback-config.sh YYYY-MM-DD"
    echo ""
    echo "Available snapshots:"
    ls "$REPO_PATH/snapshots/"
    exit 1
fi

DATE="$1"
SNAPSHOT="$REPO_PATH/snapshots/$DATE"

if [ ! -d "$SNAPSHOT" ]; then
    echo "❌ No snapshot found for $DATE"
    echo "Available: $(ls $REPO_PATH/snapshots/)"
    exit 1
fi

echo "⚠️  Restoring Claude config from $DATE snapshot..."
echo "This will overwrite current ~/.claude/ config files."
read -p "Type 'yes' to confirm: " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 0
fi

# Restore
[ -f "$SNAPSHOT/global-CLAUDE.md" ] && cp "$SNAPSHOT/global-CLAUDE.md" "$HOME_PATH/.claude/CLAUDE.md" && echo "✅ global CLAUDE.md restored"
[ -f "$SNAPSHOT/global-settings.json" ] && cp "$SNAPSHOT/global-settings.json" "$HOME_PATH/.claude/settings.json" && echo "✅ global settings.json restored"
[ -d "$SNAPSHOT/global-skills/" ] && cp -r "$SNAPSHOT/global-skills/." "$HOME_PATH/.claude/skills/" && echo "✅ global skills restored"
[ -d "$SNAPSHOT/global-agents/" ] && cp -r "$SNAPSHOT/global-agents/." "$HOME_PATH/.claude/agents/" && echo "✅ global agents restored"

echo ""
echo "✅ Rollback complete from snapshot $DATE"
echo "Verify restored files and restart Claude Code."
