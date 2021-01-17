#!/bin/sh

if git diff --cached | grep '^\+' | grep -q 'FIXME'; then
    echo "ERROR: Cannot commit forbidden word 'FIXME'" >&2
    echo "If you know what you are doing you can ignore this temporarily with --no-verify" >&2
    echo "If you want to modify this behavior permanently, see .git/hooks/pre-commit" >&2
    exit 1  # reject
fi
exit 0  # accept