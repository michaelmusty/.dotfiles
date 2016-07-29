# Complete args to eds(1) with existing executables in $EDSPATH, defaulting to
# ~/.local/bin
_eds() {
    local edspath
    edspath=${EDSPATH:-"$HOME"/.local/bin}
    [[ -d $edspath ]] || return
    while IFS= read -rd '' executable ; do
        COMPREPLY[${#COMPREPLY[@]}]=$executable
    done < <(
        shopt -s dotglob nullglob
        declare -a files
        files=("${EDSPATH:-"$HOME"/.local/bin}"/"${COMP_WORDS[COMP_CWORD]}"*)
        declare -a executables
        for file in "${files[@]}" ; do
            [[ -f $file && -x $file ]] || continue
            executables[${#executables[@]}]=${file##*/}
        done
        ((${#executables[@]})) || exit 1
        printf '%q\0' "${executables[@]}"
    )
}
complete -F _eds eds
