# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window
[ -z "$TMUX" ] || return

# Not if ~/.hushlogin exists
[ -e "$HOME"/.hushlogin ] && return

# Not if ~/.downloads doesn't
[ -f "$HOME"/.downloads ] || return

# Count files in each directory, report if greater than zero
(
    while IFS= read -r dir ; do
        case $dir in
            '#'*) continue ;;
        esac
        [ -d "$dir" ] || continue
        set -- "$dir"/*
        [ -e "$1" ] || shift
        [ "$#" -gt 0 ] || continue
        printf '\nYou have %u unsorted files in %s.\n\n' "$#" "$dir"
    done < "$HOME"/.downloads
)
