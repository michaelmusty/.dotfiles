# Only if shell is interactive
if [[ $- != *i* ]] ; then
    return
fi

# Only if fortune(6) available
if ! hash fortune 2>/dev/null ; then
    return
fi

# Print from subshell to keep namespace clean
(
    if [[ -d $HOME/.local/share/games/fortunes ]] ; then
        FORTUNE_PATH=${FORTUNE_PATH:-$HOME/.local/share/games/fortunes}
    fi
    printf '\n'
    fortune -s "$FORTUNE_PATH"
    printf '\n'
)
