# POSIX-compatible version of the plenv Bash shell wrapper
[ -d "$HOME"/.plenv ] || return
plenv() {
    case $1 in
        rehash)
            shift
            eval "$(plenv sh-rehash "$@")"
            ;;
        shell)
            shift
            eval "$(plenv sh-shell "$@")"
            ;;
        *)
            command plenv "$@"
            ;;
    esac
}
