for v in vim/* ; do
    [ "$v" != vim/bundle ] || continue
    printf '%s\n' "$v"
    vint -s -- "$v"
done
