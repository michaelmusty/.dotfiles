# Convert DOS line endings to UNIX ones

# Check arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 'd2u: Need a filename\n'
    exit 2
fi

# Put a carriage return into a variable for convenience
r=$(printf '\r')

# Iterate over arguments and apply the same ed(1) script to each of them
for fn do

    # Note the heredoc WORD is intentionally unquoted because we want to expand
    # $r within it to get a literal carriage return; the escape characters
    # prescribed for ed(1) by POSIX are very limited
    ed -s -- "$fn" <<EOF || ex=1
,s/$r\$//
w
EOF
done

# If any of the ed(1) commands failed, we should exit with 1
exit "${ex:-0}"
