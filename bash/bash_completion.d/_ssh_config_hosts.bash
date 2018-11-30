# Complete ssh_config(5) hostnames
_ssh_config_hosts() {

    # Don't complete anything that wouldn't be in a valid hostname
    case ${COMP_WORDS[COMP_CWORD]} in
        *[!a-zA-Z0-9.-]*) return 1 ;;
    esac

    # Iterate through words from a subshell
    while read -r word ; do
        [[ -n $word ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$word
    done < <(

        # Check bind settings to see if we should match case insensitively
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -qs nocasematch 2>/dev/null
                    break
                    ;;
            esac
        done < <(bind -v)

        # Iterate through SSH client config paths
        for config in "$HOME"/.ssh/config /etc/ssh/ssh_config ; do
            [[ -e $config ]] || continue

            # Read Host options and their first value from file
            while read -r option value _ ; do
                [[ $option == Host ]] || continue

                # Check host value
                case $value in

                    # Don't complete with wildcard characters
                    (*'*'*) ;;

                    # Found a match; print it
                    ("${COMP_WORDS[COMP_CWORD]}"*)
                        printf '%s\n' "$value"
                        ;;
                esac

            done < "$config"
        done
    )
}
