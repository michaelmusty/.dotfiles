# Find an abbreviated path
ad() {

    # Check argument count
    if [ "$#" -ne 1 ] ; then
        printf >&2 'ad(): Need just one argument\n'
        return 2
    fi

    # Change the positional parameters from the abbreviated request
    # to any matched directory
    set -- "$(

        # Clean up and anchor the request
        req=${1%/}/
        case $req in
            (/*) ;;
            (*) req=${PWD%/}/${req#/}/ ;;
        esac

        # Start building the target directory; go through the request piece by
        # piece until it is used up
        dir=
        while [ -n "$req" ] ; do

            # Chop the next front bit off the request and add it to the dir
            dir=${dir%/}/${req%%/*}
            req=${req#*/}

            # If that exists, all is well and we can keep iterating
            [ -d "$dir" ] && continue

            # Set the positional parameters to a glob expansion of the
            # abbreviated directory given
            set -- "$dir"*

            # Iterate through the positional parameters filtering out
            # directories; we need to run right through the whole list to check
            # that we have at most one match
            entd=
            for ent ; do
                [ -d "$ent" ] || continue

                # If we already found a match and have found another one, bail
                # out
                if [ -n "$entd" ] ; then
                    printf >&2 'ad(): More than one matching dir for %s*:\n' \
                        "$dir"
                    printf >&2 '%s\n' "$@"
                    exit 1
                fi

                # Otherwise, this can be our first one
                entd=$ent
            done

            # If we found no match, bail out
            if [ -z "$entd" ] ; then
                printf >&2 'ad(): No matching dirs: %s*\n' "$dir"
                exit 1
            fi

            # All is well, tack on what we have found and keep going
            dir=$entd

        done

        # Print the target
        printf '%s\n' "$dir"
    )"

    # If the subshell printed nothing, return with failure
    [ -n "$1" ] || return

    # Try to change into the determined directory
    command cd -- "$@"
}
