# Go to marked directory
gd() {

    # Refuse to deal with unwanted arguments
    if [ "$#" -gt 0 ] ; then
        printf >&2 'gd(): Unspecified argument\n'
        return 2
    fi

    # Complain if mark not actually set yet
    if ! [ -n "$PMD" ] ; then
        printf >&2 'gd(): Mark not set\n'
        return 2
    fi

    # Go to the marked directory
    cd -- "$PMD"
}
