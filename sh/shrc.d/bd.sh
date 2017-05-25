# Move back up the directory tree to the first directory matching the name
bd() {

    # Check argument count
    if [ "$#" -gt 1 ] ; then
        printf >&2 'bd(): Too many arguments\n'
        return 2
    fi

    # Look at argument given
    case $1 in

        # If it has a leading slash or is . or .., don't touch the arguments
        /*|.|..) ;;

        # Otherwise, we'll try to find a matching ancestor and then shift the
        # initial request off the argument list
        *)

            # Push the current directory onto the stack
            set -- "$1" "$PWD"

            # Keep chopping at the current directory until it's empty or it
            # matches the request
            while [ -n "$2" ] ; do
                set -- "$1" "${2%/*}"
                case $2 in
                    (*/"$1") break ;;
                esac
            done

            # If the first argument ended up empty, we have no match
            if [ -z "$2" ] ; then
                printf >&2 'bd(): No match\n'
                return 1
            fi
            shift
            ;;
    esac

    # We have a match; try and change into it
    command cd -- "$1"
}
