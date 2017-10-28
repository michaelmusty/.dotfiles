# Strip an extension from the given filenames
self=stex

# Check args
if [ "$#" -lt 2 ] ; then
    printf >&2 '%s: Need an extension .ext and a filename\n' \
        "$self"
    exit 2
fi

# Extension is first arg, shift it off
ext=$1
shift

# Iterate through the given files (remaining args)
for sn ; do

    # Strip trailing slash if any and then extension
    sn=${sn%/}
    dn=${sn%"$ext"}

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
