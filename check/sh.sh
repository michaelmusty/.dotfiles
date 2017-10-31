set \
    sh/profile \
    sh/profile.d/*.sh \
    sh/shinit \
    sh/shrc \
    sh/shrc.d/*.sh
for sh ; do
    sh -n -- "$sh" || exit
done
printf 'POSIX shell dotfiles parsed successfully.\n'
