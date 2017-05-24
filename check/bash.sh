for bash in bash/* bash/bashrc.d/* ; do
    [ -f "$bash" ] || continue
    bash -n "$bash" || exit
done
printf 'All bash(1) scripts parsed successfully.\n'