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
    lc=0
    while IFS= read -r dir ; do
        case $dir in
            '#'*) continue ;;
        esac
        [ -d "$dir" ] || continue
        set -- "$dir"/*
        [ -e "$1" ] || shift
        [ "$#" -gt 0 ] || continue
        printf 'You have %u unsorted files in %s.\n' "$#" "$dir"
        lc=$((lc+1))
    done < "$HOME"/.downloads
    [ "$((lc > 0))" -eq 1 ] && printf '\n'
)
