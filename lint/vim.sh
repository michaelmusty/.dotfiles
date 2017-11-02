set -- \
    vim/after \
    vim/config \
    vim/ftdetect \
    vim/ftplugin \
    vim/gvimrc \
    vim/indent \
    vim/plugin \
    vim/vimrc
vint -s -- "$@" || exit
printf 'Vim configuration linted successfully.\n'
