# Run ed(1) over multiple files, duplicating stdin.
self=edda

# Need at least one file
if [ "$#" -eq 0 ] ; then
    printf >&2 'edda: Need at least one file\n'
    exit 2
fi

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

# Duplicate stdin into a file
script=$td/script
cat >"$script" || exit

# Run ed(1) over each file with the stdin given
for file ; do
    ed -- "$file" <"$script"
done