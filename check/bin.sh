for bin in bin/*.sh ; do
    sh -n -- "${bin%.sh}" || exit
done
printf 'All shell scripts in bin parsed successfully.\n'
