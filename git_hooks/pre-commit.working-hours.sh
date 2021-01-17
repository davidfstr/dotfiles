#!/usr/bin/env bash

WEEKDAY_ORDINAL=`date +"%u"`  # 1=Mon, 6=Sat, 7=Sun
TIME=`date +"%H:%M"`
if [[ "$WEEKDAY_ORDINAL" < "6" ]] && [[ "08:00" < "$TIME" ]] && [[ "$TIME" < "17:00" ]]; then
    echo "ERROR: Avoid contributing to open source during working hours. Consider:" >&2
    echo "(1) throwaway this commit and rewrite it offhours," >&2
    echo "(2) amend the commit to a correct time that is offhours," >&2
    echo "(3) ignore this temporarily with --no-verify, or" >&2
    echo "(4) ignore this permanently by altering .git/hooks/pre-commit" >&2
    exit 1  # reject
fi
exit 0  # accept
