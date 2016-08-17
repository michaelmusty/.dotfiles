# If GPG_TTY is set, update it
[ -n "$GPG_TTY" ] || return
GPG_TTY=$(tty)
