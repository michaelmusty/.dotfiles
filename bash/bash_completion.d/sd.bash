# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion function for sd; any sibling directories, excluding the self
_sd() {

    # Build list of matching sibling directories
    local ci comp
    while IFS= read -d / -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Make globs expand appropriately
        shopt -s dotglob nullglob
        if _completion_ignore_case ; then
            shopt -s nocaseglob
        fi

        # Print matching sibling dirs that are not the current dir
        for sibling in ../"$2"*/ ; do
            sibling=${sibling%/}
            sibling=${sibling#../}
            case $sibling in
                ("${PWD##*/}") ;;
                (*) printf '%q/' "$sibling" ;;
            esac
        done
    )
}
complete -F _sd sd
