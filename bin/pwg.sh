# Shortcut to generate just one strong password with pwgen(1)
# If any arguments are provided, those are used instead
if [ "$#" -eq 0 ] ; then
    set -- --secure -- "${PWGEN_LENGTH:-16}" "${PWGEN_COUNT:-1}"
fi
pwgen "$@"
