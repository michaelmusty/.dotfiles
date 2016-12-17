# Start dunst(1) to display libnotify messages
command -v dunst >/dev/null 2>&1 || return
dunst &
