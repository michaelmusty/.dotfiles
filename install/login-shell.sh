shell=$(getent passwd "$USER" | cut -d: -f7)
case ${shell##*/} in
    bash)
        target=install-bash ;;
    ksh|ksh88|ksh93|mksh|pdksh)
        target=install-ksh ;;
    zsh)
        target=install-zsh ;;
    *)
        target=install-sh ;;
esac
make "$target"
