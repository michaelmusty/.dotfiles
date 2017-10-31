set \
    sh/profile \
    sh/profile.d/*.sh \
    sh/shinit \
    sh/shrc \
    sh/shrc.d/*.sh
shellcheck -e SC1090 -s sh -- "$@" || exit
printf 'POSIX shell dotfiles linted successfully.\n'
