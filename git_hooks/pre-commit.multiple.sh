#!/usr/bin/env bash

# Allow multiple hooks.
#
# To use it copy this script with executable permission in ".git/hooks/hook-name"
# where hook-name is the name of the hook (see man githooks to know available hooks).
# Then place your scripts with executable permission in ".git/hooks/hook-name.d/".
# 
# Credit: https://gist.github.com/damienrg/411f63a5120206bb887929f4830ad0d0

hook_type=${BASH_SOURCE##*/}

case "$hook_type" in
    applypatch-msg \
        |commit-msg \
        |fsmonitor-watchman \
        |post-checkout \
        |post-commit \
        |post-merge \
        |post-update \
        |pre-applypatch \
        |pre-commit \
        |prepare-commit-msg \
        |pre-push \
        |pre-rebase \
        |pre-receive \
        |update)
        IFS= read -rd '' stdin
        for file in "${BASH_SOURCE[0]}.d"/*; do
            "./$file" "$@" <<<"$stdin" || exit 2
        done
        exit 0
        ;;
    *)
        echo "unknown hook type: $hook_type"
        exit 2
        ;;
esac