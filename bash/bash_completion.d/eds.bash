# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Complete args to eds(1df)
_eds() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -d / -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Make globs expand appropriately
        shopt -u dotglob
        shopt -s nullglob
        if _completion_ignore_case ; then
            shopt -s nocaseglob
        fi

        # Iterate through files in local binaries directory
        edspath=${EDSPATH:-"$HOME"/.local/bin}
        for file in "$edspath"/"$2"* ; do
            # Skip directories
            ! [[ -d $file ]] || continue
            # Skip non-executable files
            [[ -x $file ]] || continue
            # Print quoted entry, slash-terminated
            printf '%q/' "${file##*/}"
        done
    )
}
complete -F _eds eds
