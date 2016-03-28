# Add a colon prompt to ed when a command is expected rather than text; makes
# it feel a lot more like using ex. Only do this when stdin is a terminal,
# however. Also try and use -v for more verbose error output, and rlwrap(1) if
# it's available.
ed() {

    # Options for ed(1), and a command string in which to wrap the call if
    # appropriate
    local -a opts wrap

    if [[ -t 0 ]] ; then

        # Assemble options for interactive use: colon prompt, and verbose if
        # available (-p is POSIX, but -v is not)
        opts=(-p :)
        if ed -sv - </dev/null >&0 2>&0 ; then
            opts[${#opts[@]}]=-v
        fi

        # Use rlwrap(1) if it's available, but don't throw a fit if it isn't
        if hash rlwrap 2>/dev/null ; then
            wrap=(rlwrap)
        fi
    fi

    # Execute the ed(1) call, in a wrapper if appropriate and with the
    # concluded options
    command "${wrap[@]}" ed "${opts[@]}" "$@"
}
