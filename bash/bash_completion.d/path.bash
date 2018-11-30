# Completion for path
_path() {

    # What to do depends on which word we're completing
    if ((COMP_CWORD == 1)) ; then

        # Complete operation as first word
        local cmd
        for cmd in list insert append remove shift pop check help ; do
            [[ $cmd == "${COMP_WORDS[COMP_CWORD]}"* ]] || continue
            COMPREPLY[${#COMPREPLY[@]}]=$cmd
        done

    # Complete with either directories or $PATH entries as all other words
    else
        case ${COMP_WORDS[1]} in

            # Complete with a directory
            insert|append|check)
                local dirname
                while IFS= read -rd '' dirname ; do
                    [[ -n $dirname ]] || continue
                    COMPREPLY[${#COMPREPLY[@]}]=$dirname
                done < <(

                    # Set options to glob correctly
                    shopt -s dotglob nullglob

                    # Make globbing case-insensitive if appropriate
                    while read -r _ setting ; do
                        case $setting in
                            ('completion-ignore-case on')
                                shopt -s nocaseglob
                                break
                                ;;
                        esac
                    done < <(bind -v)

                    # Collect directory names, strip trailing slash
                    local -a dirnames
                    dirnames=("${COMP_WORDS[COMP_CWORD]}"*/)
                    dirnames=("${dirnames[@]%/}")

                    # Print quoted entries, null-delimited
                    printf '%q\0' "${dirnames[@]}"
                )
                ;;

            # Complete with directories from PATH
            remove)
                local -a promptarr
                IFS=: read -rd '' -a promptarr < <(printf '%s\0' "$PATH")
                local part
                for part in "${promptarr[@]}" ; do
                    case $part in
                        "${COMP_WORDS[COMP_CWORD]}"*)
                            COMPREPLY[${#COMPREPLY[@]}]=$(printf '%q' "$part")
                            ;;
                    esac
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
