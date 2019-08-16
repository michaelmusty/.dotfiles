# Load ~/.profile regardless of shell version
if [ -e "$HOME"/.profile ] ; then
    . "$HOME"/.profile
fi

# If POSIXLY_CORRECT is set after doing that, force the `posix` option on and
# don't load the rest of this stuff--so, just ~/.profile and ENV
if [ -n "$POSIXLY_CORRECT" ] ; then
    set -o posix
    return
fi

# Load any supplementary scripts in ~/.bash_profile.d; it need not exist
for bash in "$HOME"/.bash_profile.d/*.bash ; do
    [ -e "$bash" ] || continue
    . "$bash"
done
unset -v bash

# If ~/.bashrc exists, source that too; the tests for both interactivity and
# minimum version numbers are in there
if [ -f "$HOME"/.bashrc ] ; then
    . "$HOME"/.bashrc
fi
