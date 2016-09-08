# Some simple completion for Git
_git() {
    
    # Try to find the index of the Git subcommand
    local -i sci i
    for ((i = 1; !sci && i <= COMP_CWORD; i++)) ; do
        case ${COMP_WORDS[i]} in

            # Skip --option=value
            --*=*) ;;

            # These ones have arguments, so bump the index up one more
            -C|-c|--exec-path|--git-dir|--work-tree|--namespace) ((i++)) ;;

            # Skip --option
            --?*) ;;

            # We have hopefully found our subcommand
            *) ((sci = i)) ;;
        esac
    done

    # Complete initial subcommand
    if ((sci == COMP_CWORD)) || [[ ${COMP_WORDS[sci]} == 'help' ]] ; then
        local ep
        ep=$(git --exec-path) || return
        local path
        for path in "$ep"/git-"${COMP_WORDS[COMP_CWORD]}"* ; do
            [[ -f $path ]] || continue
            [[ -x $path ]] || continue
            COMPREPLY[${#COMPREPLY[@]}]=${path#"$ep"/git-}
        done
        return
    fi

    # Test subcommand to choose completions
    case ${COMP_WORDS[sci]} in

        # Complete with untracked, unignored files
        add)
            local file
            while read -rd '' file ; do
                [[ -n $file ]] || continue
                COMPREPLY[${#COMPREPLY[@]}]=$file
            done < <(git ls-files \
                --directory \
                --exclude-standard \
                --no-empty-directory \
                --others \
                -z \
                -- "${COMP_WORDS[COMP_CWORD]}"'*' \
                2>/dev/null)
            ;;

        # Complete with ref names
        *)
            local ref
            while read -r ref ; do
                [[ -n $ref ]] || continue
                COMPREPLY[${#COMPREPLY[@]}]=${ref#refs/*/}
            done < <(git for-each-ref \
                --format '%(refname)' \
                -- 'refs/**/'"${COMP_WORDS[COMP_CWORD]}"'*' \
                2>/dev/null)
            return
            ;;
    esac
}

# Defaulting to directory/file completion is important in Git's case
complete -F _git -o bashdefault -o default git
