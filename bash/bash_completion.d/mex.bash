# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion setup for mex(1df), completing non-executable files in $PATH
_mex() {

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

        # Break $PATH up into an array
        declare -a paths
        IFS=: read -a paths -r \
            < <(printf '%s\n' "$PATH")

        # Iterate through each path, collecting non-executable filenames
        for path in "${paths[@]}" ; do
            for name in "$path"/"$2"* ; do

                # Skip anything that is not a plain file
                [[ -f $name ]] || continue
                # Skip files that are already executable
                ! [[ -x $name ]] || continue

                # Chop off leading path
                name=${name##*/}

                # Skip certain filename patterns
                case $name in
                    # DOS batch file
                    (*.bat) continue ;;
                    # README files
                    (README*) continue ;;
                esac

                # Print name of the file
                printf '%s/' "${name##*/}"

            done
        done
    )
}
complete -F _mex mex
