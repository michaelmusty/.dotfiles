# Abstract calls to Bash help vs man(1)
self=han

# Ensure we're using at least version 2.05. Weird arithmetic syntax needed here
# due to leading zeroes and trailing letters in some 2.x version numbers (e.g.
# 2.05a).
# shellcheck disable=SC2128
[ -n "$BASH_VERSINFO" ] || exit
((BASH_VERSINFO[0] == 2)) &&
    ((10#${BASH_VERSINFO[1]%%[![:digit:]]*} < 5)) &&
    exit

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
