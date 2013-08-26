# Frontend to controlling prompt
prompt() {

    # Variables for use only within this function
    local color reset branch info url root
    local -i colors=$(tput colors)
    local -a state=()

    # What's done next depends on the first argument to the function
    case $1 in

        # Turn complex, colored prompt on
        on)
            PROMPT_COMMAND='ret=$? ; history -a'
            PS1='\[\a\][\u@\h:\w]$(prompt vcs)$(prompt job)$(prompt ret)\$'

            # Check if we have non-bold bright green available
            if ((colors > 8)); then
                color=$(tput setaf 10)

            # If we don't, fall back to the bold green
            else
                color=$(tput setaf 2)$(tput bold)
            fi

            # Reset color and attributes
            reset=$(tput sgr0)

            # String it all together
            PS1="\\[$color\\]$PS1\\[$reset\\] "
            ;;

        # Revert to simple inexpensive prompt
        off)
            PROMPT_COMMAND=
            PS1='\$ '
            ;;

        # Git prompt function
        git)

            # Exit if inside a .git directory
            local isgd=$(git rev-parse --is-inside-git-dir 2>/dev/null)
            if [[ $isgd == true ]]; then
                return 1
            fi

            # Exit if not inside a working tree
            local iswt=$(git rev-parse --is-inside-work-tree 2>/dev/null)
            if [[ $iswt != true ]]; then
                return 1
            fi

            # Read the repository's status to refresh its info; ignore all the
            # output; give up if this fails
            if ! git status &>/dev/null; then
                return 1
            fi

            # Figure out the branch to show for HEAD, whether a symbolic
            # reference or a short SHA-1; chop off any leading path
            branch=$(git symbolic-ref --quiet HEAD 2>/dev/null) \
                || branch=$(git rev-parse --short HEAD 2>/dev/null) \
                || branch='unknown'
            branch=${branch##*/}

            # If there are staged changes in the working tree, add a plus sign
            # to the state
            if ! git diff --quiet --ignore-submodules --cached; then
                state[${#opts[@]}]='+'
            fi

            # If there are any modified tracked files in the working tree, add
            # an exclamation mark to the state
            if ! git diff-files --quiet --ignore-submodules --; then
                state[${#opts[@]}]='!'
            fi

            # If there are any stashed changes, add a circumflex to the state
            if git rev-parse --verify refs/stash &>/dev/null; then
                state[${#opts[@]}]='^'
            fi

            # If there are any new unignored files in the working tree, add a
            # question mark to the state
            if [[ -n $(git ls-files --others --exclude-standard) ]]; then
                state[${#opts[@]}]='?'
            fi

            # Print the status in brackets with a git: prefix
            printf '(git:%s%s)' \
                "${branch:-unknown}" "$(printf %s "${state[@]}")"
            ;;

        # Mercurial prompt function
        hg)

            # Exit if not inside a Mercurial tree
            if ! branch=$(hg branch 2>/dev/null); then
                return 1
            fi

            # If there are changes in the tree, add an exclamation mark to the
            # state
            if [[ -n $(hg status 2>/dev/null) ]]; then
                state[${#opts[@]}]='!'
            fi

            # Print the status in brackets with an hg: prefix
            printf '(hg:%s%s)' \
                "${branch:-unknown}" "$(printf %s "${state[@]}")"
            ;;

        # Subversion prompt function
        svn)

            # Exit if not inside a Subversion working copy
            if ! svn info &>/dev/null; then
                return 1
            fi

            # Determine the repository URL and root directory
            info=$(svn info 2>/dev/null)
            url=$(awk -F': ' '$1 == "URL" {print $2}' <<<"$info")
            root=$(awk -F': ' '$1 == "Repository Root" {print $2}' <<<"$info")

            # Remove the root from the URL to get what's hopefully the branch
            # name, removing leading slashes and the 'branches' prefix, and any
            # trailing content after a slash
            branch=${url/$root}
            branch=${branch#/}
            branch=${branch#branches/}
            branch=${branch%%/*}

            # If there are changes in the working directory, add an exclamation
            # mark to the state
            if [[ -n $(svn status 2>/dev/null) ]]; then
                state[${#opts[@]}]='!'
            fi

            # Print the state in brackets with an svn: prefix
            printf '(svn:%s%s)' \
                "${branch:-unknown}" "$(printf %s "${state[@]}")"
            ;;

        # VCS wrapper prompt function; print the first relevant prompt, if any
        vcs)
            prompt git || prompt svn || prompt hg
            ;;

        # Show the return status of the last command in angle brackets
        ret)
            if ((ret > 0)); then
                printf '<%d>' "$ret"
            fi
            unset ret
            ;;

        # Show the count of background jobs in curly brackets
        job)
            if [[ -n $(jobs) ]]; then
                printf '{%d}' "$(jobs | sed -n '$=')"
            fi
            ;;
    esac
}

# Start with full-fledged prompt
prompt on

