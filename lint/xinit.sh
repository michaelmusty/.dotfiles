set \
    X/xinitrc \
    X/xinitrc.d/*.sh
shellcheck -e SC1090 -s sh -- "$@"
