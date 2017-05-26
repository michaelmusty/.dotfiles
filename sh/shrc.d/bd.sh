# Move back up the directory tree to the first directory matching the name
bd() {

    # Check arguments; default to ".."
    if [ "$#" -gt 1 ] ; then
        printf >&2 'bd(): Too many arguments\n'
        return 2
    fi
    set -- "${1:-..}"

    # Look at argument given; default to going up one level
    case $1 in

        # If it's slash, dot, or dot-dot, we'll just go there, like `cd` would
        /|.|..) ;;

        # Anything else with a slash anywhere is an error
        */*)
            printf >&2 'bd(): Illegal slash\n'
            return 2
            ;;

        # Otherwise, we'll try to find a matching ancestor and then shift the
        # initial request off the argument list
        *)

            # Push the current directory onto the stack
            set -- "$1" "$PWD"

            # Keep chopping at the current directory until it's empty or it
            # matches the request
            while : ; do

                # Make certain there are no trailing slashes to foul us up
                while : ; do
                    case $2 in
                        */) set -- "$1" "${2%/}" ;;
                        *) break ;;
                    esac
                done

                # Strip a path element
                set -- "$1" "${2%/*}"

                # Check whether we're arrived
                case $2 in
                    */"$1") break ;;
                    */*) ;;
                    *)
                        printf >&2 'bd(): No match\n'
                        return 1
                        ;;
                esac
            done

            # If the first argument ended up empty, we have no match
            shift
            ;;
    esac

    # We have a match; try and change into it
    command cd -- "$1"
}
