# Completion function for sd; any sibling directories, excluding the self
_sd() {

    # Only makes sense for the first argument
    ((COMP_CWORD == 1)) || return

    # Current directory can't be root directory
    case $PWD in
        /) return 1 ;;
    esac

    # Build list of matching sibling directories
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

        # Collect directory names, strip leading ../ and trailing /
        local -a dirnames
        dirnames=(../"${COMP_WORDS[COMP_CWORD]}"*/)
        dirnames=("${dirnames[@]#../}")
        dirnames=("${dirnames[@]%/}")

        # Iterate again, but exclude the current directory this time
        local -a sibs
        local dirname
        for dirname in "${dirnames[@]}" ; do
            case $dirname in
                "${PWD##*/}") ;;
                *) sibs[${#sibs[@]}]=$dirname ;;
            esac
        done

        # Print quoted sibling directories, null-delimited
        printf '%q\0' "${sibs[@]}"
    )
}
complete -F _sd sd
