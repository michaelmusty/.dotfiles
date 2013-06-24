# Keychain
command -v ssh-askpass >/dev/null \
    && export SSH_ASKPASS=`which ssh-askpass`
command -v keychain >/dev/null \
    && eval `keychain --eval --ignore-missing --quiet id_dsa id_rsa id_ecsda`

