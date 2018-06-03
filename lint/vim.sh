# Build an argument list of checks to make
set --
for vim in vim/* vim/bundle/* ; do
    [ -e "$vim" ] || continue
    case $vim in

        # Skip third-party plugins
        vim/bundle) ;;
        vim/bundle/repeat) ;;
        vim/bundle/surround) ;;

        # Check everything else
        *) set -- "$@" "$vim" ;;

    esac
done

# Run check
vint -s -- "$@" || exit
printf 'Vim configuration linted successfully.\n'
