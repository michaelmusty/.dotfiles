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
    [ -e "$HOME"/.cache/sh/opt/ed/verbose ] &&
        set -- --verbose "$@"

    # Add an asterisk prompt (POSIX feature)
    set -- -p\* "$@"

    # Run in rlwrap(1) if available
    set -- ed "$@"
    command -v rlwrap >/dev/null 2>&1 &&
        set -- rlwrap --history-filename=/dev/null "$@"

    # Run determined command
    command "$@"
}
