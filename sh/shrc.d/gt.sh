# If the argument is a directory, change to it. If it's a file, change to its
# parent. Stands for "get to".
gt() {

    # Check argument count
    if [ "$#" -gt 1 ] ; then
        printf >&2 'gd(): Too many arguments\n'
        return 2
    fi

    # Strip trailing slash
    set -- "${1%/}"

    # If target doesn't have a leading slash, add PWD prefix
    case $1 in
        /*) ;;
        *) set -- "${PWD%/}"/"$1"
    esac

    # If target isn't a directory, chop to its parent
    [ -d "$1" ] || set -- "${1%/*}"

    # If target is now empty, go to the root
    [ -n "$1" ] || set -- /

    # Try to change into the determined directory
    command cd -- "$@"
}
