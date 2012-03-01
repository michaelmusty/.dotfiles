#!/bin/bash

# Check out submodules. The --git-dir option doesn't work here.
cd "${HOME}/.dotfiles"
git submodule --quiet update --init
cd "${OLDPWD}"

# Link in files, replacing whatever's already there.
ln -fs ".dotfiles/bash/bashrc"       "${HOME}/.bashrc"
ln -fs ".dotfiles/bash/bash_profile" "${HOME}/.bash_profile"
ln -fs ".dotfiles/bash/bash_logout"  "${HOME}/.bash_logout"
ln -fs ".dotfiles/git/gitconfig"     "${HOME}/.gitconfig"
ln -fs ".dotfiles/readline/inputrc"  "${HOME}/.inputrc"
ln -fs ".dotfiles/tmux/tmux.conf"    "${HOME}/.tmux.conf"
ln -fs ".dotfiles/vim/vimrc"         "${HOME}/.vimrc"
ln -fs ".dotfiles/vim/gvimrc"        "${HOME}/.gvimrc"

# Link in directories, removing whatever's already there first.
if [ -e "${HOME}/.vim" ]; then
    rm -r "${HOME}/.vim"
fi
ln -fs ".dotfiles/vim" "${HOME}/.vim"

# Touch tmux local conf file.
touch ~/.tmux.conf.local

