# Call read with a null delimiter
readz() {
    builtin read -rd '' "$@"
}
