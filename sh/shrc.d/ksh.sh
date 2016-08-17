# If we're running some kind of ksh, we'll need to source its specific
# configuration if it was defined or if we can find it
case $KSH_VERSION in
    *'PD KSH '*)
        [ -f "${KSH_ENV:-"$HOME"/.pdkshrc}" ] || return
        . "${KSH_ENV:-"$HOME"/.pdkshrc}"
        ;;
esac
