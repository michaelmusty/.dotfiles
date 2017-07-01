# Start an mpd process if one isn't already running
command -v mpd >/dev/null 2>&1 || return
[ -s "$HOME"/.mpd/pid ] || mpd
