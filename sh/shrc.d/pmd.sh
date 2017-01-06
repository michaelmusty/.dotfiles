# Print the marked directory
pmd() {
    if ! [ -n "$PMD" ] ; then
        printf >&2 'pmd(): Mark not set\n'
        return 2
    fi
    printf '%s\n' "$PMD"
}
