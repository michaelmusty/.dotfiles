# Set marked directory to given dir or current dir
md() {

    # Accept up to one argument
    if [ "$#" -gt 1 ] ; then
        printf >&2 'md(): Too many arguments\n'
        return 2
    fi

    # If first arg unset or empty, assume the user means the current dir
    [ -n "$1" ] || set -- "$PWD"

    # If specified path not a directory, refuse to mark it
    if ! [ -d "$1" ] ; then
        printf >&2 'md(): Not a directory\n'
        return 2
    fi

    # Save the specified path in the marked directory var
    PMD=$1
}
