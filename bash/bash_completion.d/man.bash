# Autocompletion for man(1)
_man() {

    # Don't even bother if we don't have manpath(1)
    hash manpath 2>/dev/null || return

    # Don't bother if the word has slashes in it, the user is probably trying
    # to complete an actual path
    case $2 in
        */*) return 1 ;;
    esac

    # If this is the second word, and the previous word started with a number,
    # we'll assume that's the section to search
    local section subdir
    if ((COMP_CWORD > 1)) ; then
        case $3 in
            [0-9]*)
                section=$3
                subdir=man${section%%[^0-9]*}
                ;;
        esac
    fi

    # Read completion results from a subshell and add them to the COMPREPLY
    # array individually
    local page
    while IFS= read -rd '' page ; do
        [[ -n $page ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$page
    done < <(

        # Do not return dotfiles, give us extended globbing, and expand empty
        # globs to just nothing
        shopt -u dotglob
        shopt -s extglob nullglob

        # Make globbing case-insensitive if appropriate
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -s nocaseglob
                    break
                    ;;
            esac
        done < <(bind -v)

        # Break manpath(1) output into an array of paths
        declare -a manpaths
        IFS=: read -a manpaths -r < <(manpath 2>/dev/null)

        # Iterate through the manual page paths and add every manual page we find
        declare -a pages
        for manpath in "${manpaths[@]}" ; do
            [[ -n $manpath ]] || continue
            if [[ -n $section ]] ; then
                for page in \
                    "$manpath"/"$subdir"/"$2"*."$section"?(.[glx]z|.bz2|.lzma|.Z)
                do
                    pages[${#pages[@]}]=$page
                done
            else
                for page in "$manpath"/man[0-9]*/"$2"*.* ; do
                    pages[${#pages[@]}]=$page
                done
            fi
        done

        # Strip paths, .gz suffixes, and finally .<section> suffixes
        pages=("${pages[@]##*/}")
        pages=("${pages[@]%.@([glx]z|bz2|lzma|Z)}")
        pages=("${pages[@]%.[0-9]*}")

        # Print quoted entries, null-delimited
        printf '%q\0' "${pages[@]}"
    )
}
complete -F _man -o bashdefault -o default man
