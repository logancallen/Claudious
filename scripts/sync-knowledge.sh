#!/bin/bash
# One-command knowledge push for Claudious
set -e

# Detect machine
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    REPO_PATH="C:/Users/logan/Projects/Claudious"
else
    REPO_PATH="$HOME/Projects/claudious"
fi

cd "$REPO_PATH"

# Check for stale files
STALE=$(find learnings/ -name "*.md" -mtime +7 -type f 2>/dev/null)
if [ -n "$STALE" ]; then
    echo "⚠️  Stale files (not modified in 7+ days):"
    echo "$STALE"
fi

# Commit and push if changes exist
DIRS="learnings/ research/ docs/ scout/ evaluations/ queue/ proposals/ retrospectives/ cross-platform/ skills/ digest/ alerts.md"
if ! git diff --quiet $DIRS 2>/dev/null || git ls-files --others --exclude-standard $DIRS 2>/dev/null | grep -q .; then
    git add $DIRS
    git commit -m "docs: auto-sync knowledge files $(date +%Y-%m-%d)"
    git push origin main
    echo ""
    echo "✅ Claudious synced to main."
    echo "📋 Click Sync in ALL connected Claude Project UIs:"
    echo "   - ASF Graphics Claude Project"
    echo "   - Courtside Pro Claude Project"
    echo "   - Court Designer Claude Project"
    echo "   - GE Diesel Claude Project"
    echo "   - Genesis Framework Claude Project"
    echo "   - Claude Mastery Lab Claude Project"
    echo "   - Claudious Claude Project"
else
    echo "ℹ️  No changes to sync."
fi
