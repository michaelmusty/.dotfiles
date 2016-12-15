# Start urxvtd(1)
command -v urxvtd >/dev/null 2>&1 || return
urxvtd -o -q &
