# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping bc(1) with a function at all
[ -d "$HOME"/.cache/sh/opt/bc ] || return

# Define function proper
bc() {

    # Add --quiet to stop the annoying welcome banner
    [ -e "$HOME"/.cache/sh/opt/bc/quiet ] &&
        set -- --quiet "$@"

    # Run bc(1) with the concluded arguments
    command bc "$@"
}
