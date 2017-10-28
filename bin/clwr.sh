# Write lines of terminal input into a file, clearing in between each one
self=clwr

# Check our inputs for sanity
if [ "$#" -ne 1 ] ; then
    printf >&2 '%s: Need output file\n' "$self"
    exit 2
elif ! [ -t 0 ] ; then
    printf >&2 '%s: stdin not a terminal\n' "$self"
    exit 2
elif ! [ -t 1 ] ; then
    printf >&2 '%s: stdout not a terminal\n' "$self"
    exit 2
fi

# Open a file descriptor onto the output file to save on open(2)/close(2)
# system calls
exec 3>"$1" || exit

# Start looping through clearing and accepting lines
while { tput clear && IFS= read -r line ; } ; do
    printf '%s\n' "$line" >&3
done
