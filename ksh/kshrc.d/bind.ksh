# Try to bind tab to complete words and Ctrl-Alt-L to clear the screen
# Already done in ksh93
case $KSH_VERSION in

    # More straightforward with mksh; bind keys to the appropriate emacs mode
    # editing commands
    *'MIRBSD KSH'*)
        bind '^I'='complete'
        ;;

    # Similar with pdksh; there's a "complete" command, but not a "clear" one,
    # so we fake it with clear(1) and some yanking
    *'PD KSH'*)
        bind '^I'='complete'
        bind -m '^[^L'='^Uclear^J^Y'
        ;;
esac
