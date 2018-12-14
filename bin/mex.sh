# Make the first non-executable instance of files with the given names in $PATH
# executable
self=mex

# Check we have at least one argument
if [ "$#" -eq 0 ] ; then
    printf >&2 '%s: At least one name required\n' "$self"
    exit 2
fi

# Iterate through the given names
for name do

    # Clear the found variable
    found=

    # Start iterating through $PATH, with colon prefix/suffix to correctly
    # handle the fenceposts
    path=:$PATH:
    while [ -n "$path" ] ; do

        # Pop the first directory off $path into $dir
        dir=${path%%:*}
        path=${path#*:}

        # Check $dir is non-null
        [ -n "$dir" ] || continue

        # If a file with the needed name exists in the directory and isn't
        # executable, we've found our candidate and can stop iterating
        if [ -f "$dir"/"$name" ] && ! [ -x "$dir"/"$name" ] ; then
            found=$dir/$name
            break
        fi
    done

    # If the "found" variable was defined to something, we'll try to change its
    # permissions
    if [ -n "$found" ] ; then
        case $found in
            /*) ;;
            *) found=$PWD/$found ;;
        esac
        chmod +x "$found" || ex=1

    # If not, we'll report that we couldn't find it, and flag an error for the
    # exit status
    else
        printf >&2 '%s: No non-executable name "%s" in PATH\n' "$self" "$name"
        ex=1
    fi
done

# We exit 1 if any of the names weren't found or if changing their permissions
# failed
exit "${ex:-0}"
