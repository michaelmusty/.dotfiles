# Only if shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Only if not in a tmux window
[ -z "$TMUX" ] || return

# Only if ~/.welcome/remind exists and ~/.hushlogin doesn't
[ -e "$HOME"/.welcome/remind ] || return
! [ -e "$HOME"/.hushlogin ] || return

# Only if rem(1) available
command -v rem >/dev/null 2>&1 || return

# Print reminders with asterisks
rem -hq | sed 's/^/* /'
printf '\n'
