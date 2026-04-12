#!/bin/bash
# Weekly config backup to claudious/snapshots/
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/OneDrive/Documents/GitHub/Claudious"
    HOME_PATH="C:/Users/logan"
    PROJECTS_PATH="C:/Users/logan/Projects"
    CP_PATH="C:/Users/logan/courtside-pro"
else
    REPO_PATH="$HOME/Projects/claudious"
    HOME_PATH="$HOME"
    PROJECTS_PATH="$HOME/Projects"
    CP_PATH="$HOME/Projects/courtside-pro"
fi

DATE=$(date +%Y-%m-%d)
DEST="$REPO_PATH/snapshots/$DATE"
mkdir -p "$DEST"

# Global Claude config
cp "$HOME_PATH/.claude/CLAUDE.md" "$DEST/global-CLAUDE.md" 2>/dev/null && echo "✅ global CLAUDE.md" || true
cp "$HOME_PATH/.claude/settings.json" "$DEST/global-settings.json" 2>/dev/null && echo "✅ global settings.json" || true
[ -d "$HOME_PATH/.claude/skills/" ] && cp -r "$HOME_PATH/.claude/skills/" "$DEST/global-skills/" && echo "✅ global skills" || true
[ -d "$HOME_PATH/.claude/agents/" ] && cp -r "$HOME_PATH/.claude/agents/" "$DEST/global-agents/" && echo "✅ global agents" || true

# Per-project configs
for project in asf-graphics-app; do
    PPATH="$PROJECTS_PATH/$project"
    if [ -d "$PPATH/.claude" ]; then
        mkdir -p "$DEST/$project"
        cp -r "$PPATH/.claude/" "$DEST/$project/.claude/" 2>/dev/null || true
        cp "$PPATH/CLAUDE.md" "$DEST/$project/CLAUDE.md" 2>/dev/null || true
        echo "✅ $project"
    fi
done

# Courtside Pro (different path on PC)
if [ -d "$CP_PATH/.claude" ]; then
    mkdir -p "$DEST/courtside-pro"
    cp -r "$CP_PATH/.claude/" "$DEST/courtside-pro/.claude/" 2>/dev/null || true
    cp "$CP_PATH/CLAUDE.md" "$DEST/courtside-pro/CLAUDE.md" 2>/dev/null || true
    echo "✅ courtside-pro"
fi

cd "$REPO_PATH"
git add snapshots/
git commit -m "backup: config snapshot $DATE"
git push origin main
echo "✅ Config backed up to snapshots/$DATE"
