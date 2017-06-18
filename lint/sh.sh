find sh ksh/shrc.d mpd/profile.d \
    -type f -print -exec shellcheck -e SC1090 -s sh -- {} +
