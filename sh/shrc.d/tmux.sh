# Attach to existing tmux session rather than create a new one if possible
tmux() {

    # If given any arguments, just use them as they are
    if [ "$#" -gt 0 ] ; then
        :

    # If a session exists, just attach to it
    elif command tmux has-session 2>/dev/null ; then
        set -- attach-session -d

    # Create a new session with an appropriate name
    else
        set -- new-session -s "${TMUX_SESSION:-default}"
    fi

    # Execute with concluded arguments
    command tmux "$@"
}

# If we have a SHLVL set from one of the shells that does that (bash, ksh93,
# zsh), then set a SHLVL-derived value that takes tmux into account if we
# haven't already. This can be used to show the current SHLVL in the prompt for
# more advanced shells.
if [ -n "$SHLVL" ] && [ -n "$TMUX" ] && [ -z "$TMUX_SHLVL" ] ; then
    TMUX_SHLVL=$((SHLVL - 1))
    export TMUX_SHLVL
fi
