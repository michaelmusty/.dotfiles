for perl in urxvt/ext/*.pl ; do
    perl -c "${perl%.pl}" || exit
done
