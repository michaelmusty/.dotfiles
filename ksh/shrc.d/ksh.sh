# If we're running some kind of ksh, we'll need to source its specific
# configuration if it was defined or if we can find it. Bash and Zsh invoke
# their own rc files first, which I've written to then look for ~/.shrc; ksh
# does it the other way around.

# Unfortunately, this isn't very simple, because KSH_VERSION is set by PDKSH
# and derivatives, and in ksh93t+ and above, but not in earlier versions of
# ksh93. To make matters worse, the best way I can find for testing the version
# makes other shells throw tantrums.

# Does the name of our shell have "ksh" in it at all? This is in no way
# guaranteed. It's just a heuristic that e.g. Bash and Yash shouldn't pass.
case $0 in
    *ksh*) ;;
    *) return ;;
esac

# If KSH_VERSION is not already set, we'll try hard to set it to something
# before we proceed ...
if [ -z "$KSH_VERSION" ] ; then

    # Test whether we have content in the .sh.version variable. Suppress errors
    # and run it in a subshell to work around parsing error precedence.
    ( test -n "${.sh.version}" ) 2>/dev/null || return

    # If that peculiarly named variable was set, then that's our KSH_VERSION
    KSH_VERSION=${.sh.version}
fi

# If KSH_ENV isn't already set, set it
[ -n "$KSH_ENV" ] || KSH_ENV=$HOME/.kshrc

# If ENV_EXT isn't already set, set it
[ -n "$ENV_EXT" ] || ENV_EXT=$KSH_ENV
