# Keychain
command -v ssh-askpass >/dev/null 2>&1 \
    && export SSH_ASKPASS=`which ssh-askpass`
command -v keychain >/dev/null 2>&1 \
    && eval `keychain --eval --ignore-missing --quiet id_dsa id_rsa id_ecsda`

