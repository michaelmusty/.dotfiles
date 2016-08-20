# Print the history number of the last command
# "fc" is specified by POSIX, but does not seem to be in dash, so its being
# included here rather than in e.g. ~/.bashrc.d is a bit tenuous.
lhn () {
    if ! command -v fc >/dev/null 2>&1 ; then
        printf 'lhn(): fc: command not found\n'
        return 1
    fi
    set -- "$(fc -l -1)"
    [ -n "$1" ] || return
    printf '%u\n' "$1"
}
