for sh in sh/* sh/profile.d/* sh/shrc.d/* ; do
    [ -f "$sh" ] || continue
    sh -n "$sh" || exit
done
printf 'All sh(1) scripts parsed successfully.\n'
