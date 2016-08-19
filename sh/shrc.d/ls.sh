# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping ls(1) with a function at all
[ -d "$HOME"/.cache/ls ] || return

# Define function proper
ls() {

    # Add --color if the terminal has at least 8 colors
    [ -e "$HOME"/.cache/ls/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=auto "$@"

    # Run ls(1) with the concluded arguments
    command ls "$@"
}
