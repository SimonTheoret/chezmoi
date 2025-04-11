#!/usr/bin/env sh

FILE="$HOME/bin/eee"
if [ -f "$FILE" ]; then
    if [ "$(stat -c %a "$FILE")" != "755" ] ; then
        chmod 755 "$FILE"
    fi
fi
