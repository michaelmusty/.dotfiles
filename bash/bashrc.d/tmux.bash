# Attach to existing tmux session rather than create a new one if possible
tmux() {

    # If any arguments to function, just run tmux as normal with them
    if (($# > 0)); then
        command tmux "$@"

    # If no arguments, attempt to attach to an existing session; if that fails,
    # run the tmux binary with no arguments, which by default creates a new
    # session
    elif ! command tmux attach -d 2>/dev/null; then
        command tmux
    fi
}

