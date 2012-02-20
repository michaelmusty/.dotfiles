#!/bin/bash
cd $HOME/.dotfiles
git submodule update --init
cd $HOME
rm -f .bashrc
rm -f .bash_profile .bash_login .profile
rm -f .gitconfig
rm -f .tmux.conf
rm -f .vimrc
rm -f .gvimrc
rm -fr .vim
ln -s .dotfiles/bash/bashrc .bashrc
ln -s .dotfiles/bash/bash_profile .bash_profile
ln -s .dotfiles/git/gitconfig .gitconfig
ln -s .dotfiles/tmux/tmux.conf .tmux.conf
ln -s .dotfiles/vim/vimrc .vimrc
ln -s .dotfiles/vim/gvimrc .gvimrc
ln -s .dotfiles/vim .vim

