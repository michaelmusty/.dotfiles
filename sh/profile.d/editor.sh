# Ideally, we'd use plain old ed(1), but many Linux distributions don't install
# it by default
if command -v ed >/dev/null 2>&1 ; then
    EDITOR=ed

# Failing that, if the system's implementation of ex(1) looks like Vim and we
# have exm(1df) in our $PATH, use the latter to work around Vim's ex mode
# screen-clearing
elif (
    command -v ex >/dev/null 2>&1 || exit 1
    command -v exm >/dev/null 2>&1 || exit 1
    ver=$(ex --version 2>/dev/null | awk 'NR==1{print $1;exit}')
    case $ver in
        (VIM) exit 0 ;;
        (*)   exit 1 ;;
    esac
) >/dev/null 2>&1 ; then
    EDITOR=exm

# Otherwise, we can just call ex(1) directly
else
    EDITOR=ex
fi

export EDITOR
