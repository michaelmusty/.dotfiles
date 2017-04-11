for yash in yash/* ; do
    [ -f "$yash" ] || continue
    yash -n "$yash" || exit
done
printf 'All yash scripts parsed successfully.\n'
