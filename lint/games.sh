# POSIX shell
set --
for game in games/*.sh ; do
    set -- "$@" "${game%.sh}"
done
shellcheck -e SC1090 -- "$@" || exit
