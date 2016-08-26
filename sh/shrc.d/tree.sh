# I don't like the LS_COLORS environment variable, but GNU tree(1) doesn't
# color its output by default without it; this will coax it into doing so with
# the default colors when writing to a terminal.
tree() {

    # Subshell will run the tests to check if we should color the output
    if (

        # Not if -n is in the arguments and -C isn't
        while getopts 'nC' opt ; do
            case $opt in
                n) n=1 ;;
                C) C=1 ;;
            esac
        done
        [ -z "$C" ] || exit 0
        [ -z "$n" ] || exit 1

        # Not if output isn't a terminal
        [ -t 1 ] || exit

        # Not if output terminal doesn't have at least 8 colors
        [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] || exit

    ) ; then
        set -- -C "$@"
    fi

    # Run the command with the determined arguments
    command tree "$@"
}
