# Record a timestamped message to a logfile, defaulting to ~/.clog

# Build the cat(1) command we'll run, wrapping it in rlwrap(1) if available and
# applicable.
if [ "$#" -eq 0 ] && [ -t 0 ] && command -v rlwrap >/dev/null 2>&1 ; then
    set -- rlwrap --history-filename=/dev/null cat -- "${@:--}"
else
    set -- cat -- "${@:--}"
fi

# Write the date, the input, and two dashes to $CLOG, defaulting to ~/.clog.
clog=${CLOG:-"$HOME"/.clog}
{
    date
    "$@"
    printf -- '--\n'
} >> "$clog"
