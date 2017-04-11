# Ideally, we'd use plain old ed(1), but many Linux distributions don't install
# it by default
if command -v ed >/dev/null 2>&1 ; then
    EDITOR=ed

# Failing that, if we have both vim(1) and exm(1df) in our $PATH, use the
# latter to work around Vim's ex mode screen-clearing
elif { command -v vim && command -v exm ; } >/dev/null 2>&1 ; then
    EDITOR=exm

# Otherwise, just call ex(1) directly
else
    EDITOR=ex
fi

export EDITOR
