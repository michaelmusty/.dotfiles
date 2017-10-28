# Choose a random argument using rndi(1df)

# Check we have at least one argument
if [ "$#" -eq 0 ] ; then
    printf >&2 'rnda: No args given\n'
    exit 2
fi

# Get a random integer from 1 to the number of arguments
argi=$(rndi 1 "$#") || exit

# Shift until that argument is the first argument
shift "$((argi-1))"

# Print it
printf '%s\n' "$1"
