#!/bin/bash
# One-command knowledge push for Claudious.
#
# Resolves repo root via `git rev-parse --show-toplevel` so the script works
# from any clone location without platform detection (Windows PC at
# C:\Users\logan\Projects\Claudious, Mac at ~/Documents/GitHub/Claudious-new,
# or any future clone). Must be run from inside a Claudious clone.
#
# Flags:
#   --dry-run   Print what the script would do; do not stage/commit/push.
set -e

DRY_RUN=0
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        -h|--help)
            echo "Usage: $0 [--dry-run]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg" >&2
            echo "Usage: $0 [--dry-run]" >&2
            exit 2
            ;;
    esac
done

REPO_PATH="$(git rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$REPO_PATH" ]; then
    echo "❌ Not in a git repo. Run this script from inside the Claudious clone." >&2
    exit 1
fi

cd "$REPO_PATH"

if [ "$DRY_RUN" -eq 1 ]; then
    echo "[dry-run] REPO_PATH=$REPO_PATH"
fi

# Check for stale files
if [ -d "learnings" ]; then
    STALE=$(find learnings/ -name "*.md" -mtime +7 -type f 2>/dev/null)
    if [ -n "$STALE" ]; then
        echo "⚠️  Stale files (not modified in 7+ days):"
        echo "$STALE"
    fi
fi

# Commit and push if changes exist
DIRS="learnings/ research/ docs/ scout/ evaluations/ queue/ proposals/ retrospectives/ cross-platform/ skills/ digest/ alerts.md"
if ! git diff --quiet $DIRS 2>/dev/null || git ls-files --others --exclude-standard $DIRS 2>/dev/null | grep -q .; then
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "[dry-run] Changes detected in knowledge dirs."
        echo "[dry-run] Would run: git add $DIRS"
        echo "[dry-run] Would run: git commit -m \"docs: auto-sync knowledge files $(date +%Y-%m-%d)\""
        echo "[dry-run] Would run: git push origin main"
    else
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
    fi
else
    echo "ℹ️  No changes to sync."
fi
