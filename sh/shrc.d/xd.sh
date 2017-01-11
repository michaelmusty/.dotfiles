# Swap current directory with marked directory
xd() {

    # Refuse to deal with unwanted arguments
    if [ "$#" -gt 0 ] ; then
        printf >&2 'gd(): Unspecified argument\n'
        return 2
    fi

    # Complain if mark not actually set yet
    if ! [ -n "$PMD" ] ; then
        printf >&2 'gd(): Mark not set\n'
        return 1
    fi

    # Put the current and marked directories into positional params
    set -- "$PMD" "$PWD"

    # Try to change into the marked directory
    cd -- "$1" || return
    
    # If that worked, we can swap the mark, and we're done
    PMD=$2
}
