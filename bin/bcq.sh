# Fire up bc(1), hushing it if it looks like GNU
if [ -e "$HOME"/.cache/sh/opt/bc/quiet ] ; then
    set -- --quiet "$@"
fi
exec bc "$@"
