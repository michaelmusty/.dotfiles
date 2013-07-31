# ssh-askpass setup
if command -v ssh-askpass >/dev/null; then
    SSH_ASKPASS=$(which ssh-askpass)
    export SSH_ASKPASS
fi

# keychain setup
if command -v keychain >/dev/null; then
    eval $(keychain --eval --ignore-missing --quiet id_dsa id_rsa id_ecsda)
fi

