# If we're running some kind of ksh, export ENV to find ~/.kshrc
if [ -n "$KSH_VERSION" ] ; then
    ENV=$HOME/.kshrc
    export ENV
fi
