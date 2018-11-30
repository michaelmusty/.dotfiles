# Completion setup for ud
_ud() {

    # Only makes sense for the second argument
    ((COMP_CWORD == 2)) || return

    # Iterate through directories, null-separated, add them to completions
    local dirname
    while IFS= read -rd '' dirname ; do
        [[ -n "$dirname" ]] || continue
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

        # Collect directory names, strip trailing slashes
        local -a dirnames
        dirnames=("${COMP_WORDS[COMP_CWORD]}"*/)
        dirnames=("${dirnames[@]%/}")

        # Bail if no results to prevent empty output
        ((${#dirnames[@]})) || exit 1

        # Print results null-delimited
        printf '%s\0' "${dirnames[@]}"
    )
}
complete -F _ud -o filenames ud
