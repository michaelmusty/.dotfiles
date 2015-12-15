# Only if shell is interactive
[[ $- == *i* ]] || return

# Only if rem(1) available
hash rem 2>/dev/null || return

# Only if $HOME/.reminders exists
[[ -e $HOME/.reminders ]] || return

# Print from subshell to keep namespace clean
(
    while IFS= read -r reminder ; do
        printf '* %s\n' "$reminder"
    done < <(rem -hq)
    printf '\n'
)

