# Start mpdlrc-notify-send <https://sanctum.geek.nz/cgit/mpdlrc.git/about/>
command -v mpdlrc-notify-send >/dev/null 2>&1 || return
mpdlrc-notify-send &
