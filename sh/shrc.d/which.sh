which() {
    printf >&2 'Whichcraft detected! Did you mean: command -v %s\n' "$*"
    return 2
}
