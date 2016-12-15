# Set SSH_ASKPASS if we can find one
command -v ssh-askpass >/dev/null 2>&1 || return
SSH_ASKPASS=$(command -v ssh-askpass)
export SSH_ASKPASS
