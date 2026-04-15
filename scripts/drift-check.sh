#!/bin/bash
# Drift check: compare asf-graphics-app migrations against Claudious schema/business docs.
# Run monthly or before any migration work.
set -e

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
    CLAUDIOUS="C:/Users/logan/Projects/Claudious"
    ASF="C:/Users/logan/Projects/asf-graphics-app"
else
    CLAUDIOUS="$HOME/Projects/claudious"
    ASF="$HOME/Projects/asf-graphics-app"
fi

MIGRATIONS="$ASF/supabase/migrations"
SCHEMA_DOC="$CLAUDIOUS/docs/schema-state.md"
RULES_DOC="$CLAUDIOUS/docs/business-rules.md"

DRIFT=0

echo "🔍 Drift check — $(date +%Y-%m-%d)"
echo ""

if [ ! -d "$MIGRATIONS" ]; then
    echo "❌ Migrations dir not found: $MIGRATIONS"
    exit 1
fi

# 1. Migrations newer than schema-state.md
if [ ! -f "$SCHEMA_DOC" ]; then
    echo "⚠️  Missing $SCHEMA_DOC — create it to enable schema drift tracking."
    DRIFT=1
else
    NEWER=$(find "$MIGRATIONS" -name "*.sql" -newer "$SCHEMA_DOC" -type f 2>/dev/null)
    if [ -n "$NEWER" ]; then
        echo "⚠️  Migrations newer than schema-state.md (schema doc may be stale):"
        echo "$NEWER" | sed 's|^|   |'
        echo ""
        DRIFT=1
    fi
fi

# 2. Tables/columns in migrations not mentioned in schema doc
if [ -f "$SCHEMA_DOC" ]; then
    OBJECTS=$(grep -hiE 'CREATE TABLE|ALTER TABLE|CREATE TYPE|CREATE INDEX' "$MIGRATIONS"/*.sql 2>/dev/null \
        | sed -E 's/.*(TABLE|TYPE|INDEX)[[:space:]]+(IF NOT EXISTS[[:space:]]+)?"?([a-zA-Z_][a-zA-Z0-9_]*)"?.*/\3/i' \
        | sort -u)
    MISSING=""
    for obj in $OBJECTS; do
        if ! grep -qiw "$obj" "$SCHEMA_DOC" 2>/dev/null; then
            MISSING+="$obj"$'\n'
        fi
    done
    if [ -n "$MISSING" ]; then
        echo "⚠️  Schema objects in migrations but not in schema-state.md:"
        echo "$MISSING" | sed 's|^|   |' | grep -v '^   $'
        echo ""
        DRIFT=1
    fi
fi

# 3. Business-rules doc presence
if [ ! -f "$RULES_DOC" ]; then
    echo "⚠️  Missing $RULES_DOC — create it to enable business-rules drift tracking."
    DRIFT=1
fi

if [ $DRIFT -eq 0 ]; then
    echo "✅ No drift detected."
else
    echo ""
    echo "→ Review above. Update docs or migrations to reconcile."
fi

exit $DRIFT
