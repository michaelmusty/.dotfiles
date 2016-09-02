# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping ls(1) with a function at all
[ -d "$HOME"/.cache/ls ] || return

# Define function proper
ls() {

    # Add --block-size=K to always show the filesize in kibibytes
    [ -e "$HOME"/.cache/ls/block-size ] &&
        set -- --block-size=1024 "$@"

    # Add --classify to show trailing indicators of the filetype
    [ -e "$HOME"/.cache/ls/classify ] &&
        set -- --classify "$@"

    # Add --color if the terminal has at least 8 colors
    [ -e "$HOME"/.cache/ls/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=auto "$@"

    # Add --format=horizontal to print entries in a saner way
    [ -e "$HOME"/.cache/ls/format ] &&
        set -- --format=horizontal "$@"

    # Add --hide-control-chars if present; we always want this interactively,
    # even if the output is to a pager; we shouldn't be trying to script ls(1)
    # output anyway
    [ -e "$HOME"/.cache/ls/hide-control-chars ] &&
        set -- --hide-control-chars "$@"

    # Add --time-style='+%Y-%m-%d %H:%M:%S' to show trailing indicators of the
    # filetype
    [ -e "$HOME"/.cache/ls/time-style ] &&
        set -- --time-style='+%Y-%m-%d %H:%M:%S' "$@"

    # Run ls(1) with the concluded arguments
    command ls "$@"
}
