# Add the -H parameter to sudo(8) calls, always use the target user's $HOME
sudo() {
    [ "$1" != -v ] && set -- -H "$@"
    command sudo "$@"
}
