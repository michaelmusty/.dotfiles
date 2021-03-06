# Run a command and save its output and error to temporary files

# Check we have at least one argument
if [ "$#" -eq 0 ] ; then
    printf >&2 'fnl: Command needed\n'
    exit 2
fi

# Create a temporary directory; note that we *don't* clean it up on exit
dir=$(mktd fnl) || exit

# Run the command; keep its exit status; wrap the command in braces so that the
# out files are always opened even if the command is not found or otherwise
# can't be run; some BSD shells require this, I forget which ones
{ "$@" ; } >"$dir"/stdout 2>"$dir"/stderr
ret=$?

# Run wc(1) on each of the files
wc -- "$dir"/*

# Exit with the wrapped command's exit status
exit "$ret"
