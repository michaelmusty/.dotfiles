# Frontend to controlling prompt
prompt() {

    # If no arguments, print the prompt strings as they are
    if ! (($#)) ; then
        declare -p PS1 PS2 PS3 PS4
        return
    fi

    # What's done next depends on the first argument to the function
    case $1 in

        # Turn complex, colored PS1 and debugging PS4 prompts on
        on)
            # Declare the PROMPT_RETURN variable as an integer
            declare -i PROMPT_RETURN

            # Set up pre-prompt command
            PROMPT_COMMAND='PROMPT_RETURN=$? ; history -a'

            # If Bash 4.0 is available, trim very long paths in prompt
            if ((BASH_VERSINFO[0] >= 4)) ; then
                PROMPT_DIRTRIM=4
            fi

            # Basic prompt shape
            PS1='\u@\h:\w'

            # Add sub-commands; VCS, job, and return status checks
            PS1=$PS1'$(prompt vcs)$(prompt job)$(prompt ret)'

            # Add prefix and suffix
            PS1='${PROMPT_PREFIX}'$PS1'${PROMPT_SUFFIX}'

            # Add terminating "$" or "#" sign
            PS1=$PS1'\$'

            # Count available colors
            local -i colors
            colors=$( {
                tput Co || tput colors
            } 2>/dev/null )

            # Prepare reset code
            local reset
            reset=$( {
                tput me || tput sgr0
            } 2>/dev/null )

            # Decide prompt color formatting based on color availability
            local format
            case $colors in

                # Check if we have non-bold bright green available
                256)
                    format=$( {
                        : "${PROMPT_COLOR:=10}"
                        tput AF "$PROMPT_COLOR" ||
                        tput setaf "$PROMPT_COLOR" ||
                        tput AF "$PROMPT_COLOR" 0 0  ||
                        tput setaf "$PROMPT_COLOR" 0 0
                    } 2>/dev/null )
                    ;;

                # If we have only eight colors, use bold green
                8)
                    format=$( {
                        : "${PROMPT_COLOR:=2}"
                        tput AF "$PROMPT_COLOR" ||
                        tput setaf "$PROMPT_COLOR"
                        tput md || tput bold
                    } 2>/dev/null )
                    ;;

                # For all other terminals, we assume non-color (!), and we just
                # use bold
                *)
                    format=$( {
                        tput md || tput bold
                    } 2>/dev/null )
                    ;;
            esac

            # String it all together
            PS1='\['"$format"'\]'"$PS1"'\['"$reset"'\] '
            PS2='> '
            PS3='? '
            PS4='+<$?> ${BASH_SOURCE:-$BASH}:$FUNCNAME:$LINENO:'
            ;;

        # Revert to simple inexpensive prompts
        off)
            unset -v PROMPT_COMMAND PROMPT_DIRTRIM PROMPT_RETURN
            PS1='\$ '
            PS2='> '
            PS3='? '
            PS4='+ '
            ;;

        # Git prompt function
        git)
            # Bail if we have no git(1)
            if ! hash git 2>/dev/null ; then
                return 1
            fi

            # Bail if we're not in a work tree
            local iswt
            iswt=$(git rev-parse --is-inside-work-tree 2>/dev/null)
            if [[ $iswt != true ]] ; then
                return 1
            fi

            # Attempt to determine git branch, bail if we can't
            local branch
            branch=$( {
                git symbolic-ref --quiet HEAD ||
                git rev-parse --short HEAD
            } 2>/dev/null )
            if [[ ! -n $branch ]] ; then
                return 1
            fi
            branch=${branch##*/}

            # Refresh index so e.g. git-diff-files(1) is accurate
            git update-index --refresh >/dev/null

            # Collect symbols representing repository state
            local state
            git diff-files --quiet ||
                state=${state}!
            git diff-index --cached --quiet HEAD ||
                state=${state}+
            [[ -n $(git ls-files --others --exclude-standard) ]] &&
                state=${state}\?
            git rev-parse --quiet --verify refs/stash >/dev/null &&
                state=${state}^

            # Print the status in brackets; add a git: prefix only if there
            # might be another VCS prompt (because PROMPT_VCS is set)
            printf '(%s%s%s)' "${PROMPT_VCS:+git:}" "${branch:-unknown}" "$state"
            ;;

        # Subversion prompt function
        svn)
            # Bail if we have no svn(1)
            if ! hash svn 2>/dev/null ; then
                return 1
            fi

            # Determine the repository URL and root directory
            local key value url root
            while IFS=: read -r key value ; do
                case $key in
                    'URL')
                        url=${value## }
                        ;;
                    'Repository Root')
                        root=${value## }
                        ;;
                esac
            done < <(svn info 2>/dev/null)

            # Exit if we couldn't get either
            if [[ ! -n $url || ! -n $root ]] ; then
                return 1
            fi

            # Remove the root from the URL to get what's hopefully the branch
            # name, removing leading slashes and the 'branches' prefix, and any
            # trailing content after a slash
            local branch
            branch=${url/"$root"}
            branch=${branch#/}
            branch=${branch#branches/}
            branch=${branch%%/*}

            # Parse the output of svn status to determine working copy state
            local symbol
            local -i modified untracked
            while read -r symbol _ ; do
                if [[ $symbol == *'?'* ]] ; then
                    untracked=1
                else
                    modified=1
                fi
            done < <(svn status 2>/dev/null)

            # Add appropriate state flags
            local -a state
            if ((modified)) ; then
                state[${#state[@]}]='!'
            fi
            if ((untracked)) ; then
                state[${#state[@]}]='?'
            fi

            # Print the state in brackets with an svn: prefix
            (IFS= ; printf '(svn:%s%s)' "${branch:-unknown}" "${state[*]}")
            ;;

        # VCS wrapper prompt function; print the first relevant prompt, if any
        vcs)
            local vcs
            for vcs in "${PROMPT_VCS[@]:-git}" ; do
                if prompt "$vcs" ; then
                    return
                fi
            done
            ;;

        # Show return status of previous command in angle brackets, if not zero
        ret)
            if ((PROMPT_RETURN > 0)) ; then
                printf '<%u>' "$PROMPT_RETURN"
            fi
            ;;

        # Show the count of background jobs in curly brackets, if not zero
        job)
            local -i jobc
            while read ; do
                ((jobc++))
            done < <(jobs -p)
            if ((jobc > 0)) ; then
                printf '{%u}' "$jobc"
            fi
            ;;

        # Print error
        *)
            printf '%s: Unknown command %s\n' "$FUNCNAME" "$1" >&2
            return 2
            ;;

    esac
}

# Start with full-fledged prompt
prompt on
