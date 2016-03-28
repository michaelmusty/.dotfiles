readv() {
    local arg
    local -a opts names
    for arg ; do
        case $arg in
            --)
                shift
                break
                ;;
            -*)
                shift
                opts[${#opts[@]}]=$arg
                ;;
            *)
                break
                ;;
        esac
    done
    names=("$@")
    builtin read "${opts[@]}" "${names[@]}" || return
    for name in "${names[@]}" ; do
        printf >&2 '%s: %s = %s\n' \
            "$FUNCNAME" "$name" "${!name}"
    done
}

