# Complete calls to keep() with variables and functions, or if -d is given with
# stuff that's already kept
_keep() {

    # Determine what we're doing based on first completion word
    local mode
    mode=keep
    if ((COMP_CWORD > 1)) ; then
        case ${COMP_WORDS[1]} in
            -h) return 1 ;;
            -d) mode=delete ;;
        esac
    fi

    # Collect words from an appropriate type of completion
    local word
    while read -r word ; do
        [[ -n $word ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$word
    done < <(

        # Switch on second word; is it a -d option?
        case $mode in

            # Keepable names: all functions and variables
            (keep)
                compgen -A function -A variable \
                    -- "${COMP_WORDS[COMP_CWORD]}"
                ;;

            # Kept names: .bash-suffixed names in keep dir
            (delete)
                # Make globs behave correctly
                shopt -s nullglob
                while read -r _ setting ; do
                    case $setting in
                        ('completion-ignore-case on')
                            shopt -s nocaseglob
                            break
                            ;;
                    esac
                done < <(bind -v)

                # Build list of kept names
                dir=${BASHKEEP:-"$HOME"/.bashkeep.d}
                cword=${COMP_WORDS[COMP_CWORD]}
                kept=("$dir"/"$cword"*.bash)
                kept=("${kept[@]##*/}")
                kept=("${kept[@]%.bash}")

                # Print kept names
                printf '%s\n' "${kept[@]}"
                ;;
        esac
    )
}
complete -F _keep keep
