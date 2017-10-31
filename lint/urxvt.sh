set --
for pl in urxvt/ext/*.pl ; do
    set -- "$@" "${pl%.pl}"
done
perlcritic --brutal -- "${pl%.pl}"
printf 'URxvt Perl extensions linted successfully.\n'
