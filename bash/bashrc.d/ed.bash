# Add a colon prompt to ed when a command is expected rather than text; makes
# it feel a lot more like using ex. Only do this when stdin is a terminal,
# however. Also try and use -v for more verbose error output, and rlwrap(1) if
# it's available.
ed() {

    # We're only adding options if input is from a terminal
    if [[ -t 0 ]] ; then

        # Colon prompt (POSIX)
        set -- -p : "$@"

        # Verbose if availble (not POSIX)
        if ed -sv - </dev/null >&0 2>&0 ; then
            set -- -v "$@"
        fi
    fi

    # Execute the ed(1) call, in a wrapper if appropriate and with the
    # concluded options
    if [[ -t 0 ]] && hash rlwrap 2>/dev/null ; then
        command rlwrap ed "$@"
    else
        command ed "$@"
    fi
}
