# Most systems won't have X, so we'll only define this if we have startx(1)
command -v startx >/dev/null 2>&1 || return

# Quick one-key command to launch an X session
x() {
    exec startx "$@"
}
