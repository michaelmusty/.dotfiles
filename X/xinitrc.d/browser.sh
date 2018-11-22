# Choose a GUI browser with some rough heuristics

# If Firefox is available, start by assuming that
if command -v firefox >/dev/null 2>&1 ; then
    BROWSER=firefox
fi

# Consider a switch to Dillo...
if (
    # No output, please
    exec >/dev/null 2>&1
    # Don't switch if it's not there
    command -v dillo || exit
    # Switch if Firefox isn't there
    command -v firefox || exit 0
    # Switch if procfs says we have less than 2GB of RAM
    awk '$1=="MemTotal:"&&$2<2^20{m++}END{exit!m}' < /proc/meminfo
) ; then
    BROWSER=dillo
fi

# Export our choice of browser, if it isn't empty
[ -n "$BROWSER" ] || return
export BROWSER
