# POSIX shell
set --
for bin in bin/*.sh ; do
    set -- "$@" "${bin%.sh}"
done
shellcheck -e SC1090 -- "$@" || exit

# GNU Bash
if command -v bash >/dev/null 2>&1 ; then
    set --
    for bin in bin/*.bash ; do
        set -- "$@" "${bin%.bash}"
    done
    shellcheck -e SC1090 -- "$@" || exit
fi
