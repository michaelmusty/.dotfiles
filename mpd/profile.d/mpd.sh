# Start an mpd process if one isn't already running
[ -s "$HOME"/.mpd/pid ] || mpd
