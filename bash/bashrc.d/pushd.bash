# Make pushd default to $HOME if no arguments given, much like cd
pushd() {
    # shellcheck disable=SC2164
    builtin pushd "${@:-"$HOME"}"
}
