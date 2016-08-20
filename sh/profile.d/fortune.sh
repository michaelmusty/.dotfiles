# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window
[ -z "$TMUX" ] || return

# Only if ~/.welcome/fortune exists and ~/.hushlogin doesn't
[ -e "$HOME"/.welcome/fortune ] || return
! [ -e "$HOME"/.hushlogin ] || return

# Only if fortune(6) available
command -v fortune >/dev/null 2>&1 || return

# Print from subshell to keep namespace clean
(
    if [ -d "$HOME"/.local/share/games/fortunes ] ; then
        : "${FORTUNE_PATH:="$HOME"/.local/share/games/fortunes}"
    fi
    fortune -s "$FORTUNE_PATH"
    printf '\n'
)
