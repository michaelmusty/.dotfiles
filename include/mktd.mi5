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
