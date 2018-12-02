# Completion for `source` with files that look like plain text
if ! declare -F _text_filenames >/dev/null ; then
    source "$HOME"/.bash_completion.d/_text_filenames.bash
fi
complete -F _text_filenames -o filenames source
