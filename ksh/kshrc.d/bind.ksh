# Try to bind ^L to clear the screen
case $KSH_VERSION in

    *'93'*)
        bind() {
            # shellcheck disable=SC2154
            case ${.sh.edchar} in
                $'\f') .sh.edchar=$'\e\f' ;;
            esac
        }
        trap bind KEYBD
        ;;

    *'MIRBSD KSH'*)
        bind '^L'='clear-screen'
        ;;

    *'PD KSH'*)
        bind -m '^L'='^Uclear^J^Y'
        ;;

esac
