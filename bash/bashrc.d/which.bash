which() {
    printf >&2 'Whichcraft detected! Did you mean: type -P %s\n' "$*"
    return 2
}
