# Completion for gpg(1) with long options
_gpg() {

    # Needs gpg(1)
    hash gpg 2>/dev/null || return

    # Bail if not completing an option
    case $2 in
        --*) ;;
        *) return 1 ;;
    esac

    # Generate completion reply from gpg(1) options
    local ci comp
    while read -r comp ; do
        case $comp in
            "$2"*) COMPREPLY[ci++]=$comp ;;
        esac
    done < <(gpg --dump-options 2>/dev/null)
}
complete -F _gpg -o bashdefault -o default gpg
