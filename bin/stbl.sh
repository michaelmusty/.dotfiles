# Strip a trailing blank line from the given files with ed(1)

# Check arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 'stbl: Need a filename\n'
    exit 2
fi

# Iterate over arguments and apply the same ed(1) script to each of them
for fn do
    ed -s -- "$fn" <<'EOF' || ex=1
$g/^ *$/d
w
EOF
done

# If any of the ed(1) commands failed, we should exit with 1
exit "${ex:-0}"
