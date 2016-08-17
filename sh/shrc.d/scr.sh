# Create a temporary directory and change into it, to stop me putting stray
# files into $HOME, and making the system do cleanup for me. Single optional
# argument is the string to use for naming the directory; defaults to "scr".
scr() {
    cd -- "$(mktd "${1:-scr}")"
}
