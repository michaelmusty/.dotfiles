# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Complete calls to keep() with variables and functions, or if -d is given with
# stuff that's already kept
_keep() {

    # Determine what we're doing based on first completion word
    local mode
    mode=keep
    if ((COMP_CWORD > 1)) ; then
        case ${COMP_WORDS[1]} in
            # Help; no completion
            -h) return 1 ;;
            # Deleting; change mode
            -d) mode=delete ;;
        esac
    fi

    # Collect words from an appropriate type of completion
    local ci comp
    while read -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Switch on second word; is it a -d option?
        case $mode in

            # Keepable names: all functions and variables
            (keep)
                compgen -A function -A variable -- "$2"
                ;;

            # Kept names: .bash-suffixed names in keep dir
            (delete)

                # Make globs behave correctly
                shopt -u dotglob
                shopt -s nullglob
                if _completion_ignore_case ; then
                    shopt -s nocaseglob
                fi

                # Build list of kept names
                bashkeep=${BASHKEEP:-"$HOME"/.bashkeep.d}
                for keep in "$bashkeep"/"$2"*.bash ; do
                    # Skip directories
                    ! [[ -d $keep ]] || continue
                    # Strip leading path
                    keep=${keep##*/}
                    # Strip trailing extension
                    keep=${keep%.bash}
                    # Print kept name
                    printf '%s\n' "$keep"
                done
                ;;
        esac
    )
}
complete -F _keep keep
