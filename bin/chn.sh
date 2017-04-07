# Repeat a command to filter input several times
self=chn

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

# If the count is zero, just run the input straight through!
if [ "$c" -eq 0 ] ; then
    cat
    exit
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

# Define and create input and output files
if=$td/if of=$td/of
touch -- "$if" "$of"

# Iterate through the count
while [ "${n=1}" -le "$c" ] ; do

    # Start a subshell so we can deal with FDs cleanly
    (
        # If this isn't the first iteration, our input comes from $if
        [ "$n" -eq 1 ] ||
            exec <"$if"

        # If this isn't the last iteration, our output goes to $of
        [ "$n" -eq "$c" ] ||
            exec >"$of"

        # Run the command with the descriptors above; if the command fails, the
        # subshell will exit, which will in turn exit the program
        "$@"
    ) || exit

    # Copy the output file over the input one
    cp -- "$of" "$if"

    # Increment the counter for the next while loop run
    n=$((n+1))
done
