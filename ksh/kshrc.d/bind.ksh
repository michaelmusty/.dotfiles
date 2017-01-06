# Try to bind ^I to complete words and ^L to clear the screen
case $KSH_VERSION in

    # ksh93 is lovely, but complex; rebind ^L so it does the same as Alt-^L
    *'93'*)
        bind() {
            # shellcheck disable=SC2154
            case ${.sh.edchar} in
                $'\f') .sh.edchar=$'\e\f' ;;
            esac
        }
        trap bind KEYBD
        ;;

    # More straightforward with mksh; bind keys to the appropriate emacs mode
    # editing commands
    *'MIRBSD KSH'*)
        bind '^I'='complete'
        bind '^L'='clear-screen'
        ;;

    # Similar with pdksh; there's a "complete" command, but not a "clear" one,
    # so we fake it with clear(1) and some yanking
    *'PD KSH'*)
        bind '^I'='complete'
        bind -m '^L'='^Uclear^J^Y'
        ;;
esac
