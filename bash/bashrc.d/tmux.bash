# Attach to existing tmux session rather than create a new one if possible
function tmux {
    if [[ -n "$@" ]]; then
        command tmux "$@"
    else
        command tmux attach -d &>/dev/null || command tmux
    fi
}

