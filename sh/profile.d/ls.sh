# Test that we have metadata about what options this system's ls(1) supports,
# and try to create it if not
(
    # Create a directory to hold metadata about ls(1)
    lcd=$HOME/.cache/ls
    if ! [ -d "$lcd" ] ; then
        mkdir -p -- "$lcd" || exit
    fi

    # Write ls(1)'s --help output to a file, even if it's empty
    if ! [ -f "$lcd"/help ] ; then
        ls --help >"$lcd"/help 2>/dev/null || exit

        # Iterate through some useful options and create files to show they're
        # available
        if grep -q -- --color "$lcd"/help ; then
            touch -- "$lcd"/color || exit
        fi
    fi
) || return

# Run dircolors(1) to export LS_COLORS if available and appropriate
if [ -e "$HOME"/.cache/ls/color ] ; then
    if command -v dircolors >/dev/null ; then
        if [ -r "$HOME"/.dircolors ] ; then
            eval "$(dircolors --sh -- "$HOME"/.dircolors)"
        else
            eval "$(dircolors --sh)"
        fi
    fi
fi
