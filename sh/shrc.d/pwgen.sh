# Set some defaults for pwgen(1), because its defaults are to give me a long
# list of relatively short passwords, when I generally want only one good one
pwgen() {
    [ "$#" -eq 0 ] &&
        set -- --secure -- "${PWGEN_LENGTH:-15}" "${PWGEN_COUNT:-1}"
    command pwgen "$@"
}
