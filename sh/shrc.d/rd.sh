# Replace the first instance of the first argument string with the second
# argument string in $PWD, and make that the target of the cd builtin. This is
# to emulate a feature of the `cd` builtin in Zsh that I like, but that I think
# should be a separate command rather than overloading `cd`.
#
#     $ pwd
#     /usr/local/bin
#     $ rd local
#     $ pwd
#     /usr/bin
#     $ rd usr opt
#     $ pwd
#     /opt/bin
rd() {

    # Check argument count
    case $# in
        1|2) ;;
        *)
            printf >&2 \
                'rd(): Need a string and optionally a replacement\n'
            return 2
            ;;
    esac

    # Check there's something to substitute, and do it
    case $PWD in
        *"$1"*)
            set -- "${PWD%%"$1"*}""$2""${PWD#*"$1"}"
            ;;
        *)
            printf >&2 'rd(): Substitution failed\n'
            return 1
            ;;
    esac

    # Try to change into the determined directory
    command cd -- "$1"
}
