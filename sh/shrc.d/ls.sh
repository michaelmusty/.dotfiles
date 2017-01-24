# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping ls(1) with a function at all
[ -d "$HOME"/.cache/ls ] || return

# If the system has already aliased ls(1) for us, like Slackware or OpenBSD
# does, just get rid of it
unalias ls >/dev/null 2>&1

# Discard GNU ls(1) environment variables if the environment set them
unset -v LS_OPTIONS LS_COLORS

# Define function proper
ls() {

    # -F to show trailing indicators of the filetype
    # -q to replace control chars with '?'
    # -x to format entries across, not down
    set -- -Fqx "$@"

    # Add --block-size=K to always show the filesize in kibibytes
    [ -e "$HOME"/.cache/ls/block-size ] &&
        set -- --block-size=1024 "$@"

    # Add --color if the terminal has at least 8 colors
    [ -e "$HOME"/.cache/ls/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=auto "$@"

    # Add --time-style='+%Y-%m-%d %H:%M:%S' to show the date in my preferred
    # (fixed) format
    [ -e "$HOME"/.cache/ls/time-style ] &&
        set -- --time-style='+%Y-%m-%d %H:%M:%S' "$@"

    # Add -G for colorized output if the operating system is FreeBSD
    # We have to check because -G means something else to e.g. GNU ls(1)
    case $OS in
        FreeBSD) set -- -G "$@" ;;
    esac

    # Run ls(1) with the concluded arguments
    command ls "$@"
}
