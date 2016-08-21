# ssh-askpass setup
[ -n "${SSH_ASKPASS:="$(command -v ssh-askpass 2>&1)"}" ] &&
    export SSH_ASKPASS

# keychain setup
if command -v keychain >/dev/null 2>&1 ; then

    # Run keychain as quickly and quietly as possible
    eval "$(TERM=${TERM:-ansi} keychain \
        --eval --ignore-missing --quick --quiet \
        id_dsa id_rsa id_ecsda)"
fi
