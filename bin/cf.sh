# Count entries in a given set of directories

# Iterate over remaining non-option arguments (directories); default to current
# directory if none given
for dir in "${@:-.}" ; do

    # Attempt to count the files in a subshell
    if count=$(
        cd -- "$dir" || exit
        find . ! -name . -prune -exec printf %.sx {} + |
        wc -c
    ) ; then

        # If it worked, print the count
        printf '%u\t%s\n' "$count" "$dir"
    else

        # If not, set the error flag and continue
        ex=1
    fi
done

# Exit non-zero if a non-directory was given as an argument
exit "${ex:-0}"
