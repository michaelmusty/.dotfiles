# Print the marked directory
pmd() {
    if [ -z "$PMD" ] ; then
        printf >&2 'pmd(): Mark not set\n'
        return 1
    fi
    printf '%s\n' "$PMD"
}
