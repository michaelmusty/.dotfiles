# If we're running some kind of ksh, export ENV to find ~/.kshrc. Bash differs
# considerably from this behaviour; it uses ENV as its startup file when it's
# invoked as sh(1), and uses .bashrc or --rcfile as its interactive startup
# file, so it doesn't need to be specified here.
if [ -n "$KSH_VERSION" ] ; then
    ENV=$HOME/.kshrc
    export ENV
fi
