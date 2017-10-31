set \
    ksh/kshrc \
    ksh/kshrc.d/*.ksh
for ksh ; do
    ksh -n -- "$ksh" || exit
done
sh -n -- ksh/shrc.d/ksh.sh || exit
printf 'Korn shell dotfiles parsed successfully.\n'
