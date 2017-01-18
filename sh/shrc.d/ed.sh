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

    # Add an asterisk prompt (POSIX feature); color it dark green if we can
    set -- -p "$(
        if [ "$(tput colors || tput Co)" -gt 8 ] ; then
            ec=${ED_PROMPT_COLOR:-2}
            tput setaf "$ec" ||
            tput setaf "$ec" 0 0 ||
            tput AF "$ec" ||
            tput AF "$ec" 0 0
            printf %s "${ED_PROMPT:-'*'}"
            tput sgr0 || tput me
        else
            printf %s "${ED_PROMPT:-'*'}"
        fi 2>/dev/null
    )" "$@"

    # Run in rlwrap(1) if available
    set -- ed "$@"
    command -v rlwrap >/dev/null 2>&1 &&
        set -- rlwrap --history-filename=/dev/null "$@"

    # Run determined command
    command "$@"
}
