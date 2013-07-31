# Frontend to controlling prompt
prompt() {
    local -i ret=$?
    local -i colors=$(tput colors 2>/dev/null)
    local color reset branch state info url root

    if [[ $colors -ge 256 ]]; then
        color='\[\e[38;5;10m\]'
        reset='\[\e[0m\]'
    elif [[ $colors -ge 8 ]]; then
        color='\[\e[1;32m\]'
        reset='\[\e[0m\]'
    fi

    case "$1" in

        # Turn complex coloured prompt on
        on) 
            PROMPT_COMMAND='history -a'
            PS1='\[\a\][\u@\h:\w]$(prompt return)$(prompt vcs)$(prompt jobs)\$'
            PS1="${color}${PS1}${reset} "
            ;;

        # Revert to simple inexpensive prompt
        off)
            PROMPT_COMMAND=
            PS1='\[\a\]\$ '
            ;;

        # Git prompt function
        git)
            if $(git rev-parse --is-inside-git-dir 2>/dev/null); then
                return 1
            fi
            if ! $(git rev-parse --is-inside-work-tree 2>/dev/null); then
                return 1
            fi
            git status &>/dev/null
            branch=$(git symbolic-ref --quiet HEAD 2>/dev/null) \
                || branch=$(git rev-parse --short HEAD 2>/dev/null) \
                || branch='unknown'
            branch=${branch##*/}
            if ! git diff --quiet --ignore-submodules --cached; then
                state=${state}+
            fi
            if ! git diff-files --quiet --ignore-submodules --; then
                state=${state}!
            fi
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                state=${state}^
            fi
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                state=${state}?
            fi
            printf '(git:%s)' "${branch:-unknown}${state}"
            ;;

        # Mercurial prompt function
        hg)
            if ! branch="$(hg branch 2>/dev/null)"; then
                return 1
            fi
            if [[ -n "$(hg status 2>/dev/null)" ]]; then
                state="!"
            fi
            printf '(hg:%s)' "${branch:-unknown}${state}"
            ;;

        # Subversion prompt function
        svn)
            if ! svn info &>/dev/null; then
                return 1
            fi
            info="$(svn info 2>/dev/null)"
            url="$(awk -F': ' '$1 == "URL" {print $2}' \
                <<<"$info")"
            root="$(awk -F': ' '$1 == "Repository Root" {print $2}' \
                <<<"$info")"
            branch=${url/$root}
            branch=${branch#/}
            branch=${branch#branches/}
            branch=${branch%%/*}
            if [[ -n "$(svn status 2>/dev/null)" ]]; then
                state="!"
            fi
            printf '(svn:%s)' "${branch:-unknown}${state}"
            ;;

        # VCS wrapper prompt function
        vcs)
            prompt git || prompt svn || prompt hg
            ;;

        # Return status prompt function
        return)
            if [[ $ret -ne 0 ]]; then
                printf '<%d>' ${ret}
            fi
            ;;

        # Job count prompt function
        jobs)
            if [[ -n "$(jobs)" ]]; then
                printf '{%d}' $(jobs | sed -n '$=')
            fi
            ;;
    esac
}

# Start with full-fledged prompt
prompt on

