shell=$(getent passwd "$USER" | cut -d: -f7)
case ${shell##*/} in
    bash)
        target=check-bash ;;
    ksh|ksh88|ksh93|mksh|pdksh)
        target=check-ksh ;;
    zsh)
        target=check-zsh ;;
    *)
        target=check-sh ;;
esac
make "$target"
