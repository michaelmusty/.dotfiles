set --
for sh in bin/*.sh ; do
    set "$@" "${sh%.sh}"
done
shellcheck -e SC1090 -- "$@" || exit
printf 'sh(1) binscripts linted successfully.\n'
