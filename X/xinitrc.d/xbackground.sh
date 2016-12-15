# Apply a random background image
command -v feh >/dev/null 2>&1 || return
feh --bg-scale --no-fehbg --randomize -- "${XBACKGROUNDS:-"$HOME"/.xbackgrounds}"
