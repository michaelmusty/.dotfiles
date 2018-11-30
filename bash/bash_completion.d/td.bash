# Complete filenames for td(1df)
_td() {
    local dir
    dir=${TODO_DIR:-"$HOME"/Todo}
    local fn
    while IFS= read -rd '' fn ; do
        [[ -n $fn ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$fn
    done < <(
        shopt -s extglob nullglob
        shopt -u dotglob

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

        declare -a fns
        fns=("$dir"/"${COMP_WORDS[COMP_CWORD]}"*)
        fns=("${fns[@]#"$dir"/}")

        # Print quoted entries, null-delimited
        printf '%q\0' "${fns[@]}"
    )
}
complete -F _td td
