# Shortcut to step up the directory tree with an arbitrary number of steps,
# like cd .., cd ../.., etc
ud() {

    # Check arguments; default to 1 and $PWD
    if [ "$#" -gt 2 ] ; then
        printf >&2 'ud(): Too many arguments\n'
        return 2
    fi
    set -- "${1:-1}" "${2:-"$PWD"}"

    # Check first argument, number of steps upward. "0" is weird, but valid;
    # "-1" however makes no sense at all
    if [ "$1" -lt 0 ] ; then
        printf >&2 'ud(): Invalid step count\n'
        return 2
    fi

    # Check second argument, starting path, for relativity and anchor it if
    # need be
    case $2 in
        /*) ;;
        *) set -- "$1" "$PWD"/"$2" ;;
    esac

    # Chop an element off the target the specified number of times
    while [ "$1" -gt 0 ] ; do

        # Make certain there are no trailing slashes to foul us up
        while : ; do
            case $2 in
                */) set -- "$1" "${2%/}" ;;
                *) break ;;
            esac
        done

        # Strip a path element
        set -- "$(($1-1))" "${2%/*}"
    done

    # Shift off the count, which should now be zero
    shift

    # Try to change into the determined directory, or the root if blank
    command cd -- "${1:-/}"
}
