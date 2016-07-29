# Wrapper around gpg(1) to stop ``--batch'' breaking things
gpg() {
    # shellcheck disable=SC2048
    case $* in
        *--ed*|*--gen-k*|*--sign-k*)
            set -- --no-batch "$@"
            ;;
    esac
    command gpg "$@"
}
