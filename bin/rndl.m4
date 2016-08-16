#!/bin/sh
# Print a random line from input
self=rndl

# If there are no arguments, we're checking stdin; this is more complicated
# than checking file arguments because we have to count the lines in order to
# correctly choose a random one, and two passes means we require a temporary
# file if we don't want to read all of the input into memory (!)
if [ "$#" -eq 0 ] ; then

include(`include/mktd.trap.sh')
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
        printf 2>&1 'rndl: No lines found on input\n'
        exit 2
        ;;
esac

# Try to get a random seed from rnds(1) for rndi(1)
seed=$(rnds)

# Get a random line number from rndi(1)
ri=$(rndi 1 "$lc" "$seed") || exit

# Print the line using sed(1)
sed -- "$ri"'!d' "$@"
