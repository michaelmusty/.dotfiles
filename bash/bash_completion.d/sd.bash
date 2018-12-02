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
            shopt -s nocasematch 2>/dev/null
        fi

        # Print matching sibling dirs that are not the current dir
        for sib in ../*/ ; do
            # Strip leading ../
            sib=${sib#../}
            # Strip trailing slash
            sib=${sib%/}
            # Skip self
            [[ $sib != "${PWD##*/}" ]] || continue
            # Check the quoted and unquoted word for matching
            for match in "$sib" "$(printf '%q' "$sib")" ; do
                # Print any match, slash-terminated
                case $match in
                    ("$2"*)
                        printf '%s/' "$sib"
                        continue
                        ;;
                esac
            done
        done
    )
}
complete -F _sd -o filenames sd
