#!/bin/sh
# Herdr ports of ~/.config/zellij/layouts/{ed,v}.kdl.
#   layout.sh apply <ed|v>  fill an empty workspace: the new one in a hook, else the current one
#   layout.sh new <ed|v>    open a workspace in the current directory, the hook then fills it
set -eu

herdr=${HERDR_BIN_PATH:-herdr}
mode=$1
layout=$2
next=$HERDR_PLUGIN_STATE_DIR/next-layout

case $layout in
ed | v) ;;
*) echo "unknown layout: $layout" >&2; exit 1 ;;
esac

if [ "$mode" = new ]; then
	cwd=$("$herdr" pane get "$HERDR_PANE_ID" | jq -r '.result.pane | .foreground_cwd // .cwd')
	printf '%s' "$layout" >"$next"
	"$herdr" workspace create --cwd "$cwd" --focus >/dev/null || { rm -f "$next"; exit 1; }
	exit 0
fi

# Event hooks name the new workspace in their payload; actions run in the current one.
if [ -n "${HERDR_PLUGIN_EVENT_JSON:-}" ]; then
	ws=$(printf '%s' "$HERDR_PLUGIN_EVENT_JSON" | jq -r 'first(.. | .workspace_id? | strings)')
	# A recent `new` picked the layout of the workspace it just created
	if [ -f "$next" ]; then
		[ -z "$(find "$next" -mmin -1)" ] || layout=$(cat "$next")
		rm -f "$next"
	fi
else
	ws=${HERDR_WORKSPACE_ID:-}
fi
[ -n "$ws" ] || { echo "no workspace id" >&2; exit 1; }

info=$("$herdr" workspace get "$ws")
if [ "$(printf '%s' "$info" | jq '.result.workspace | .tab_count == 1 and .pane_count == 1')" != true ]; then
	echo "workspace $ws already has a layout, leaving it alone" >&2
	exit 0
fi
tab=$(printf '%s' "$info" | jq -r .result.workspace.active_tab_id)
main=$("$herdr" pane list --workspace "$ws" | jq -r 'first(.. | .pane_id? | strings)')

"$herdr" tab rename "$tab" editor >/dev/null

# ed adds three panes stacked in a column right of the editor, v keeps it alone
if [ "$layout" = ed ]; then
	right=$("$herdr" pane split "$main" --direction right --ratio 0.65 --no-focus | jq -r .result.pane.pane_id)
	middle=$("$herdr" pane split "$right" --direction down --ratio 0.33 --no-focus | jq -r .result.pane.pane_id)
	"$herdr" pane split "$middle" --direction down --ratio 0.5 --no-focus >/dev/null
fi

# One tab per tool, term stays a plain shell
for name in term claude yazi lazygit lazydocker; do
	pane=$("$herdr" tab create --workspace "$ws" --label "$name" --no-focus | jq -r .result.root_pane.pane_id)
	[ "$name" = term ] || "$herdr" pane run "$pane" "$name" >/dev/null
done
