# Complete filenames for td(1)
_td() {
    local dir
    dir=${TODO_DIR:-"$HOME"/Todo}
    while IFS= read -rd '' fn ; do
        COMPREPLY[${#COMPREPLY[@]}]=$fn
    done < <(
        shopt -s extglob nullglob
        shopt -u dotglob
        local -a fns
        fns=("$dir"/"${COMP_WORDS[COMP_CWORD]}"*)
        fns=("${fns[@]#"$dir"/}")
        ((${#fns[@]})) || exit 1
        printf '%s\0' "${fns[@]##"$dir"/}"
    )
    return
}
complete -F _td td
