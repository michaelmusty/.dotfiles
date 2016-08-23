# Shortcut to step up the directory tree with an arbitrary number of steps,
# like cd .., cd ../.., etc
ud() {

    # Check argument count
    if [ "$#" -gt 1 ] ; then
        printf >&2 'ud(): Too many arguments\n'
        return 2
    fi

    # Check first argument, number of steps upward, default to 1.
    # "0" is weird, but valid; "-1" however makes no sense at all
    if [ "${1:-1}" -lt 0 ] ; then
        printf >&2 'ud(): Invalid step count\n'
        return 2
    fi

    # Change the positional parameters from the number of steps given to a
    # "../../.." string
    set -- "$(

        # Append /.. to the target (default PWD) the specified number of times
        dirname=${2:-"$PWD"}
        i=0
        steps=${1:-1}
        while [ "$i" -lt "$steps" ] ; do
            dirname=${dirname%/}/..
            i=$((i+1))
        done

        # Check we have a target after all that
        if [ -z "$dirname" ] ; then
            printf >&2 'ud(): Destination construction failed\n'
            exit 1
        fi

        # Print the target
        printf '%s\n' "$dirname"
    )"

    # If the subshell printed nothing, return with failure
    [ -n "$1" ] || return

    # Try to change into the determined directory
    command cd -- "$@"
}
