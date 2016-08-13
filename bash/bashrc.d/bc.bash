# This function is only applicable if bc(1) has the non-POSIX -q option
command bc -q </dev/null >&0 2>&0 || return

# Don't print the bc(1) welcome message
bc() {
    command bc -q "$@"
}
