# keychain setup
command -v keychain >/dev/null 2>&1 &&
    eval "$(TERM=${TERM:-ansi} keychain \
        --eval --ignore-missing --quick --quiet \
        id_dsa id_rsa id_ecsda)"
