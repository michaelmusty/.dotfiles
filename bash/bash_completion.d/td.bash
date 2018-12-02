# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Complete filenames for td(1df)
_td() {

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

        # Find and print matching file entries
        for list in "${TODO_DIR:-"$HOME"/Todo}"/"$2"* ; do
            # Skip directories
            ! [[ -d $list ]] || continue
            # Print entry, slash-terminated
            printf '%q/' "${list##*/}"
        done
    )
}
complete -F _td td
