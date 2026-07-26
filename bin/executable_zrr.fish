#!/usr/bin/env fish

set FILE "$__HELIX_LAST_CMD_FILE"
set LOGFILE "$HOME/_compilation.log"

if test -z $__HELIX_LAST_CMD_FILE
    echo "Variable `__HELIX_LAST_CMD_FILE` is empty or does not exist." >>$LOGFILE
    exit 1
end

set N $(cat $FILE | wc -w )

if test $N -gt 0
    set PANE_2_Id $(zellij run -f --blocking -- fish -c "$(cat "$FILE")")
else
    echo "Got empty file: $FILE" >>$LOGFILE
    echo "File's content: $(cat $FILE)" >>$LOGFILE
    echo "=========" >>$LOGFILE
    exit 1
end
