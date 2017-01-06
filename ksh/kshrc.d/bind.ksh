# Try to bind ^L to clear the screen
case $KSH_VERSION in

    # Works great
    *'MIRBSD KSH'*)
        bind ^L=clear-screen
        ;;

    # Works great
    *'93'*)
        bind() {
            case ${.sh.edchar} in
                $'\f') .sh.edchar=$'\e\f' ;;
            esac
        }
        trap bind KEYBD
        ;;

    # Works pretty well, but only on an empty line
    *'PD KSH'*)
        bind -m '^L'=clear'^J'
        ;;
esac
