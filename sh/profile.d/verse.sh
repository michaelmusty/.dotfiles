# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window on this machine
[ -z "$TMUX" ] || return

# Only if ~/.welcome/verse exists and ~/.hushlogin doesn't
[ -e "$HOME"/.welcome/verse ] || return
! [ -e "$HOME"/.hushlogin ] || return

# Only if verse(1) available
command -v verse >/dev/null 2>&1 || return

# Run verse(1) if we haven't seen it already today (the verses are selected by
# date); run in a subshell to keep vars out of global namespace
(
    now=$(date +%Y-%m-%d)
    if [ -f "$HOME"/.verse ] ; then
        last=$(cat -- "$HOME"/.verse)
    fi
    [ "$now" \> "$last" ] || exit
    verse
    printf '\n'
    printf '%s\n' "$now" > "$HOME"/.verse
)
