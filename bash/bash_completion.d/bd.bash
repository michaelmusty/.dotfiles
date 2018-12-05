# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion setup for bd()
_bd() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -d / -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Build an array of path ancestors
        path=$PWD
        while [[ -n $path ]] ; do

            # Peel off the leaf of the path
            ancestor=${path##*/}
            path=${path%/*}

            # Skip if this is a null string; root, trailing/double slash...
            [[ -n $ancestor ]] || continue

            # Skip the first non-null element (current dir)
            ((generation++)) || continue

            # Push node onto ancestry list
            ancestors[ai++]=$ancestor
        done

        # Continue if we have at least one non-root ancestor
        ((ai)) || return

        # Add quoted ancestors to new array; for long paths, this is faster than
        # forking a subshell for `printf %q` on each item
        while read -d / -r ancestor ; do
            ancestors_quoted[aqi++]=$ancestor
        done < <(printf '%q/' "${ancestors[@]}")

        # Make matching behave appropriately
        if _completion_ignore_case ; then
            shopt -s nocasematch 2>/dev/null
        fi

        # Iterate through keys of the ancestors array
        for ai in "${!ancestors[@]}" ; do

            # Get ancestor and associated quoted ancestor
            ancestor=${ancestors[ai]}
            ancestor_quoted=${ancestors_quoted[ai]}

            # If either the unquoted or quoted ancestor matches, print the
            # unquoted one as a completion reply
            for match in "$ancestor" "$ancestor_quoted" ; do
                case $match in
                    ("$2"*)
                        printf '%s/' "$ancestor"
                        break
                        ;;
                esac
            done
        done
    )
}
complete -F _bd -o filenames bd
