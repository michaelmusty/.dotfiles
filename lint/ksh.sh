set \
    ksh/kshrc \
    ksh/kshrc.d/*.ksh
shellcheck -e SC1090 -s ksh -- "$@" || exit
shellcheck -e SC1090 -s sh -- ksh/shrc.d/ksh.sh || exit
printf 'Korn shell dotfiles linted successfully.\n'
