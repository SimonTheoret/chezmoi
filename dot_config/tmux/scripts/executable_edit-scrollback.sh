#!/bin/sh
# Open the scrollback captured in the "scrollback" buffer in $EDITOR
# (zellij EditScrollback). Bound to `e` in copy mode, see tmux.conf.

file=$(mktemp "${TMPDIR:-/tmp}/tmux-scrollback.XXXXXX") || exit 1
trap 'rm -f "$file"' EXIT

tmux save-buffer -b scrollback "$file" && tmux delete-buffer -b scrollback
${EDITOR:-vi} "$file"
