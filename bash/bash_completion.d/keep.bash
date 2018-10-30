# Complete calls to keep() with variables and functions, or if -d is given with
# stuff that's already kept
_keep() {

    # Default is to complete with function and variable names
    local mode
    mode=names

    # Iterate through the words up to the previous word to figure out how to
    # complete this one
    local i
    for ((i = 0; i < COMP_CWORD; i++)) ; do
        case ${COMP_WORDS[i]} in
            --)
                mode=names
                break
                ;;
            -d)
                mode=kept
                break
                ;;
        esac
    done

    # Complete with appropriate mode
    case $mode in
        names)
            local word
            while IFS= read -r word ; do
                [[ -n $word ]] || continue
                COMPREPLY[${#COMPREPLY[@]}]=$word
            done < <(compgen -A function -A variable \
                -- "${COMP_WORDS[COMP_CWORD]}")
            ;;
        kept)
            local word
            while IFS= read -r word ; do
                [[ -n $word ]] || continue
                COMPREPLY[${#COMPREPLY[@]}]=$word
            done < <(
                shopt -s dotglob nullglob

                # Make globbing case-insensitive if appropriate; is there a cleaner way
                # to find this value?
                while read -r _ option value ; do
                    case $option in
                        (completion-ignore-case)
                            case $value in
                                (on)
                                    shopt -s nocaseglob
                                    break
                                    ;;
                            esac
                            ;;
                    esac
                done < <(bind -v)

                keep=${BASHKEEP:-"$HOME"/.bashkeep.d}
                declare -a keeps
                keeps=("$keep"/"${COMP_WORDS[COMP_CWORD]}"*.bash)
                keeps=("${keeps[@]##*/}")
                keeps=("${keeps[@]%.bash}")
                if ((${#keeps[@]})) ; then
                    printf '%s\n' "${keeps[@]}"
                else
                    printf '\n'
                fi
            )
            ;;
    esac
}
complete -F _keep keep
