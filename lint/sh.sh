find sh \
    keychain/profile.d keychain/shrc.d \
    ksh/shrc.d \
    mpd/profile.d \
    plenv/profile.d plenv/shrc.d \
    -type f -print -exec shellcheck -e SC1090 -s sh -- {} +
