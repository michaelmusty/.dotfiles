# Set marked directory to given dir or current dir
md() {

    # Accept up to one argument
    if [ "$#" -gt 1 ] ; then
        printf >&2 'md(): Too many arguments\n'
        return 2
    fi

    # If argument given, change to it in subshell to get absolute path.
    # If not, use current working directory.
    if [ -n "$1" ] ; then
        set -- "$(cd -- "$1" && printf '%s/' "$PWD")"
        set -- "${1%%/}"
    else
        set -- "$PWD"
    fi

    # If that turned up empty, we have failed; the cd call probably threw an
    # error for us too
    [ -n "$1" ] || return

    # Save the specified path in the marked directory var
    # shellcheck disable=SC2034
    PMD=$1
}
