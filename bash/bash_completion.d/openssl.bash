# Some simple completion for openssl(1ssl)
_openssl() {

    # Only complete the first word: OpenSSL subcommands
    case $COMP_CWORD in
        1)
            while read -r subcmd ; do
                case $subcmd in
                    '') ;;
                    "$2"*)
                        COMPREPLY[${#COMPREPLY[@]}]=$subcmd
                        ;;
                esac
            done < <(
                for arg in \
                list-cipher-commands \
                list-standard-commands \
                list-message-digest-commands ; do
                    printf '%s\n' "$arg"
                    openssl "$arg"
                done
            )
            ;;
    esac
}
complete -F _openssl -o bashdefault -o default openssl
