for bin in bin/*.sh ; do
    sh -n -- "${bin%.sh}" || exit
done
printf 'sh(1) binscripts parsed successfully.\n'
