# Autocompletion for man(1)
_man() {

    # Don't even bother if we don't have manpath(1)
    hash manpath || return 1

    # Snarf the word
    local word
    word=${COMP_WORDS[COMP_CWORD]}

    # If this is the second word, and the previous word was a number, we'll
    # assume that's the section to search
    local section
    if ((COMP_CWORD > 1)) && [[ ${COMP_WORDS[COMP_CWORD-1]} != [^0-9] ]] ; then
        section='man'${COMP_WORDS[COMP_CWORD-1]}
    fi

    # Read completion results from a subshell and add them to the COMPREPLY
    # array individually
    while IFS= read -d '' -r page ; do
        COMPREPLY[${#COMPREPLY[@]}]=$page
    done < <(

        # Do not return dotfiles, give us extended globbing, and expand empty
        # globs to just nothing
        shopt -u dotglob
        shopt -s extglob nullglob

        # Start an array of pages
        declare -a pages

        # Break manpath(1) output into an array of paths
        IFS=: read -a manpaths -r < <(manpath 2>/dev/null)

        # Iterate through the manual page paths and add every manual page we find
        for manpath in "${manpaths[@]}" ; do
            [[ $manpath ]] || continue
            for page in "$manpath"/"$section"*/"$word"*.[0-9]* ; do
                pages[${#pages[@]}]=$page
            done
        done

        # Strip paths, .gz suffixes, and finally .<section> suffixes
        pages=("${pages[@]##*/}")
        pages=("${pages[@]%.@([glx]z|bz2|lzma|Z)}")
        pages=("${pages[@]%.[0-9]*}")

        # Bail out if we ended up with no pages somehow to prevent us from
        # printing
        ((${#pages[@]})) || exit 1

        # Print the pages array to stdout, quoted and null-delimited
        printf '%q\0' "${pages[@]}"
    )
}
complete -F _man -o default man

