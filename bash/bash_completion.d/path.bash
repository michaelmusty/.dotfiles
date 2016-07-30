# Completion for path
_path() {

    # What to do depends on which word we're completing
    if ((COMP_CWORD == 1)) ; then

        # Complete operation as first word
        local cmd
        for cmd in help list insert append remove set check ; do
            [[ $cmd == "${COMP_WORDS[COMP_CWORD]}"* ]] || continue
            COMPREPLY[${#COMPREPLY[@]}]=$cmd
        done

    # Complete with either directories or $PATH entries as all other words
    else
        case ${COMP_WORDS[1]} in

            # Complete with a directory
            insert|i|append|add|a|check|c|set|s)
                local dirname
                while IFS= read -rd '' dirname ; do
                    COMPREPLY[${#COMPREPLY[@]}]=$dirname
                done < <(

                    # Set options to glob correctly
                    shopt -s dotglob nullglob

                    # Collect directory names, strip trailing slash
                    local -a dirnames
                    dirnames=("${COMP_WORDS[COMP_CWORD]}"*/)
                    dirnames=("${dirnames[@]%/}")

                    # Bail if no results to prevent empty output
                    ((${#dirnames[@]})) || exit 1

                    # Print results, quoted and null-delimited
                    printf '%q\0' "${dirnames[@]}"
                )
                ;;

            # Complete with directories from PATH
            remove|rm|r)
                local -a promptarr
                IFS=: read -d '' -a promptarr < <(printf '%s\0' "$PATH")
                local part
                for part in "${promptarr[@]}" ; do
                    [[ $part == "${COMP_WORDS[COMP_CWORD]}"* ]] || continue
                    COMPREPLY[${#COMPREPLY[@]}]=$(printf '%q\0' "$part")
                done
                ;;

            # No completion
            *)
                return 1
                ;;
        esac
    fi
}
complete -F _path path
