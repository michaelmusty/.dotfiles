# Attach to existing tmux session rather than create a new one if possible
tmux() {
    if [[ -n "$@" ]]; then
        command tmux "$@"
    else
        command tmux attach -d &>/dev/null || command tmux
    fi
}

