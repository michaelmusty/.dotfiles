# Some simple completion for Git
_git() {

    # Subcommands for this function to stack words onto COMPREPLY; if the first
    # argument is not given, the rest of the function is reached
    case $1 in

        # No argument; continue normal completion
        '') ;;

        # Symbolic references, remote or local
        refs)
            local ref
            while IFS= read -r ref ; do
                [[ -n $ref ]] || continue
                ref=${ref#refs/*/}
                case $ref in
                    "${COMP_WORDS[COMP_CWORD]}"*)
                        COMPREPLY[${#COMPREPLY[@]}]=$ref
                        ;;
                esac
            done < <(git for-each-ref \
                --format '%(refname)' \
                2>/dev/null)
            return
            ;;

        # Remote names
        remotes)
            local remote
            while IFS= read -r remote ; do
                case $remote in
                    '') continue ;;
                    "${COMP_WORDS[COMP_CWORD]}"*)
                        COMPREPLY[${#COMPREPLY[@]}]=$remote
                        ;;
                esac
            done < <(git remote 2>/dev/null)
            return
            ;;

        # Git aliases
        aliases)
            local alias
            while IFS= read -r alias ; do
                alias=${alias#alias.}
                alias=${alias%% *}
                case $alias in
                    '') continue ;;
                    "${COMP_WORDS[COMP_CWORD]}"*)
                        COMPREPLY[${#COMPREPLY[@]}]=$alias
                        ;;
                esac
            done < <(git config \
                --get-regexp '^alias\.' \
                2>/dev/null)
            return
            ;;

        # Git subcommands
        subcommands)
            local execpath
            execpath=$(git --exec-path) || return
            local path
            for path in "$execpath"/git-"${COMP_WORDS[COMP_CWORD]}"* ; do
                [[ -f $path ]] || continue
                [[ -x $path ]] || continue
                COMPREPLY[${#COMPREPLY[@]}]=${path#"$execpath"/git-}
            done
            return
            ;;

        # Untracked files
        untracked_files)
            local file
            while IFS= read -rd '' file ; do
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
            return
            ;;
    esac

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

    # Complete initial subcommand or alias
    if ((sci == COMP_CWORD)) ; then
        _git subcommands
        _git aliases
        return
    fi

    # Test subcommand to choose completions
    case ${COMP_WORDS[sci]} in

        # Complete with untracked, unignored files
        add)
            _git untracked_files
            return
            ;;

        # Help on real subcommands (not aliases)
        help)
            _git subcommands
            return
            ;;

        # Complete with remote subcommands and then remote names
        remote)
            local word
            if ((COMP_CWORD == 2)) ; then
                while IFS= read -r word ; do
                    [[ -n $word ]] || continue
                    COMPREPLY[${#COMPREPLY[@]}]=$word
                done < <(compgen -W '
                    add
                    get-url
                    prune
                    remove
                    rename
                    set-branches
                    set-head
                    set-url
                    show
                    update
                ' -- "${COMP_WORDS[COMP_CWORD]}")
            else
                _git remotes
            fi
            return
            ;;

        # Complete with remotes and then refs
        fetch|pull|push)
            if ((COMP_CWORD == 2)) ; then
                _git remotes
            else
                _git refs
            fi
            ;;

        # Commands for which I'm likely to want a ref
        branch|checkout|merge|rebase|tag)
            _git refs
            ;;

        # I normally only want a refspec for "reset" if I'm using the --hard or
        # --soft option; otherwise, files are fine
        reset)
            case ${COMP_WORDS[COMP_CWORD-1]} in
                --hard|--soft)
                    _git refs
                    ;;
            esac
            ;;
    esac
}

# Defaulting to directory/file completion is important in Git's case
complete -F _git -o bashdefault -o default git
