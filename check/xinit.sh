for xinit in X/xinitrc X/xinitrc.d/*.sh ; do
    sh -n "$xinit" || exit
done
printf 'X/xinitrc and all shell scripts in X/xinitrc.d parsed successfully.\n'
