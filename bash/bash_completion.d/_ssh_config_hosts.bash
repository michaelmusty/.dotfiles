# Complete ssh_config(5) hostnames
_ssh_config_hosts() {

    # Iterate through SSH client config paths
    local config
    for config in "$HOME"/.ssh/config /etc/ssh/ssh_config ; do
        [[ -e $config ]] || continue

        # Read 'Host' options and their first value from file
        local option value ci
        while read -r option value _ ; do
            [[ $option == Host ]] || continue

            # Check host value
            case $value in
                # No empties
                '') ;;
                # No wildcards
                *'*'*) ;;
                # Found a match; print it
                "$2"*) COMPREPLY[ci++]=$value ;;
            esac

        done < "$config"
    done
}
