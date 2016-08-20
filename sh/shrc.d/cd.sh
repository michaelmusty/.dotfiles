# If given two arguments, replace the first instance of the first argument with
# the second argument in $PWD, and make that the target of cd(). This POSIX
# version cannot handle options, but it can handle an option terminator (--),
# so e.g. `cd -- -foo -bar` should work.
cd() {

    # First check to see if we can perform the substitution at all; otherwise,
    # we won't be changing any parameters
    if (

        # If we have any options, we can't do it, because POSIX shell doesn't
        # let us (cleanly) save the list of options for use later in the script
        for arg ; do
            case $arg in
                --) break ;;
                -*) opts=1 ; shift ;;
            esac
        done

        # Shift off -- if it's the first argument
        [ "$1" = -- ] && shift

        # Print an explanatory error if there were options and then two
        # arguments
        if [ "$#" -eq 2 ] && [ -n "$opts" ] ; then
            printf >&2 'cd(): Can'\''t combine options and substitution\n'
        fi

        # Check we have no options and two non-null arguments
        [ -z "$opts" ] || return
        [ "$#" -eq 2 ] || return
        [ -n "$1" ] || return
        [ -n "$2" ] || return

    ) ; then

        # Set the positional parameters to an option terminator and what will
        # hopefully end up being the substituted directory name
        set -- -- "$(

            # If the first of the existing positional arguments is --, shift it
            # off
            [ "$1" = -- ] && shift

            # Current path: e.g. /foo/ayy/bar/ayy
            cur=$PWD
            # Pattern to replace: e.g. ayy
            pat=$1
            # Text with which to replace pattern: e.g. lmao
            rep=$2

            # /foo/
            curtc=${cur%%"$pat"*}
            # /bar/ayy
            curlc=${cur#*"$pat"}
            # /foo/lmao/bar/ayy
            new=${curtc}${rep}${curlc}

            # Check that a substitution resulted in an actual change and that
            # we ended up with a non-null target, or print an error to stderr
            if [ "$cur" = "$curtc" ] || [ -z "$new" ]; then
                printf >&2 'cd(): Substitution failed\n'
                exit 1
            fi

            # Print the target
            printf '%s\n' "$new"

        # If the subshell failed, return from the function with the same exit
        # value
        )" || return
    fi

    # Execute the cd command as normal
    command cd "$@"
}
