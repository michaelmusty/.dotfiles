# Only if shell is interactive
if [[ $- != *i* ]] ; then
    return
fi

# Only if rem(1) available
if ! hash rem 2>/dev/null ; then
    return
fi

# Only if reminders file exists
if [[ ! -e ${DOTREMINDERS:-$HOME/.reminders} ]] ; then
    return
fi

# Print from subshell to keep namespace clean
(
    while IFS= read -r reminder ; do
        printf '* %s\n' "$reminder"
    done < <(rem -hq)
    printf '\n'
)
