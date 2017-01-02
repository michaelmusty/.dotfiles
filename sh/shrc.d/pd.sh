# Attempt to change into the argument's parent directory; This is intended for
# use when you've got a file path in a variable, or in history, or in Alt+.,
# and want to quickly move to its containing directory. In the absence of an
# argument, this just shifts up a directory, i.e. `cd ..`
pd() {

    # Check argument count
    if [ "$#" -gt 1 ] ; then
        printf >&2 'pd(): Too many arguments\n'
        return 2
    fi

    # Change the positional parameters from the target to its containing
    # directory
    set -- "$(

        # Figure out target dirname
        dirname=${1:-..}
        dirname=${dirname%/}
        dirname=${dirname%/*}

        # Check we have a target after that
        if [ -z "$dirname" ] ; then
            printf >&2 'ud(): Destination construction failed\n'
            exit 1
        fi

        # Print the target with trailing slash to work around newline stripping
        printf '%s/' "${dirname%/}"
    )"

    # Remove trailing slash
    set -- "${1%/}"

    # If the subshell printed nothing, return with failure
    [ -n "$1" ] || return

    # Try to change into the determined directory
    command cd -- "$@"
}
