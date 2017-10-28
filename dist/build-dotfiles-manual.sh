# Author tool for building the dotfiles(7) manual
cat man/man7/dotfiles.7df.head README.md |
pandoc -sS -t man -o man/man7/dotfiles.7df
