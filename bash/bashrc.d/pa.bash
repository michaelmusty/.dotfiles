# Print arguments, one per line. Compare paz().
pa() {
    (($#)) || return 0
    printf '%s\n' "$@"
}
