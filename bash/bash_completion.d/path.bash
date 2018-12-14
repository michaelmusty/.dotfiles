# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion for path
_path() {

    # What to do depends on which word we're completing
    if ((COMP_CWORD == 1)) ; then

        # Complete operation as first word
        local ci comp
        while read -r comp ; do
            COMPREPLY[ci++]=$comp
        done < <(compgen -W '
            append
            check
            help
            insert
            list
            pop
            remove
            shift
        ' -- "$2")
        return
    fi

    # Complete with either directories or $PATH entries as all other words
    case ${COMP_WORDS[1]} in

        # Complete with a directory
        insert|append|check)
            local ci comp
            while IFS= read -d '' -r comp ; do
                COMPREPLY[ci++]=$comp
            done < <(

                # Make globs expand appropriately
                shopt -s dotglob nullglob
                if _completion_ignore_case ; then
                    shopt -s nocaseglob
                fi

                # Print shell-quoted matching directories, null-terminated
                for dir in "$2"*/ ; do
                    printf '%q\0' "${dir%/}"
                done
            )
            ;;

        # Complete with directories from PATH
        remove)
            local ci comp
            while IFS= read -d '' -r comp ; do
                COMPREPLY[ci++]=$comp
            done < <(

                # Make matches work appropriately
                if _completion_ignore_case ; then
                    shopt -s nocasematch 2>/dev/null
                fi

                # Break PATH into parts
                IFS=: read -a paths -d '' -r \
                    < <(printf '%s\0' "$PATH")

                # Print shell-quoted matching parts, null-terminated
                # shellcheck disable=SC2154
                for path in "${paths[@]}" ; do
                    case $path in
                        ("$2"*) printf '%q\0' "$path" ;;
                    esac
                done
            )
            ;;

        # No completion
        *) return 1 ;;
    esac
}
complete -F _path path
