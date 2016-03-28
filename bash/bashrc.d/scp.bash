# Wrap scp(1) to check for missing colons
scp() {
    # shellcheck disable=SC2048
    if (($# >= 2)) && [[ $* != *:* ]] ; then
        printf 'bash: %s: Missing colon, probably an error\n' \
            "$FUNCNAME" >&2
        return 2
    fi
    command scp "$@"
}
