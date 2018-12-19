# POSIX shell
for bin in bin/*.sh ; do
    sh -n -- "${bin%.sh}" || exit
done

# GNU Bash
if command -v bash >/dev/null 2>&1 ; then
    for bin in bin/*.bash ; do
        bash -n -- "${bin%.bash}" || exit
    done
fi
