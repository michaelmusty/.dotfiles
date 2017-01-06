# Zsh before version 5.3.0 emulating POSIX sh(1) or Korn shell only sources the
# interactive shell startup file described in ENV if it's set after
# /etc/profile is sourced, but before ~/.profile is. The other shells I have
# tried (including modern shells emulating POSIX sh(1)) wait until after
# ~/.profile is read. This seems to have been fixed in Zsh commit ID fde365e,
# which was followed by release 5.3.0.

# Is this zsh masquerading as sh/ksh?
[ -n "$ZSH_VERSION" ] || return
case $ZSH_NAME in
    sh|ksh) ;;
    *) return ;;
esac

# Iterate through the zsh version number to see if it's at least 5.3.0; if not,
# we'll have ~/.profile force sourcing $ENV
if ! (
    zvs=$ZSH_VERSION
    for fv in 5 3 0 ; do
        zv=${zvs%%[!0-9]*}
        [ "$((zv > fv))" -eq 1 ] && exit 0
        [ "$((zv < fv))" -eq 1 ] && exit 1
        zvs=${zvs#*.}
        [ -n "$zvs" ] || exit 0
    done
) ; then
    ENV_FORCE=1
fi
