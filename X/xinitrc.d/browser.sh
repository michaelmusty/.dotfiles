# Browser within X is Firefox
command -v firefox >/dev/null 2>&1 || return
BROWSER=firefox
export BROWSER
