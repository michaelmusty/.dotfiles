# Set SSH_ASKPASS if we can find one
if command -v ssh-askpass >/dev/null 2>&1 ; then
    SSH_ASKPASS=$(command -v ssh-askpass)
    export SSH_ASKPASS
fi
