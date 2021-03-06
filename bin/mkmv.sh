# Move files into created directory in one call

# Check we have at least two arguments
if [ "$#" -lt 2 ] ; then
    printf >&2 'mkmv: Need at least one source and destination\n'
    exit 2
fi

# Get the last argument (the directory to create)
for dir do : ; done

# Create it, or bail
mkdir -p -- "$dir" || exit

# Move all the remaining arguments into the directory (which will be the last
# argument)
mv -- "$@"
