# Run a program with args read from standard input, prompted if from term
if [ "$#" -eq 0 ] ; then
    printf >&2 'ap: Need at least one argument (command name)\n'
    exit 2
fi

# Get the command name and shift it off
cmd=$1
shift

# Iterate through the remaining args; it's legal for there to be none, but in
# that case the user may as well just have invoked the command directly
for arg ; do

    # If this is the first iteration, clear the params away (we grabbed them in
    # the for statement)
    if [ -z "$reset" ] ; then
        set --
        reset=1
    fi

    # If stdin is a terminal, prompt with the name of the argument
    if [ -t 0 ] ; then
        printf '%s: ' "$arg"
    fi

    # Note that a whitespace or even empty argument is allowed
    IFS= read -r val
    set -- "$@" "$val"
done

# Execute the command with the given parameters
exec "$cmd" "$@"
