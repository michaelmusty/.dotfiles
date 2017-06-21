for sh in \
    sh/* sh/profile.d/* sh/shrc.d/* \
    keychain/profile.d/* keychain/shrc.d/* \
    ksh/shrc.d/* \
    mpd/profile.d/* \
    plenv/profile.d/* plenv/shrc.d/* \
; do
    [ -f "$sh" ] || continue
    sh -n "$sh" || exit
done
printf 'All sh(1) scripts parsed successfully.\n'
