# builtin with builtins
complete -b builtin

# cd/pushd with directories
complete -d cd pushd

# command/hash/type with commands
complete -c command hash type

# help with topics
complete -A helptopic help

# set with options
complete -A setopt set

# shopt with shell options
complete -A shopt shopt

# sudo with commands (and not files)
complete -c sudo

# unset with shell variables and functions
complete -v -A function unset

# ssh/sftp/ssh-copy-id with config hostnames
_ssh() {
    local word config hosts option value
    word=${COMP_WORDS[COMP_CWORD]}
    config=$HOME/.ssh/config
    hosts=()

    # Bail if the configuration file is illegible
    if [[ ! -r $config ]]; then
        return 1
    fi

    # Read hostnames from the file, no asterisks
    while read -r option value _; do
        if [[ $option == Host && $value != *'*'* ]]; then
            hosts[${#hosts[@]}]=$value
        fi
    done < "$config"

    # Generate completion reply
    COMPREPLY=( $(compgen -W "${hosts[*]}" -- "$word") )
}
complete -F _ssh ssh sftp ssh-copy-id

# scp/rsync with local files and hostnames (colon suffixes)
_scp() {
    _ssh
    COMPREPLY=( "${COMPREPLY[@]/%/:}" )
}
complete -f -F _scp scp

