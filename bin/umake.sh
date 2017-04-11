# Keep going up the tree until we find a Makefile, and then run make(1) with
# any given args
while [ "$PWD" != / ] ; do
    for mf in makefile Makefile ; do
        [ -f "$mf" ] && exec make "$@"
    done
    cd .. || exit
done
printf >&2 'umake: No makefile found in ancestors\n'
exit 1
