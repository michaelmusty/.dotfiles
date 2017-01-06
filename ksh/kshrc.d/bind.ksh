# Try to bind ^L to clear the screen
case $KSH_VERSION in

    *'93'*)
        bind() {
            case ${.sh.edchar} in
                $'\f') .sh.edchar=$'\e\f' ;;
            esac
        }
        trap bind KEYBD
        ;;

    *'MIRBSD KSH'*)
        bind ^L=clear-screen
        ;;

    *'PD KSH'*)
        bind -m '^L'='^U'clear'^J^Y'
        ;;

esac
