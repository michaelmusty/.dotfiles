# POSIX sh
set --
for bin in bin/*.sh ; do
    set -- "$@" "${bin%.sh}"
done
shellcheck -e SC1090 -- "$@" || exit
printf 'POSIX shell binscripts linted successfully.\n'

# GNU Bash
if command -v bash >/dev/null 2>&1 ; then
    set --
    for bin in bin/*.bash ; do
        set -- "$@" "${bin%.bash}"
    done
    shellcheck -e SC1090 -- "$@" || exit
    printf 'GNU Bash binscripts linted successfully.\n'
else
    printf 'bash(1) not found, skipping GNU Bash lint.\n'
fi
