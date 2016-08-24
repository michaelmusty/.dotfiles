# Pipe ls(1) output through PAGER; mostly to preserve coloring interactively
# through less(1), but it'll work fine with plain ls(1) and more(1)
lore() {

    # Add --color=always if the terminal has at least 8 colors; we have to add
    # "always" to coax ls(1) into emitting colors even though it can tell its
    # stdout isn't a terminal but a pager
    [ -e "$HOME"/.cache/ls/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=always "$@"

    # Prefer -A/--almost-all (exclude "." and "..") if available
    if [ -e "$HOME"/.cache/ls/almost-all ] ; then
        set -- -Al "$@"
    else
        set -- -al "$@"
    fi

    # Run whatever `ls` gives us; it might be our function wrapper; that's OK
    # shellcheck disable=SC2012
    ls "$@" |

    # Run the appropriate pager; if it's less(1), we can tack on -R (though my
    # ~/.lesskey does this anyway)
    case $PAGER in
        less) "$PAGER" -R ;;
        *) "$PAGER" ;;
    esac
}
