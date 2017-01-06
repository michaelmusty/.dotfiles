# Set marked directory to given dir or current dir
md() {

    # Accept up to one argument
    if [ "$#" -gt 1 ] ; then
        printf >&2 'md(): Too many arguments\n'
        return 2
    fi

    # If first arg unset or empty, assume the user means the current dir
    [ -n "$1" ] || set -- "$PWD"

    # Jump to the dir and emit PWD from a subshell to get an absolute path
    set -- "$(cd -- "$1" && printf %s "$PWD")"

    # If that turned up empty, we have failed; the cd call probably threw an
    # error for us too
    [ -n "$1" ] || return

    # Save the specified path in the marked directory var
    # shellcheck disable=SC2034
    PMD=$1
}
