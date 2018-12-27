# Zsh before version 5.3.0 emulating POSIX sh(1) or Korn shell only sources the
# interactive shell startup file described in ENV if it's set after
# /etc/profile is sourced, but before ~/.profile is.  The other shells I have
# tried (including modern shells emulating POSIX sh(1)) wait until after
# ~/.profile is read.  This seems to have been fixed in Zsh commit ID fde365e,
# which was followed by release 5.3.0.

# This hack is only applicable to interactive zsh invoked as sh/ksh, when ENV
# exists, so check each of those:
## Interactive?
case $- in
    *i*) ;;
    *) return ;;
esac
## zsh?
[ -n "$ZSH_VERSION" ] || return
## Invoked as sh or ksh?
case $ZSH_NAME in
    sh|ksh) ;;
    *) return ;;
esac
## ENV exists?
[ -e "$ENV" ] || return

# Iterate through the zsh version number to see if it's at least 5.3.0; if not,
# we'll source $ENV ourselves, since ~/.profile probably didn't do it
if (
    zvs=$ZSH_VERSION
    for fv in 5 3 0 ; do
        zv=${zvs%%[!0-9]*}
        ! [ "$zv" -gt "$fv" ] || exit 1
        ! [ "$zv" -lt "$fv" ] || exit 0
        zvs=${ZSH_VERSION#*.}
    done
) ; then
    . "$ENV"
fi
