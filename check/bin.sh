# POSIX sh
for bin in bin/*.sh ; do
    sh -n -- "${bin%.sh}" || exit
done
printf 'POSIX sh binscripts parsed successfully.\n'

# GNU Bash
if command -v bash >/dev/null 2>&1 ; then
    for bin in bin/*.bash ; do
        bash -n -- "${bin%.bash}" || exit
    done
    printf 'GNU Bash binscripts parsed successfully.\n'
else
    printf 'bash(1) not found, skipping GNU Bash checks.\n'
fi
