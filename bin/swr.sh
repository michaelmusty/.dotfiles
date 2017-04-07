# Transparently wrap scp(1) targets on the command line
self=swr

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

# Set a flag to manage resetting the positional parameters at the start of the
# loop
n=1
for arg ; do

    # If this is our first iteration, reset the shell parameters
    case $n in
        1) set -- ;;
    esac

    # Test whether this argument looks like a remote file
    if (

        # Test it contains a colon
        case $arg in
            *:*) ;;
            *) exit 1 ;;
        esac

        # Test the part before the first colon has at least one character and
        # only hostname characters
        case ${arg%%:*} in
            '') exit 1 ;;
            *[!a-zA-Z0-9-.]*) exit 1 ;;
        esac

    ) ; then

        # Looks like a remote file request; try to copy it into the temporary
        # directory, bail out completely if we can't
        dst=$td/$n
        scp -q -- "$arg" "$dst" || exit
        set -- "$@" "$dst"

    else
        # Just a plain old argument; stack it up
        set -- "$@" "$arg"
    fi

    # Bump n
    n=$((n+1))
done

# Run the command with the processed arguments
exec "$@"
