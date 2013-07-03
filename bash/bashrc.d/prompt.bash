# Frontend to controlling prompt
function prompt {
    local ret=$?
    local colors=$(tput colors 2>/dev/null)
    local color reset branch head state url root

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
            $(git rev-parse --is-inside-git-dir 2>/dev/null ) \
                && return 1
            $(git rev-parse --is-inside-work-tree 2>/dev/null ) \
                || return 1
            git status &>/dev/null
            branch=$(git symbolic-ref --quiet HEAD 2>/dev/null ) \
                || branch=$(git rev-parse --short HEAD 2>/dev/null ) \
                || branch='unknown'
            branch=${branch##*/}
            git diff --quiet --ignore-submodules --cached \
                || state=${state}+
            git diff-files --quiet --ignore-submodules -- \
                || state=${state}!
            $(git rev-parse --verify refs/stash &>/dev/null ) \
                && state=${state}^
            [ -n "$(git ls-files --others --exclude-standard )" ] \
                && state=${state}?
            printf '(git:%s)' "${branch:-unknown}${state}"
            ;;

        # Mercurial prompt function
        hg)
            hg branch &>/dev/null || return 1
            branch="$(hg branch 2>/dev/null)"
            [[ -n "$(hg status 2>/dev/null)" ]] && state="!"
            printf '(hg:%s)' "${branch:-unknown}${state}"
            ;;

        # Subversion prompt function
        svn)
            svn info &>/dev/null || return 1
            url="$(svn info 2>/dev/null | \
                awk -F': ' '$1 == "URL" {print $2}')"
            root="$(svn info 2>/dev/null | \
                awk -F': ' '$1 == "Repository Root" {print $2}')"
            branch=${url/$root}
            branch=${branch#/}
            branch=${branch#branches/}
            branch=${branch%%/*}
            [[ -n "$(svn status 2>/dev/null)" ]] && state="!"
            printf '(svn:%s)' "${branch:-unknown}${state}"
            ;;

        # VCS wrapper prompt function
        vcs)
            prompt git || prompt svn || prompt hg
            ;;

        # Return status prompt function
        return)
            [[ $ret -ne 0 ]] && printf '<%d>' ${ret}
            ;;

        # Job count prompt function
        jobs)
            [[ -n "$(jobs)" ]] && printf '{%d}' $(jobs | sed -n '$=')
            ;;
    esac
}

# Start with full-fledged prompt
prompt on

