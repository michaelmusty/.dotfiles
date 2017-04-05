# Convenience find(1) wrapper for path substrings

# Require at least one search term
if [ "$#" -eq 0 ] ; then
    printf >&2 'loc: Need a search term\n'
    exit 2
fi

# Iterate through each search term and run an appropriate find(1) command
for pat ; do

    # Skip dotfiles, dotdirs, and symbolic links; print anything that matches
    # the term as a substring (and stop iterating through it)
    find . \
        -name .\* ! -name . -prune -o \
        -type l -prune -o \
        -name \*"$pat"\* -prune -print
done
