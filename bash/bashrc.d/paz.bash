# Print arguments, null-delimited; you will probably want to write this into a
# file or as part of a pipeline. Compare pa().
paz() {
    (($#)) || return 0
    printf '%s\0' "$@"
}
