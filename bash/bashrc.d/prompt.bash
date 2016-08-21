# Frontend to controlling prompt
prompt() {

    # What's done next depends on the first argument to the function
    case $1 in

        # Turn complex, colored PS1 and debugging PS4 prompts on
        on)
            # Declare the PROMPT_RETURN variable as an integer
            declare -i PROMPT_RETURN

            # Set up pre-prompt command
            PROMPT_COMMAND='PROMPT_RETURN=$? ; history -a'

            # If Bash 4.0 is available, trim very long paths in prompt
            ((BASH_VERSINFO[0] >= 4)) && PROMPT_DIRTRIM=4

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
                tput colors || tput Co
            } 2>/dev/null )

            # Prepare reset code
            local reset
            reset=$( {
                tput sgr0 || tput me
            } 2>/dev/null )

            # Decide prompt color formatting based on color availability
            local format
            case $colors in

                # Check if we have non-bold bright green available
                256)
                    format=$( {
                        : "${PROMPT_COLOR:=10}"
                        tput setaf "$PROMPT_COLOR" ||
                        tput setaf "$PROMPT_COLOR" 0 0 ||
                        tput AF "$PROMPT_COLOR" ||
                        tput AF "$PROMPT_COLOR" 0 0
                    } 2>/dev/null )
                    ;;

                # If we have only eight colors, use bold green
                8)
                    format=$( {
                        : "${PROMPT_COLOR:=2}"
                        tput setaf "$PROMPT_COLOR" ||
                        tput AF "$PROMPT_COLOR"
                        tput bold || tput md
                    } 2>/dev/null )
                    ;;

                # For all other terminals, we assume non-color (!), and we just
                # use bold
                *)
                    format=$( {
                        tput bold || tput md
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
            # Bail if we're not in a work tree--or, implicitly, if we don't
            # have git(1).
            [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = true ]] ||
                return

            # Attempt to determine git branch, bail if we can't
            local branch
            branch=$( {
                git symbolic-ref --quiet HEAD ||
                git rev-parse --short HEAD
            } 2>/dev/null )
            [[ -n $branch ]] || return
            branch=${branch##*/}

            # Refresh index so e.g. git-diff-files(1) is accurate
            git update-index --refresh >/dev/null

            # Collect symbols representing repository state
            local state

            # Upstream HEAD has commits after local HEAD; we're "behind"
            local -i behind
            behind=$(git rev-list --count 'HEAD..@{u}' 2>/dev/null)
            ((behind)) && state=${state}'<'

            # Local HEAD has commits after upstream HEAD; we're "ahead"
            local -i ahead
            ahead=$(git rev-list --count '@{u}..HEAD' 2>/dev/null)
            ((ahead)) && state=${state}'>'

            # Tracked files are modified
            git diff-files --quiet ||
                state=${state}'!'

            # Changes are staged
            git diff-index --cached --quiet HEAD ||
                state=${state}'+'

            # There are some untracked and unignored files
            [[ -n $(git ls-files --others --exclude-standard) ]] &&
                state=${state}'?'

            # There are stashed changes
            git rev-parse --quiet --verify refs/stash >/dev/null &&
                state=${state}'^'

            # Print the status in brackets; add a git: prefix only if there
            # might be another VCS prompt (because PROMPT_VCS is set)
            printf '(%s%s%s)' \
                "${PROMPT_VCS:+git:}" "${branch:-unknown}" "$state"
            ;;

        # Subversion prompt function
        svn)
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

            # Exit if we couldn't get either--or, implicitly, if we don't have
            # svn(1).
            [[ -n $url ]] || return
            [[ -n $root ]] || return

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
            ((modified)) && state[${#state[@]}]='!'
            ((untracked)) && state[${#state[@]}]='?'

            # Print the state in brackets with an svn: prefix
            (IFS= ; printf '(svn:%s%s)' \
                "${branch:-unknown}" "${state[*]}")
            ;;

        # VCS wrapper prompt function; print the first relevant prompt, if any
        vcs)
            local vcs
            for vcs in "${PROMPT_VCS[@]:-git}" ; do
                prompt "$vcs" && return
            done
            ;;

        # Show return status of previous command in angle brackets, if not zero
        ret)
            ((PROMPT_RETURN)) && printf '<%u>' "$PROMPT_RETURN"
            ;;

        # Show the count of background jobs in curly brackets, if not zero
        job)
            local -i jobc
            while read ; do
                ((jobc++))
            done < <(jobs -p)
            ((jobc)) && printf '{%u}' "$jobc"
            ;;

        # No argument given, print prompt strings and vars
        '')
            declare -p PS1 PS2 PS3 PS4
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
