# Completion for vim(1) with files that look editable
if ! declare -F _text_filenames >/dev/null ; then
    source "$HOME"/.bash_completion.d/_text_filenames.bash
fi
complete -F _text_filenames -o filenames vim
