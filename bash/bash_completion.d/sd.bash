# Completion function for sd; any sibling directories, excluding the self
_sd() {

    # Only makes sense for the first argument
    ((COMP_CWORD == 1)) || return 1

    # Current directory can't be root directory
    [[ $PWD != / ]] || return 1

    # Build list of matching sibiling directories
    while IFS= read -rd '' dirname ; do
        COMPREPLY[${#COMPREPLY[@]}]=$dirname
    done < <(

        # Set options to glob correctly
        shopt -s dotglob nullglob

        # Collect directory names, strip leading ../ and trailing /
        local -a dirnames
        dirnames=(../"${COMP_WORDS[COMP_CWORD]}"*/)
        dirnames=("${dirnames[@]#../}")
        dirnames=("${dirnames[@]%/}")

        # Iterate again, but exclude the current directory this time
        local -a sibs
        local dirname
        for dirname in "${dirnames[@]}" ; do
            [[ $dirname != "${PWD##*/}" ]] || continue
            sibs[${#sibs[@]}]=$dirname
        done

        # Bail if no results to prevent empty output
        ((${#sibs[@]})) || exit 1

        # Print results, null-delimited
        printf '%q\0' "${sibs[@]}"
    )
}
complete -F _sd sd
