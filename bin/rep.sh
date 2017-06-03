# Repeat a command
self=rep

# Check arguments.
if [ "$#" -lt 2 ] ; then
    printf >&2 '%s: Need a count and a program name\n' "$self"
    exit 2
fi

# Shift off the repetition count.
c=$1
shift

# Check the repetition count looks sane. Zero is fine!
if [ "$c" -lt 0 ] ; then
    printf >&2 '%s: Nonsensical negative count\n' "$self"
    exit 2
fi

# Run the command the specified number of times. Stop immediately as soon as a
# run fails.
while [ "${n=1}" -le "$c" ] ; do
    "$@" || exit
    n=$((n+1))
done
