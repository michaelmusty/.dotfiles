# If given two arguments, replace the first instance of the first argument with
# the second argument in $PWD, and make that the target of cd(). This POSIX
# version cannot handle options, but it can handle an option terminator (--),
# so e.g. `cd -- -foo -bar` should work.
cd() {

    # First check to see if we can perform the substitution at all
    if (

        # If we have any options, we can't do it, because POSIX shell doesn't
        # let us (cleanly) save the list of options for use later in the script
        for arg ; do
            case $arg in
                --) break ;;
                -*) return 1 ;;
            esac
        done

        # Shift off -- if it's the first argument
        [ "$1" = -- ] && shift

        # Check we have two non-null arguments
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

            # Check pattern was actually in $PWD; this indirectly checks that
            # $PWD and $pat are both actually set, too; it's valid for $rep to
            # be empty, though
            [ "$cur" != "$curtc" ] || exit

            # Check we ended up with something to change into
            [ -n "$new" ] || exit

            # Print the replaced result
            printf '%s\n' "$new"
        )"

        # Check we have a second argument
        if [ -z "$2" ] ; then
            printf >&2 'cd(): Substitution failed\n'
            return 1
        fi
    fi

    # Execute the cd command as normal
    command cd "$@"
}
