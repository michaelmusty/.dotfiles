# If we're running some kind of ksh, we'll need to source its specific
# configuration if it was defined or if we can find it. Bash and Zsh invoke
# their own rc files first, which I've written to then look for ~/.shrc; ksh
# does it the other way around.
case $KSH_VERSION in
    *'PD KSH '*|*'MIRBSD KSH '*)
        [ -f "${KSH_ENV:-"$HOME"/.pdkshrc}" ] || return
        . "${KSH_ENV:-"$HOME"/.pdkshrc}"
        ;;
esac
