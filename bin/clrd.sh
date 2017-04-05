# Clear the screen and read a file as it's written line-by-line
self=clrd

# Check we have an input file and are writing to a terminal
if [ "$#" -ne 1 ] ; then
    printf >&2 '%s: Need input file\n' "$self"
    exit 2
elif ! [ -t 1 ] ; then
    printf >&2 '%s: stdout not a terminal\n' "$self"
    exit 2
fi

# Clear the screen and start tailing out the file
clear
tail -f -- "$@"
