# Start xbindkeys(1)
command -v xbindkeys >/dev/null 2>&1 || return
(cd -- "$HOME" && xbindkeys -n) &
