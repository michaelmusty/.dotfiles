set --
for sh in bin/*.sh ; do
    set "$@" "${sh%.sh}"
done
shellcheck -e SC1090 -- "$@"
