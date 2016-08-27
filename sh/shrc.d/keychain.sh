# If GPG_AGENT_INFO is set, update GPG_TTY for clean use of pinentry(1) etc
[ -n "$GPG_AGENT_INFO" ] || return
GPG_TTY=$(command -p tty)
export GPG_TTY
