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

        # Otherwise, add and keep chopping at the current directory until it's
        # empty or it matches the request, then shift the request off
        *)
            set -- "$1" "$PWD"
            while : ; do
                case $2 in
                    */"$1"|'') break ;;
                    */) set -- "$1" "${2%/}" ;;
                    */*) set -- "$1" "${2%/*}" ;;
                    *) set -- "$1" '' ;;
                esac
            done
            shift
            ;;
    esac

    # If we have nothing to change into, there's an error
    if [ -z "$1" ] ; then
        printf >&2 'bd(): No match\n'
        return 1
    fi

    # We have a match; try and change into it
    command cd -- "$1"
}
