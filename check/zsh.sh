set \
    zsh/zprofile \
    zsh/zshrc.d/*.zsh \
    zsh/zshrc
for zsh ; do
    zsh -n -- "$zsh" || exit
done
sh -n zsh/profile.d/zsh.sh || exit
printf 'Z shell dotfiles parsed successfully.\n'
