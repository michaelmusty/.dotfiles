# If the argument is a directory, change to it. If it's a file, change to its
# parent. Stands for "get to".
gt() {

    # Check argument count
    if [ "$#" -ne 1 ] ; then
        printf >&2 'gt(): Need one argument\n'
        return 2
    fi

    # Make certain there are no trailing slashes to foul us up, and anchor path
    # if relative
    while : ; do
        case $1 in
            */) set -- "${1%/}" ;;
            /*) break ;;
            *) set -- "$PWD"/"$1" ;;
        esac
    done

    # If target isn't a directory, chop to its parent
    [ -d "$1" ] || set -- "${1%/*}"

    # Try to change into the determined directory, or root if empty
    command cd -- "${1:-/}"
}
