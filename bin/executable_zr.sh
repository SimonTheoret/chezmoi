#!/usr/bin/env sh

FILE=$(mktemp)
zellij run -f -c --block-until-exit -- hx "$FILE"
zellij run -f -- fish -c "$(cat "$FILE")"
