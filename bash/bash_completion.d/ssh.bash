# Completion for ssh(1) with ssh_config(5) hostnames
declare -F _ssh_config_hosts >/dev/null ||
    source "$HOME"/.bash_completion.d/_ssh_config_hosts.bash
complete -F _ssh_config_hosts -o bashdefault -o default ssh
