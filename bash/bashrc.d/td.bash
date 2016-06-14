# Complete filenames for td(1)
_td() {
    local dir
    dir=${TODO_DIR:-$HOME/Todo}
    while IFS= read -d '' -r fn ; do
        COMPREPLY[${#COMPREPLY[@]}]=$fn
    done < <(
        shopt -s extglob nullglob
        shopt -u dotglob
        declare -a fns
        cd -- "$dir" || exit
        fns=(*)
        ((${#fns[@]})) || exit
        printf '%s\0' "${fns[@]##$dir/}"
    )
    return
}
complete -F _td td
