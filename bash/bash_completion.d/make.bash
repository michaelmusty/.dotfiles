# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion setup for Make, completing targets
_make() {

    # Find a legible Makefile according to the POSIX spec (look for "makefile"
    # first, then "Makefile"). You may want to add "GNU-makefile" after this.
    local mf
    for mf in makefile Makefile '' ; do
        ! [[ -e $mf ]] || break
    done
    [[ -n $mf ]] || return

    # Iterate through completions produced by subshell
    local ci comp
    while read -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(
        while IFS= read -r line ; do

            # Match expected format
            case $line in
                # First char not a tab
                ($'\t'*) continue ;;
                # Has no equals sign anywhere
                (*=*) continue ;;
                # Has a colon on the line
                (*:*) ;;
                # Skip anything else
                (*) continue ;;
            esac

            # Break the target up with space delimiters
            local -a targets
            IFS=' ' read -a targets -r \
                < <(printf '%s\n' "${line%%:*}")

            # Short-circuit if there are no targets
            ((${#targets[@]})) || exit

            # Make matches behave correctly
            if _completion_ignore_case ; then
                shopt -s nocasematch 2>/dev/null
            fi

            # Examine each target for completion suitability
            for target in "${targets[@]}" ; do
                case $target in
                    # Not .PHONY, .POSIX etc
                    (.*) ;;
                    # Nothing with metacharacters
                    (*[^[:word:]./-]*) ;;
                    # Match!
                    ("$2"*) printf '%s\n' "$target" ;;
                esac
            done

        done < "$mf"
    )
}
complete -F _make -o bashdefault -o default make
