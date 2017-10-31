set -- urxvt/ext/*.pl
for perl ; do
    perl -c "${perl%.pl}" || exit
done
printf 'URxvt Perl extensions parsed successfully.\n'
