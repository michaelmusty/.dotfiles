# Abstract calls to Bash help vs man(1)
self=han

# Ensure we're using at least version 3.0
# shellcheck disable=SC2128
[ -n "$BASH_VERSINFO" ] || exit    # Check version array exists (>=2.0)
((BASH_VERSINFO[0] >= 3)) || exit  # Check actual major version number

# Figure out the options with which we can call help; Bash >=4.0 has an -m
# option which prints the help output in a man-page like format
declare -a helpopts
if ((BASH_VERSINFO[0] >= 4)) ; then
    helpopts=(-m)
fi

# Create a temporary directory with name in $td, and a trap to remove it when
# the script exits
td=
cleanup() {
    [[ -n $td ]] && rm -fr -- "$td"
}
trap cleanup EXIT
td=$(mktd "$self") || exit

# If we have exactly one argument and a call to the help builtin with that
# argument succeeds, display its output with `pager -s`
if (($# == 1)) &&
   help "${helpopts[@]}" "$1" >"$td"/"$1".help 2>/dev/null ; then
    (cd -- "$td" && "$PAGER" -s -- "$1".help)

# Otherwise, just pass all the arguments to man(1)
else
    man "$@"
fi
