# If we're running some kind of ksh, we'll need to source its specific
# configuration if it was defined or if we can find it. Bash and Zsh invoke
# their own rc files first, which I've written to then look for ~/.shrc; ksh
# does it the other way around.
[ -n "$KSH_VERSION" ] || [ -n "${.sh.version}" ] || return
[ -n "$KSH_ENV" ] || KSH_ENV=$HOME/.kshrc
[ -f "$KSH_ENV" ] || return
. "$KSH_ENV"
