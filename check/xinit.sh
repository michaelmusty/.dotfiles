set \
    X/xinitrc \
    X/xinitrc.d/*.sh
for xinit do
    sh -n -- "$xinit" || exit
done
