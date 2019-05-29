bare=$(git config core.bare)
case $bare in
    true) git update-server-info ;;
esac
