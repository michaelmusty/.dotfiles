# Check that manual pages and logical binaries match up

# Need some scripts from the source directory
PATH=bin:$PATH

# Create temporary directory and implement cleanup function for it
td=
cleanup() {
    rm -fr -- "$td"
}
for sig in EXIT HUP INT TERM ; do
    trap cleanup "$sig"
done
td=$(mktd test-man) || exit

# Get lists of logical binaries and manual pages
# shellcheck disable=SC2016
find bin games -type f -print |
    sed 's_.*/__;s_\..*$__' |
    sort | uniq > "$td"/bin
# shellcheck disable=SC2016
find man/man[168] -type f -name '*.[168]df' -print |
    sed 's_.*/__;s_\..*$__' |
    sort | uniq > "$td"/man

# Get lists of noman scripts and nobin manual pages
comm -23 "$td"/bin "$td"/man > "$td"/noman
comm -13 "$td"/bin "$td"/man > "$td"/nobin

# Emit the content of both, if any
ex=0
if [ -s "$td"/noman ] ; then
    printf >&2 'No manual pages found for:\n'
    cat >&2 -- "$td"/noman
    ex=1
fi
if [ -s "$td"/nobin ] ; then
    printf >&2 'Stray manual page for:\n'
    cat >&2 -- "$td"/nobin
    ex=1
fi

# Exit appropriately
exit "$ex"
