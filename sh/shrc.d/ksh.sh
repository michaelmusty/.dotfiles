# If we're running some kind of ksh, we'll need to source its specific
# configuration if it was defined or if we can find it. Bash and Zsh invoke
# their own rc files first, which I've written to then look for ~/.shrc; ksh
# does it the other way around.

# Unfortunately, this isn't very simple, because KSH_VERSION is set by PDKSH
# and derivatives, and in ksh93t+ and above, but not in earlier versions of
# ksh93.

# If it's not already set, we'll try hard to set it to something before we
# proceed ...
if [ -z "$KSH_VERSION" ] ; then

    # Do we have the '[[' builtin? Good start
    command -v '[[' >/dev/null 2>&1 || return

    # Use the '[[' builtin to test whether $.sh.version is set (yes, that's a
    # real variable name)
    [[ -v .sh.version ]] || return

    # If it is, that's our KSH_VERSION
    KSH_VERSION=${.sh.version}
fi

# If KSH_ENV isn't already set, set it
[ -n "$KSH_ENV" ] || KSH_ENV=$HOME/.kshrc

# Check the file named in KSH_ENV exists
[ -f "$KSH_ENV" ] || return

# Source it (finally)
. "$KSH_ENV"
