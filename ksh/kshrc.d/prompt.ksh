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
            if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]] ; then
                PS1=$PS1'${HOSTNAME%%.*}:'
            fi

            # Add sub-commands; working directory with ~ abbreviation, VCS, job
            # count, and previous command return value
            PS1=$PS1'$(ret=$?;jobc=$(jobs -p|sed -n '\''$='\'');prompt pwd;prompt vcs;prompt job;prompt ret;:)'

            # Add a helpful prefix if this shell appears to be exotic
            typeset ksh
            case $KSH_VERSION in
                (*'93'*) ksh=ksh93 ;;
                (*'PD KSH'*) ksh=pdksh ;;
                (*'MIRBSD KSH'*) ksh=mksh ;;
            esac
            case ${SHELL##*/} in
                (''|ksh|"$ksh") ;;
                (*) PS1=$ksh:$PS1 ;;
            esac

            # Add prefix and suffix
            PS1='${PROMPT_PREFIX}'$PS1'${PROMPT_SUFFIX}'

            # Add terminating "$" or "#" sign
            PS1=$PS1'\$'

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
            typeset es cr
            es=$(printf '\01')
            cr=$(printf '\r')

            # String it all together
            PS1="${es}${cr}${es}${format}${es}${PS1}${es}${reset}${es}"' '
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
                name=${name#refs/*/}
                [[ -n $name ]] || return

                # Check various files in .git to flag processes
                typeset proc
                if [[ -d .git/rebase-merge || -d .git/rebase-apply ]] ; then
                    proc=${proc:+"$proc",}'REBASE'
                fi
                if [[ -f .git/MERGE_HEAD ]] ; then
                    proc=${proc:+"$proc",}'MERGE'
                fi
                if [[ -f .git/CHERRY_PICK_HEAD ]] ; then
                    proc=${proc:+"$proc",}'PICK'
                fi
                if [[ -f .git/REVERT_HEAD ]] ; then
                    proc=${proc:+"$proc",}'REVERT'
                fi
                if [[ -f .git/BISECT_LOG ]] ; then
                    proc=${proc:+"$proc",}'BISECT'
                fi

                # Collect symbols representing repository state
                typeset state

                # Upstream HEAD has commits after local HEAD; we're "behind"
                if (($(git rev-list --count 'HEAD..@{u}'))) ; then
                    state=${state}'<'
                fi

                # Local HEAD has commits after upstream HEAD; we're "ahead"
                if (($(git rev-list --count '@{u}..HEAD'))) ; then
                    state=${state}'>'
                fi

                # Tracked files are modified
                if ! git diff-files --no-ext-diff --quiet ; then

                    # Different ksh flavours process a bang in PS1 after prompt
                    # parameter expansion in different ways
                    case $KSH_VERSION in

                        # ksh93 requires a double-bang to escape it
                        (*'93'*) state=${state}'!!' ;;

                        # OpenBSD's pdksh requires a double-bang too, but its
                        # upstream does not
                        (*'PD KSH'*)
                            case $OS in
                                ('OpenBSD') state=${state}'!!' ;;
                                (*) state=${state}'!' ;;
                            esac
                            ;;

                        # Everything else should need only one bang
                        (*) state=${state}'!' ;;
                    esac
                fi

                # Changes are staged
                if ! git diff-index --cached --no-ext-diff --quiet HEAD ; then
                    state=${state}'+'
                fi

                # There are some untracked and unignored files
                if git ls-files --directory --error-unmatch \
                        --exclude-standard --no-empty-directory \
                        --others -- ':/*' ; then
                    state=${state}'?'
                fi

                # There are stashed changes
                if git rev-parse --quiet --verify refs/stash ; then
                    state=${state}'^'
                fi

            } >/dev/null 2>&1

            # Print the status in brackets; add a git: prefix only if there
            # might be another VCS prompt (because PROMPT_VCS is set)
            printf '(%s%s%s%s)' \
                "${PROMPT_VCS:+git:}" "$name" "${proc:+:"$proc"}" "$state"
            ;;

        # Revert to simple inexpensive prompts
        off)
            PS1='$ '
            PS2='> '
            PS3='? '
            PS4='+ '
            if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]] ; then
                PS1=$(hostname -s)'$ '
            fi
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
            # shellcheck disable=SC2154
            if ((ret)) ; then
                printf '<%u>' "$ret"
            fi
            ;;

        # Show the count of background jobs in curly brackets, if not zero
        job)
            # shellcheck disable=SC2154
            if ((jobc)) ; then
                printf '{%u}' "$jobc"
            fi
            ;;

        # Print error
        *)
            printf 'prompt: Unknown command %s\n' "$1" >&2
            return 2
            ;;

    esac
}

# Default to a full-featured prompt, but use PROMPT_MODE if that's set
prompt "${PROMPT_MODE:-on}"
