# Frontend to controlling prompt
function prompt {

    # If no arguments, print the prompt strings as they are
    if ! (($#)) ; then
        printf '%s\n' PS1="$PS1" PS2="$PS2" PS3="$PS3" PS4="$PS4"
        return
    fi

    # What's done next depends on the first argument to the function
    case $1 in

        # Turn complex, colored PS1 and debugging PS4 prompts on
        on)
            # Basic prompt shape depends on whether we're in SSH or not
            PS1=
            if [[ -n $SSH_CLIENT ]] || [[ -n $SSH_CONNECTION ]] ; then
                PS1=$PS1'$USER@${HOSTNAME%%.*}:'
            fi

            # Add sub-commands; working directory with ~ abbreviation, VCS, job
            # count, and previous command return value
            PS1=$PS1'$(ret=$?;prompt pwd;prompt vcs;prompt job;prompt ret)'

            # Add prefix and suffix
            PS1='${PROMPT_PREFIX}'$PS1'${PROMPT_SUFFIX}'

            # Add terminating "$" or "#" sign
            PS1=$PS1'\$'

            # Add > symbols to show nested shells
            typeset shlvl
            shlvl=1
            while ((shlvl < SHLVL)); do
                PS1='>'$PS1
                ((shlvl++))
            done

            # Declare variables to contain terminal control strings
            typeset format reset

            # Disregard output and error from these tput(1) calls
            {
                # Count available colors
                typeset -i colors
                colors=$(tput colors || tput Co)

                # Prepare reset code
                reset=$(tput sgr0 || tput me)

                # Check if we have non-bold bright yellow available
                if ((colors >= 16)) ; then
                    format=$(
                        pc=${PROMPT_COLOR:-11}
                        tput setaf "$pc" ||
                        tput setaf "$pc" 0 0 ||
                        tput AF "$pc" ||
                        tput AF "$pc" 0 0
                    )

                # If we have only eight colors, use bold yellow
                elif ((colors >= 8)) ; then
                    format=$(
                        pc=${PROMPT_COLOR:-3}
                        tput setaf "$pc" || tput AF "$pc"
                        tput bold || tput md
                    )

                # Otherwise, we just try bold
                else
                    format=$(tput bold || tput md)
                fi

            } >/dev/null 2>&1

            # Play ball with ksh's way of escaping non-printing characters
            typeset es nl
            es=$(printf '\00')
            nl=$(printf '\n')

            # String it all together
            PS1="${es}${nl}${es}${format}${es}${PS1}${es}${reset}${es}"' '
            PS2='> '
            PS3='? '
            PS4='+<$?> $LINENO:'
            ;;

        # Git prompt function
        git)

            # Wrap as compound command; we don't want to see output from any of
            # these git(1) calls
            {
                # Bail if we're not in a work tree--or, implicitly, if we don't
                # have git(1).
                [[ -n $(git rev-parse --is-inside-work-tree) ]] ||
                    return

                # Refresh index so e.g. git-diff-files(1) is accurate
                git update-index --refresh

                # Find a local branch, remote branch, or tag (annotated or
                # not), or failing all of that just show the short commit ID,
                # in that order of preference; if none of that works, bail out
                typeset name
                name=$(
                    git symbolic-ref --quiet HEAD ||
                    git describe --tags --exact-match HEAD ||
                    git rev-parse --short HEAD
                ) || return
                name=${name##*/}
                [[ -n $name ]] || return

                # Check various files in .git to flag processes
                typeset proc
                [[ -d .git/rebase-merge || -d .git/rebase-apply ]] &&
                    proc=${proc:+"$proc",}'REBASE'
                [[ -f .git/MERGE_HEAD ]] &&
                    proc=${proc:+"$proc",}'MERGE'
                [[ -f .git/CHERRY_PICK_HEAD ]] &&
                    proc=${proc:+"$proc",}'PICK'
                [[ -f .git/REVERT_HEAD ]] &&
                    proc=${proc:+"$proc",}'REVERT'
                [[ -f .git/BISECT_LOG ]] &&
                    proc=${proc:+"$proc",}'BISECT'

                # Collect symbols representing repository state
                typeset state

                # Upstream HEAD has commits after local HEAD; we're "behind"
                (($(git rev-list --count 'HEAD..@{u}'))) &&
                    state=${state}'<'

                # Local HEAD has commits after upstream HEAD; we're "ahead"
                (($(git rev-list --count '@{u}..HEAD'))) &&
                    state=${state}'>'

                # Tracked files are modified
                git diff-files --no-ext-diff --quiet ||
                    state=${state}'!!'

                # Changes are staged
                git diff-index --cached --no-ext-diff --quiet HEAD ||
                    state=${state}'+'

                # There are some untracked and unignored files
                git ls-files --directory --error-unmatch --exclude-standard \
                    --no-empty-directory --others -- ':/*' &&
                    state=${state}'?'

                # There are stashed changes
                git rev-parse --quiet --verify refs/stash &&
                    state=${state}'^'

            } >/dev/null 2>&1

            # Print the status in brackets; add a git: prefix only if there
            # might be another VCS prompt (because PROMPT_VCS is set)
            printf '(%s%s%s%s)' \
                "${PROMPT_VCS:+git:}" "$name" "${proc:+:"$proc"}" "$state"
            ;;

        # Revert to simple inexpensive prompts
        off)
            PS1='\$ '
            PS2='> '
            PS3='? '
            PS4='+ '
            ;;

        # Abbreviated working directory
        pwd)
            case $PWD in
                "$HOME"|"$HOME"/*) printf ~%s "${PWD#"$HOME"}" ;;
                *) printf %s "$PWD" ;;
            esac
            ;;

        # VCS wrapper prompt function; print the first relevant prompt, if any
        vcs)
            typeset vcs
            for vcs in "${PROMPT_VCS[@]:-git}" ; do
                prompt "$vcs" && return
            done
            ;;

        # Show return status of previous command in angle brackets, if not zero
        ret)
            ((ret)) && printf '<%u>' "$ret"
            ;;

        # Show the count of background jobs in curly brackets, if not zero
        job)
            typeset -i jobc
            jobc=$(jobs -p | sed -n '$=')
            ((jobc)) && printf '{%u}' "$jobc"
            ;;

        # Print error
        *)
            printf 'prompt: Unknown command %s\n' "$1" >&2
            return 2
            ;;

    esac
}

# Start with full-fledged prompt
prompt on
