# POSIX sh
for bin in bin/*.sh ; do
    sh -n -- "${bin%.sh}" || exit
done
printf 'sh(1) binscripts parsed successfully.\n'

# GNU Bash
if command -v bash >/dev/null 2>&1 ; then
    for bin in bin/*.bash ; do
        bash -n -- "${bin%.bash}" || exit
    done
    printf 'bash(1) binscripts parsed successfully.\n'
else
    printf 'bash(1) not found, skipping checks.\n'
fi
