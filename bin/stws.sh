# Strip trailing spaces on one or more files

# Check arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 'stws: Need a filename\n'
    exit 2
fi

# Iterate over arguments and apply the same ed(1) script to each of them
for fn do
    ed -s -- "$fn" <<'EOF' || ex=1
g/  *$/ s/  *$//
w
EOF
done

# If any of the ed(1) commands failed, we should exit with 1
exit "${ex:-0}"
