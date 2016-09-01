# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window
[ -z "$TMUX" ] || return

# Not if ~/.hushlogin exists
[ -e "$HOME"/.hushlogin ] && return

# Run all of this in a subshell to clear it away afterwards
(
    # Temporary helper function
    welcome() {
        [ -e "$HOME"/.welcome/"$1" ] || return
        command -v "$1" >/dev/null 2>&1 || return
    }

    # Show a fortune
    if welcome fortune ; then
        [ -d "$HOME"/.local/share/games/fortunes ] &&
            : "${FORTUNE_PATH:="$HOME"/.local/share/games/fortunes}"
        fortune -s "$FORTUNE_PATH"
        printf '\n'
    fi

    # Print today's reminders with asterisks
    if welcome rem ; then
        rem -hq | sed 's/^/* /'
        printf '\n'
    fi

    # Run verse(1) if we haven't seen it already today
    if welcome verse ; then
        [ -f "$HOME"/.verse ] && read -r last <"$HOME"/.verse
        now=$(date +%Y%m%d)
        if [ "$now" -gt "${last:-0}" ] ; then
            verse
            printf '\n'
            printf '%s\n' "$now" >"$HOME"/.verse
        fi
    fi
)
