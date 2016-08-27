# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window
[ -z "$TMUX" ] || return

# Not if ~/.hushlogin exists
[ -e "$HOME"/.hushlogin ] && return

(
    # Only if ~/.welcome/fortune exists
    [ -e "$HOME"/.welcome/fortune ] || exit

    # Only if fortune(6) available
    command -v fortune >/dev/null 2>&1 || exit

    # Show a fortune
    [ -d "$HOME"/.local/share/games/fortunes ] &&
        : "${FORTUNE_PATH:="$HOME"/.local/share/games/fortunes}"
    fortune -s "$FORTUNE_PATH"
    printf '\n'
)
(
    # Only if ~/.welcome/remind exists
    [ -e "$HOME"/.welcome/remind ] || exit

    # Only if rem(1) available
    command -v rem >/dev/null 2>&1 || exit

    # Print reminders with asterisks
    rem -hq | sed 's/^/* /'
    printf '\n'
)
(
    # Only if ~/.welcome/remind verse
    [ -e "$HOME"/.welcome/verse ] || exit

    # Only if verse(1) available
    command -v verse >/dev/null 2>&1 || exit

    # Run verse(1) if we haven't seen it already today (the verses are selected
    # by date); run in a subshell to keep vars out of global namespace
    now=$(date +%Y%m%d)
    last=0
    [ -f "$HOME"/.verse ] &&
        last=$(cat -- "$HOME"/.verse)
    [ "$now" -gt "$last" ] || exit
    verse
    printf '\n'
    printf '%s\n' "$now" > "$HOME"/.verse
)
