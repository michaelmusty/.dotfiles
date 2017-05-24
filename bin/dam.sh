# Store up all input before emitting it unchanged as output
self=dam

# Create a temporary directory with name in $td, and handle POSIX-ish traps to
# remove it when the script exits.
td=
cleanup() {
    [ -n "$td" ] && rm -fr -- "$td"
    if [ "$1" != EXIT ] ; then
        trap - "$1"
        kill "-$1" "$$"
    fi
}
for sig in EXIT HUP INT TERM ; do
    # shellcheck disable=SC2064
    trap "cleanup $sig" "$sig"
done
td=$(mktd "$self") || exit

# We'll operate on stdin in the temp directory; write the script's stdin to it
# with cat(1)
cat -- "${@:--}" >"$td"/stdin

# Only when that write is finished do we finally spit it all back out again
cat -- "$td"/stdin
