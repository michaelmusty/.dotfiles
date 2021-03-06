# Read grep(1) patterns from input and search for them in the given files
self=rgl

# Check the arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 '%s: Need at least one filename\n' "$self"
    exit 2
fi

# Iterate over the patterns and search for each one
while {

    # If the input is a terminal, print a slash prompt for the next pattern;
    # try to print it in bold red, too, but discard stderr if we can't
    if [ -t 0 ] ; then
        tput setaf 1 || tput setaf 1 0 0 || tput AF 1 || tput AF 1 0 0
        tput bold || tput md
        printf '%s/' "$self"
        tput sgr0 || tput me
    fi 2>/dev/null

    # Read the pattern
    IFS= read -r pat

} ; do

    # Run grep(1) with the read pattern over the arguments
    grep -- "$pat" "$@"
done

# Print a newline if this was a terminal to clear the prompt
if [ -t 0 ] ; then
    printf '\n'
fi
