#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract fields
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
win_size=$(echo "$input" | jq -r '.context_window.context_window_size // 1')
cur_dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')

# If no context usage data, just show model name
if [ -z "$used" ]; then
    echo "$model"
    exit 0
fi

# Build progress bar
bar_width=20
filled=$(echo "$used" | awk '{printf "%.0f", $1 / 100 * 20}')

bar="["
i=0

# Add filled portion (=)
while [ $i -lt $filled ]; do
    bar="${bar}="
    i=$((i+1))
done

# Add empty portion (spaces)
while [ $i -lt $bar_width ]; do
    bar="${bar} "
    i=$((i+1))
done

bar="${bar}]"

# Format percentage to 1 decimal place
pct=$(echo "$used" | awk '{printf "%.1f", $1}')

# Token counts in thousands (1 decimal place)
used_k=$(awk -v t="$in_tokens" 'BEGIN{printf "%.1f", t/1000}')
total_k=$(awk -v t="$win_size" 'BEGIN{printf "%.1f", t/1000}')

# Base line: model name, progress bar, percentage, token counts
line="$model $bar ${pct}% (${used_k}k / ${total_k}k)"

# Git branch segment.
# Resilient by construction: if git is missing/broken or we're not in a repo,
# rev-parse fails and $root is empty, so the segment is simply omitted.
# Skip when the repo root is exactly $HOME.
if [ -n "$cur_dir" ]; then
    root=$(git -C "$cur_dir" rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$root" ] && [ "$root" != "$HOME" ]; then
        branch=$(git -C "$cur_dir" rev-parse --abbrev-ref HEAD 2>/dev/null)
        # Detached HEAD: show first 6 chars of the commit SHA instead.
        if [ "$branch" = "HEAD" ]; then
            branch=$(git -C "$cur_dir" rev-parse --short=6 HEAD 2>/dev/null)
        fi
        [ -n "$branch" ] && line="$line | ⎇ $branch"
    fi
fi

echo "$line"
