set --
for bin in git/template/hooks/*.sh ; do
    set -- "$@" "${bin%.sh}"
done
shellcheck -e SC1090 -- "$@" || exit
