set \
    bash/bash_completion \
    bash/bash_completion.d/*.bash \
    bash/bash_logout \
    bash/bash_profile \
    bash/bashrc \
    bash/bashrc.d/*.bash
shellcheck -e SC1090 -s bash -- "$@" || exit
printf 'GNU Bash dotfiles linted successfully.\n'
