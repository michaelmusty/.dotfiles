# Shortcut to step up the directory tree with an arbitrary number of steps,
# like cd .., cd ../.., etc
ud() {

    # Change the positional parameters from the number of steps given to a
    # "../../.." string
    set -- "$(

        # Check first argument, number of steps upward, default to 1
        # "0" is weird, but valid; "-1" however makes no sense at all
        steps=${1:-1}
        if [ "$steps" -lt 0 ] ; then
            printf >&2 'ud(): Invalid step count\n'
            exit 2
        fi

        # Check second argument, target directory, default to $PWD
        dirname=${2:-"$PWD"}

        # Append /.. to the target the specified number of times
        i=0
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

    # If the subshell failed, return from the function with the same exit
    # value
    )" || return

    # Try to change into the determined directory
    command cd -- "$@"
}
