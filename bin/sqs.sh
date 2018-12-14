# Chop a trailing query string off filenames
self=sqs

# Check args
if [ "$#" -eq 0 ] ; then
    printf >&2 '%s: Need a filename\n' "$self"
    exit 2
fi

# Iterate through the given files
for sn do

    # Strip trailing slash if any and then query string
    sn=${sn%/}
    dn=${sn%%\?*}

    # Ignore this file if its name wouldn't change
    [ "$sn" != "$dn" ] || continue

    # Ignore this file if its name already exists (don't overwrite)
    if [ -e "$dn" ] ; then
        printf >&2 '%s: File named %s already exists\n' \
            "$self" "$dn"
        ex=1
        continue
    fi

    # Attempt a rename, flag an error if there was one
    mv -- "$sn" "$dn" || ex=1
done

# Exit with 1 if there was any failed mv(1) run
exit "${ex:-0}"
