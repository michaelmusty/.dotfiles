# Keychain
if command -v ssh-askpass >/dev/null; then
    export SSH_ASKPASS=`which ssh-askpass`
fi
if command -v keychain >/dev/null; then
    eval `keychain --eval --ignore-missing --quiet id_dsa id_rsa id_ecsda`
fi

