target=install-sh
case ${SHELL##*/} in
    bash)
        target=install-bash ;;
    ksh|ksh88|ksh93|mksh|pdksh)
        target=install-ksh ;;
    yash)
        target=install-yash ;;
    zsh)
        target=install-zsh ;;
esac
make "$target"
