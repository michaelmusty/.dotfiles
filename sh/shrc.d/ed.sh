# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping ed(1) with a function at all
[ -d "$HOME"/.cache/sh/opt/ed ] || return

# Define function proper
ed() {

    # Don't mess with original call if input not a terminal
    if ! [ -t 0 ] ; then
        command ed "$@"
        return
    fi

    # Add --verbose to explain errors
    if [ -e "$HOME"/.cache/sh/opt/ed/verbose ] ; then
        set -- --verbose "$@"
    fi

    # Add an asterisk prompt (POSIX feature)
    set -- -p\* "$@"

    # Run in rlwrap(1) if available
    set -- ed "$@"
    if command -v rlwrap >/dev/null 2>&1 ; then
        set -- rlwrap --history-filename=/dev/null "$@"
    fi

    # Run determined command
    command "$@"
}
