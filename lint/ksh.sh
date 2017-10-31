shellcheck -e SC1090 -s sh -- \
    ksh/shrc.d/*.sh
shellcheck -e SC1090 -s ksh -- \
    ksh/kshrc \
    ksh/kshrc.d/*.ksh
