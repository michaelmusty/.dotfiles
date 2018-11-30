# Completion for sftp(1) with ssh_config(5) hostnames
if ! declare -F _ssh_config_hosts >/dev/null ; then
    source "$HOME"/.bash_completion.d/_ssh_config_hosts.bash
fi
complete -F _ssh_config_hosts -o bashdefault -o default sftp
