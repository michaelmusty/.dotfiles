# Some simple completion for openssl(1ssl)
_openssl() {

    # Needs openssl(1ssl)
    hash openssl 2>/dev/null || return

    # Only complete the first word: OpenSSL subcommands
    ((COMP_CWORD == 1)) || return

    # Iterate through completions produced by subshell
    local -a subcmds
    local ci comp
    while read -a subcmds -r ; do
        for subcmd in "${subcmds[@]}" ; do
            case $subcmd in
                "$2"*) COMPREPLY[ci++]=$comp ;;
            esac
        done
    done < <(
        openssl list -commands \
            -cipher-commands \
            -digest-commands
    )
}
complete -F _openssl -o bashdefault -o default openssl
