# Move back up the directory tree to the first directory matching the name
bd() {

    # Set positional parameters to an option terminator and what will hopefully
    # end up being a target directory
    set -- -- "$(

        # If the first of the existing positional arguments is --, shift it
        # off
        [ "$1" = -- ] && shift

        # There's no more than one argument after that
        [ "$#" -le 1 ] || exit 1

        # The requested pattern is the first argument, defaulting to just the
        # parent directory
        req=${1:-..}

        # Strip trailing slashes if a trailing slash isn't the whole pattern
        [ "$req" = / ] || req=${req%/}

        # What to do now depends on the request
        case $req in

            # Just go straight to the root or dot directories if asked
            /|.|..)
                dirname=$req
                ;;

            # Anything with a leading / needs to anchor to the start of the
            # path. A strange request though. Why not just use cd?
            /*)
                dirname=$req
                case $PWD in
                    "$dirname"/*) ;;
                    *) dirname='' ;;
                esac
                ;;

            # In all other cases, iterate through the PWD to find a match, or
            # whittle the target down to an empty string trying
            *)
                dirname=$PWD
                while [ -n "$dirname" ] ; do
                    dirname=${dirname%/*}
                    case $dirname in
                        */"$req") break ;;
                    esac
                done
                ;;
        esac

        # Check we have a target after all that
        if [ -z "$dirname" ] ; then
            printf >&2 'bd(): Directory name not in path\n'
            exit 1
        fi

        # Print the target
        printf '%s\n' "$dirname"

    # If the subshell failed, return from the function with the same exit value
    )" || return

    # Try to change into the determined directory
    command cd "$@"
}
