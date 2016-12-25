# Define function proper
ed() {

    # Don't mess with original call if input not a terminal
    if ! [ -t 0 ] ; then
        command ed "$@"
        return
    fi

    # Add --verbose to explain errors
    [ -e "$HOME"/.cache/ed/verbose ] &&
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
