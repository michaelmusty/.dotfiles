set \
    X/xinitrc \
    X/xinitrc.d/*.sh
for xinit ; do
    sh -n -- "$xinit" || exit
done
printf 'Xinit startup scripts parsed successfully.\n'
