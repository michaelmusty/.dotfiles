set -- \
    vim/after \
    vim/bundle/auto_cache_dirs \
    vim/bundle/big_file_options \
    vim/bundle/copy_linebreak \
    vim/bundle/fixed_join \
    vim/bundle/insert_suspend_hlsearch \
    vim/bundle/juvenile \
    vim/bundle/mail_mutt \
    vim/bundle/sahara \
    vim/bundle/strip_trailing_whitespace \
    vim/bundle/toggle_option_flags \
    vim/bundle/uncap_ex \
    vim/compiler \
    vim/config \
    vim/ftdetect \
    vim/gvimrc \
    vim/indent \
    vim/vimrc
vint -s -- "$@" || exit
printf 'Vim configuration linted successfully.\n'
