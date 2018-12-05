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

        # Get list of siblings; use trailing slashes to limit to directories
        # There should always be at least one (self)
        siblings=(../*/)

        # Strip leading dot-dot-slash and trailing slash
        siblings=("${siblings[@]#../}")
        siblings=("${siblings[@]%/}")

        # Add quoted siblings to new array; for large directories, this is
        # faster than forking a subshell for `printf %q` on each item
        while read -d / -r sibling ; do
            siblings_quoted[sqi++]=$sibling
        done < <(printf '%q/' "${siblings[@]}")

        # Make matching work appropriately
        if _completion_ignore_case ; then
            shopt -s nocasematch 2>/dev/null
        fi

        # Get current dir
        self=${PWD##*/}

        # Iterate through keys of the siblings array
        for si in "${!siblings[@]}" ; do

            # Get sibling and associated quoted sibling
            sibling=${siblings[si]}
            sibling_quoted=${siblings_quoted[si]}

            # Skip if this sibling looks like the current dir
            [[ $sibling != "$self" ]] || continue

            # If either the unquoted or quoted sibling matches, print the
            # unquoted one as a completion reply
            for match in "$sibling" "$sibling_quoted" ; do
                case $match in
                    ("$2"*)
                        printf '%s/' "$sibling"
                        break
                        ;;
                esac
            done
        done
    )
}
complete -F _sd -o filenames sd
