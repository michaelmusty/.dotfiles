updateshell() {
    cd ~/.dotfiles
    git submodule init
    git submodule update
    make
    make -n install
    make install
}
