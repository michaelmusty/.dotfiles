target=check-sh
case ${SHELL##*/} in
    bash)
        target=check-bash ;;
    ksh|ksh88|ksh93|mksh|pdksh)
        target=check-ksh ;;
    zsh)
        target=check-zsh ;;
esac
make "$target"
