#!/usr/bin/env bash

if [[ "$IGNORE_WORKING_HOURS" != "1" ]]; then
    WORK_TZ=America/Los_Angeles  # Pacific Time
    WEEKDAY_ORDINAL=$(TZ=$WORK_TZ date +"%u")  # 1=Mon, 6=Sat, 7=Sun
    TIME=$(TZ=$WORK_TZ date +"%H:%M")
    if [[ "$WEEKDAY_ORDINAL" < "6" ]] && [[ "07:00" < "$TIME" ]] && [[ "$TIME" < "15:00" ]]; then
        echo "ERROR: Avoid contributing to open source during working hours. Consider:" >&2
        echo "(1) throwaway this commit and rewrite it offhours," >&2
        echo "(2) amend the commit to a correct time that is offhours," >&2
        echo "(3) ignore this temporarily with: export IGNORE_WORKING_HOURS=1, or" >&2
        echo "(4) ignore this and other hooks temporarily with --no-verify, or" >&2
        echo "(5) ignore this permanently by altering .git/hooks/pre-commit" >&2
        exit 1  # reject
    fi
fi
exit 0  # accept
