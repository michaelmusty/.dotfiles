# Fire up bc(1), hushing it if it looks like GNU
[ -e "$HOME"/.cache/sh/opt/bc/quiet ] && set -- --quiet "$@"
exec bc "$@"
