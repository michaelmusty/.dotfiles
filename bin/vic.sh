# If the system vi is Vim, start it with -C for 'compatible'
ver=$(vim --version 2>/dev/null | awk '{print $1;exit}')
case $ver in
    (VIM) vim -C "$@" ;;
    (*) vi "$@" ;;
esac
