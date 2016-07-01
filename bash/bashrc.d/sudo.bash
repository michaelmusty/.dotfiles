# Add the -H parameter to sudo(8) calls, always use the target user's $HOME
sudo() {
    if [[ $1 != -v ]] ; then
        set -- -H "$@"
    fi
    command sudo "$@"
}
