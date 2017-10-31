shellcheck -e SC1090 -s sh -- \
    sh/profile \
    sh/profile.d/* \
    sh/shinit \
    sh/shrc \
    sh/shrc.d/*
