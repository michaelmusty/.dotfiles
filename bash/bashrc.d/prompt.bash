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

            # Basic prompt shape depends on whether we're in SSH or not
            PS1=
            if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]] ; then
                PS1=$PS1'\u@\h:'
            fi
            PS1=$PS1'\w'

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

            # Check if we have non-bold bright green available
            if ((colors >= 16)) ; then
                format=$( {
                    : "${PROMPT_COLOR:=10}"
                    tput setaf "$PROMPT_COLOR" ||
                    tput setaf "$PROMPT_COLOR" 0 0 ||
                    tput AF "$PROMPT_COLOR" ||
                    tput AF "$PROMPT_COLOR" 0 0
                } 2>/dev/null )

            # If we have only eight colors, use bold green
            elif ((colors >= 8)) ; then
                format=$( {
                    : "${PROMPT_COLOR:=2}"
                    tput setaf "$PROMPT_COLOR" ||
                    tput AF "$PROMPT_COLOR"
                    tput bold || tput md
                } 2>/dev/null )

            # Otherwise, we just try bold
            else
                format=$( {
                    tput bold || tput md
                } 2>/dev/null )
            fi

            # String it all together
            PS1='\['"$format"'\]'"$PS1"'\['"$reset"'\] '
            PS2='> '
            PS3='? '
            PS4='+<$?> ${BASH_SOURCE:-$BASH}:${FUNCNAME[0]}:$LINENO:'
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
            local iswt
            iswt=$(git rev-parse --is-inside-work-tree 2>/dev/null)
            [[ $iswt = true ]] || return

            # Refresh index so e.g. git-diff-files(1) is accurate
            git update-index --refresh >/dev/null

            # Find a local branch, remote branch, or tag (annotated or not), or
            # failing all of that just show the short commit ID, in that order
            # of preference; if none of that works, bail out
            local name
            name=$( {
                git symbolic-ref --quiet HEAD ||
                git describe --all --always --exact-match HEAD
            } 2>/dev/null) || return
            name=${name##*/}
            [[ -n $name ]] || return

            # Check various files in .git to flag processes
            local proc
            [[ -d .git/rebase-merge || -d .git/rebase-apply ]] &&
                proc=${proc:+$proc,}'REBASE'
            [[ -f .git/MERGE_HEAD ]] &&
                proc=${proc:+$proc,}'MERGE'
            [[ -f .git/CHERRY_PICK_HEAD ]] &&
                proc=${proc:+$proc,}'PICK'
            [[ -f .git/REVERT_HEAD ]] &&
                proc=${proc:+$proc,}'REVERT'
            [[ -f .git/BISECT_LOG ]] &&
                proc=${proc:+$proc,}'BISECT'

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
            git diff-files --no-ext-diff --quiet ||
                state=${state}'!'

            # Changes are staged
            git diff-index --cached --no-ext-diff --quiet HEAD 2>/dev/null ||
                state=${state}'+'

            # There are some untracked and unignored files
            git ls-files --directory --error-unmatch --exclude-standard \
                --no-empty-directory --others -- ':/*' >/dev/null 2>&1 &&
                state=${state}'?'

            # There are stashed changes
            git rev-parse --quiet --verify refs/stash >/dev/null &&
                state=${state}'^'

            # Print the status in brackets; add a git: prefix only if there
            # might be another VCS prompt (because PROMPT_VCS is set)
            printf '(%s%s%s%s)' \
                "${PROMPT_VCS:+git:}" "$name" "${proc:+:$proc}" "$state"
            ;;

        # Subversion prompt function
        svn)
            # Determine the repository URL and root directory
            local key value url root
            while [[ -z $url || -z $root ]] && IFS=: read -r key value ; do
                case $key in
                    'URL') url=${value## } ;;
                    'Repository Root') root=${value## } ;;
                esac
            done < <(svn info 2>/dev/null)

            # Exit if we couldn't get either--or, implicitly, if we don't have
            # svn(1).
            [[ -n $url && -n $root ]] || return

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
            while ((!modified || !untracked)) && read -r symbol _ ; do
                case $symbol in
                    *\?*) untracked=1 ;;
                    *) modified=1 ;;
                esac
            done < <(svn status 2>/dev/null)

            # Add appropriate state flags
            local state
            ((modified)) && state=${state}'!'
            ((untracked)) && state=${state}'?'

            # Print the state in brackets with an svn: prefix
            printf '(svn:%s%s)' "${branch:-unknown}" "$state"
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
            while read -r ; do
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
            printf '%s: Unknown command %s\n' "${FUNCNAME[0]}" "$1" >&2
            return 2
            ;;
    esac
}

# Start with full-fledged prompt
prompt on
