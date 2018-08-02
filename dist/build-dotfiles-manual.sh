# Author tool for building the dotfiles(7) manual
cat man/man7/dotfiles.7df.head README.md |
pandoc -s -t man -o man/man7/dotfiles.7df
