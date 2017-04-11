# Run loc(1df) with given arguments and then run gt() to get to the first
# argument found
lgt() {

    # Check argument count
    if [ "$#" -eq 0 ] ; then
        printf >&2 'lgt(): Need a search term\n'
        return 2
    fi

    # Change the positional parameters from the loc(1df) arguments to the first
    # result with a trailing slash
    set -- "$(
        loc "$@" | {
            IFS= read -r target
            printf '%s/' "$target"
        }
    )"

    # Strip the trailing slash
    set -- "${1%/}"

    # If the subshell printed nothing, return with failure
    [ -n "$1" ] || return

    # Run gt() with the new arguments
    gt "$@"
}
