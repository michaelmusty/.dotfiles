# Completion for mutt(1) with abook(1) email addresses
if ! declare -F _text_filenames >/dev/null ; then
    source "$HOME"/.bash_completion.d/_text_filenames.bash
fi
complete -F _abook_addresses -o bashdefault -o default mutt
