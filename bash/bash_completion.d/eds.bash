# Complete args to eds(1df) with existing executables in $EDSPATH, defaulting
# to ~/.local/bin
_eds() {
    local edspath
    edspath=${EDSPATH:-"$HOME"/.local/bin}
    [[ -d $edspath ]] || return
    local executable
    while IFS= read -rd '' executable ; do
        [[ -n $executable ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$executable
    done < <(
        shopt -s dotglob nullglob

        # Make globbing case-insensitive if appropriate
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -s nocaseglob
                    break
                    ;;
            esac
        done < <(bind -v)

        declare -a files
        files=("${EDSPATH:-"$HOME"/.local/bin}"/"${COMP_WORDS[COMP_CWORD]}"*)
        declare -a executables
        for file in "${files[@]}" ; do
            [[ -f $file && -x $file ]] || continue
            executables[${#executables[@]}]=${file##*/}
        done

        # Print quoted entries, null-delimited
        printf '%q\0' "${executables[@]}"
    )
}
complete -F _eds eds
