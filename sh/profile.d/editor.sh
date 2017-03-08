# Set command-line editor; ed if we've got it (!), but ex will do fine
if command -v ed >/dev/null 2>&1 ; then
    EDITOR=ed
else
    EDITOR=ex
fi
export EDITOR
