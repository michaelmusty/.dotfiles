# Read extra targets from an optional ~/.dotfiles.conf file
if [ -e "$HOME"/.dotfiles.conf ] ; then
    while read -r line ; do
        case $line in
            '#'*|'') ;;
            *) set -- "$@" "$line" ;;
        esac
    done < "$HOME"/.dotfiles.conf
fi
make install "$@"
