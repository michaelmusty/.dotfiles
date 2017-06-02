# Attempt to change into the argument's parent directory; This is intended for
# use when you've got a file path in a variable, or in history, or in Alt+.,
# and want to quickly move to its containing directory. In the absence of an
# argument, this just shifts up a directory, i.e. `cd ..`
#
# Note this is equivalent to `ud 1`.
pd() {

    # Check arguments; default to $PWD
    if [ "$#" -gt 1 ] ; then
        printf >&2 'pd(): Too many arguments\n'
        return 2
    fi
    set -- "${1:-"$PWD"}"

    # Make certain there are no trailing slashes to foul us up, and anchor path
    # if relative
    while : ; do
        case $1 in
            */) set -- "${1%/}" ;;
            /*) break ;;
            *) set -- "$PWD"/"$1" ;;
        esac
    done

    # Strip a path element
    set -- "${1%/*}"

    # Try to change into the determined directory, or root if empty
    command cd -- "${1:-/}"
}
