# Print a random line from input
self=rndl

# If there are no arguments, we're checking stdin; this is more complicated
# than checking file arguments because we have to count the lines in order to
# correctly choose a random one, and two passes means we require a temporary
# file if we don't want to read all of the input into memory (!)
if [ "$#" -eq 0 ] ; then

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

    # We'll operate on stdin in the temp directory; write the script's stdin to
    # it with cat(1)
    set -- "$td"/stdin
    cat >"$td"/stdin
fi

# Count the number of lines in the input
lc=$(sed -- '$=;d' "$@") || exit

# If there were none, bail
case $lc in
    ''|0)
        printf >&2 'rndl: No lines found on input\n'
        exit 2
        ;;
esac

# Try to get a random seed from rnds(1df) for rndi(1df)
seed=$(rnds)

# Get a random line number from rndi(1df)
ri=$(rndi 1 "$lc" "$seed") || exit

# Print the line using sed(1)
sed -- "$ri"'!d' "$@"