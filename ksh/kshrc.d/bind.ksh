# Try to bind ^L to clear the screen
case $KSH_VERSION in

    # Works great
    *'MIRBSD KSH'*)
        bind ^L=clear-screen
        ;;

    # Works pretty well, but only on an empty line
    *'PD KSH'*)
        bind -m '^L'=clear'^J'
        ;;

    # Not great; only works on an empty line, and skips a line after clearing;
    # need a better way to redraw the prompt after clearing, or some suitable
    # way to fake it with tput (can I clear-but-one)?
    *'93'*)

        # Bind function to run on each KEYBD trap
        bind() {
            case ${.sh.edchar} in
                $'\x0c') # ^L

                    # Write a sequence to clear the screen
                    tput clear

                    # Change key to Enter to redraw the prompt
                    .sh.edchar=$'\x0d'
                    ;;
            esac
        }
        trap bind KEYBD
        ;;
esac
