# Completion for gpg(1) with long options
_gpg() {

    # Bail if no gpg(1)
    hash gpg 2>/dev/null || return

    # Bail if not completing an option
    case ${COMP_WORDS[COMP_CWORD]} in
        --*) return 1 ;;
    esac

    # Generate completion reply from gpg(1) options
    local option
    while read -r option ; do
        case $option in
            "${COMP_WORDS[COMP_CWORD]}"*)
                COMPREPLY[${#COMPREPLY[@]}]=$option
                ;;
        esac
    done < <(gpg --dump-options 2>/dev/null)
}
complete -F _gpg -o bashdefault -o default gpg
