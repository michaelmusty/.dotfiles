set -- \
    vim/after \
    vim/compiler \
    vim/config \
    vim/ftdetect \
    vim/gvimrc \
    vim/indent \
    vim/plugin \
    vim/vimrc
vint -s -- "$@" || exit
printf 'Vim configuration linted successfully.\n'
