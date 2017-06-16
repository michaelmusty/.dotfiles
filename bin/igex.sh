# Run a command and ignore specified exit values

# There should be at least two arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 'igs: Need an ignore list x,y,z and a command\n';
    exit 2
fi

# The list of values to ignore is the first argument; add a trailing comma for
# ease of parsing; shift it off
igs=$1,
shift

# Run the command in the remaining arguments and grab its exit value
"$@"
ex=$?

# Iterate through the ignored exit values by chopping its variable and checking
# each value until it's empty
while [ -n "$igs" ] ; do

    # Get the first exit value in the remaining list
    ig=${igs%%,*}

    # If it matches the command's exit value, exit with 0
    [ "$((ig == ex))" -eq 1 ] && exit 0

    # Chop it off the list for the next iteration
    igs=${igs#*,}
done

# If we got right through the list, we exit with the same value as the command;
# i.e. we are not ignoring the value
exit "$ex"
