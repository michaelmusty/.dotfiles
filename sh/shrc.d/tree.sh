# I don't like the LS_COLORS environment variable, but GNU tree(1) doesn't
# color its output by default without it; this will coax it into doing so with
# the default colors when writing to a terminal.
tree() {
    [ -t 1 ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- -C "$@"
    command "$@"
}
