# Some simple completion for openssl(1ssl)
_openssl() {

    # Needs openssl(1ssl)
    hash openssl 2>/dev/null || return

    # Only complete the first word: OpenSSL subcommands
    ((COMP_CWORD == 1)) || return

    # Iterate through completions produced by subshell
    local ci comp
    while read -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Run each of the command-listing commands; read each line into an
        # array of subcommands (they are printed as a table)
        for list in commands digest-commands cipher-commands ; do
            openssl list -"$list"
        done | {
            declare -a subcmds
            while read -a subcmds -r ; do
                for subcmd in "${subcmds[@]}" ; do
                    case $subcmd in
                        ("$2"*) printf '%s\n' "$subcmd" ;;
                    esac
                done
            done
        }
    )
}
complete -F _openssl -o bashdefault -o default openssl
