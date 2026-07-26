#!/usr/bin/env fish

set FILE $(mktemp)
set LOGFILE "$HOME/_compilation.log"

set read_cmd "read -S -P '\"$PWD\"
Compilation: '"
echo "=========" >>$LOGFILE
echo "FILE: $FILE"

if test -n $__HELIX_LAST_CMD_FILE
    set default_cmd "$(cat $__HELIX_LAST_CMD_FILE)"
    if test $(string length $default_cmd) -gt 0
        set read_cmd "$read_cmd -c \"$default_cmd\""
        echo "The read command is '$read_cmd'" >>$LOGFILE
    else
        echo "The command inside `__HELIX_LAST_CMD_FILE` is empty: '$default_cmd' " >>$LOGFILE
    end
else
    echo "Variable `__HELIX_LAST_CMD_FILE` is empty or does not exist." >>$LOGFILE
end

set PANE_1_Id $(zellij run -f --block-until-exit -c -n compilation -- fish -c "echo ($read_cmd) >>\"$FILE\"")

set N $(cat $FILE | wc -w )

if test $N -gt 0
    set PANE_2_Id $(zellij run -f --blocking -- fish -c "$(cat "$FILE")")
else
    echo "Got empty file: $FILE" >>$LOGFILE
    echo "File's content: $(cat $FILE)" >>$LOGFILE
    echo "=========" >>$LOGFILE
    exit 1
end

set -U __HELIX_LAST_CMD_FILE "$FILE"
