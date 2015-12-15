# Only if shell is interactive
[[ $- == *i* ]] || return

# Only if verse(1) available
hash fortune 2>/dev/null || return

# Run verse(1) if we haven't seen it already today (the verses are selected by
# date); run in a subshell to keep vars out of global namespace
(
    date=$(date +%Y-%m-%d)
    versefile=${VERSEFILE:-$HOME/.verse}
    if [[ -e $versefile ]] ; then
        IFS= read -r lastversedate < "$versefile"
    fi
    if [[ $date > $lastversedate ]] ; then
        verse
        printf '\n'
        printf '%s\n' "$date" > "$versefile"
    fi
)

