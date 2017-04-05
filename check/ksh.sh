for ksh in ksh/* ksh/kshrc.d/* ; do
    [ -f "$ksh" ] || continue
    ksh -n "$ksh" || exit
done
printf 'All ksh scripts parsed successfully.\n'
