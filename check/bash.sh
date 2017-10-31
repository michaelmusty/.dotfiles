set \
    bash/bash_completion \
    bash/bash_completion.d/*.bash \
    bash/bash_logout \
    bash/bash_profile \
    bash/bashrc \
    bash/bashrc.d/*.bash
for bash ; do
    bash -n -- "$bash" || exit
done
printf 'GNU Bash dotfiles parsed successfully.\n'
