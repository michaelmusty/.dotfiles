# Create a directory and change into it
mkcd() {
    command -p mkdir -p -- "$1" || return
    command cd -- "$1"
}
