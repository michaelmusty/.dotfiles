for perl in urxvt/ext/*.pl ; do
    perl -c "$perl" || exit
done
printf 'All Perl scripts in urxvt/ext parsed successfully.\n'
