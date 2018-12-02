# Autocompletion for man(1)
_man() {

    # Don't interfere with a user typing a path
    case $2 in
        */*) return 1 ;;
    esac

    # If previous word started with a number, we'll assume that's a section to
    # search
    local sec
    case $3 in
        [0-9]*) sec=$3 ;;
    esac

    # Cut completion short if we have neither section nor word; there will
    # probably be too many results
    [[ -n $sec ]] || [[ -n $2 ]] || return

    # Read completion results from a subshell and add them to the COMPREPLY
    # array individually
    local ci comp
    while IFS= read -d / -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Make globs expand appropriately
        shopt -u dotglob
        shopt -s nullglob
        if _completion_ignore_case ; then
            shopt -s nocaseglob
        fi

        # Figure out the manual paths to search
        if hash manpath 2>/dev/null ; then

            # manpath(1) exists, run it to find what to search
            IFS=: read -a manpaths -r \
                < <(manpath 2>/dev/null)
        else

            # Fall back on some typical paths
            manpaths=( \
                "$HOME"/.local/man \
                "$HOME"/.local/share/man \
                /usr/man \
                /usr/share/man \
                /usr/local/man \
                /usr/local/share/man \
            )
        fi

        # Add pages from each manual directory
        local pages pi
        for mp in "${manpaths[@]}" ; do
            [[ -n $mp ]] || continue

            # Which pattern? Depends on section specification
            if [[ -n $sec ]] ; then

                # Section requested; quoted value in glob
                for page in "$mp"/man"${sec%%[!0-9]*}"/"$2"*."$sec"* ; do
                    pages[pi++]=${page##*/}
                done
            else

                # No section;
                for page in "$mp"/man[0-9]*/"$2"*.[0-9]* ; do
                    pages[pi++]=${page##*/}
                done
            fi
        done

        # Bail if there are no pages
        ((pi)) || exit

        # Strip section suffixes
        pages=("${pages[@]%.[0-9]*}")

        # Print quoted entries, slash-delimited
        printf '%q/' "${pages[@]}"
    )
}
complete -F _man -o bashdefault -o default man
