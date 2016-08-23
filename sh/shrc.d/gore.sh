# Pipe grep(1) output through PAGER; mostly to preserve coloring interactively
# through less(1), but it'll work fine with plain grep(1) and more(1)
gore() {

    # Add --color=always if the terminal has at least 8 colors; we have to add
    # "always" to coax grep(1) into emitting colors even though it can tell its
    # stdout isn't a terminal but a pager
    [ -e "$HOME"/.cache/grep/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=always "$@"

    # Run whatever `grep` gives us; it might be our function wrapper; that's OK
    # Include -n to show line numbers; this is POSIX, which was a nice surprise
    grep -n "$@" |

    # Run the appropriate pager; if it's less(1), we can tack on -R (though my
    # ~/.lesskey does this anyway)
    case $PAGER in
        less) "$PAGER" -R ;;
        *) "$PAGER" ;;
    esac
}
