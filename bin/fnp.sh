# Print input, but include filenames as headings

# Assume stdin if no options given
[ "$#" -gt 0 ] || set -- -

# Iterate through arguments
for arg ; do

    # We'll print the filename "-stdin-" rather than - just to be slightly more
    # explicit
    case $arg in
        -) fn=-stdin- ;;
        *) fn=$arg ;;
    esac

    [ -n "$tail" ] && printf '\n'
    tail=1

    # Form the underline; is there a nicer way to do this in POSIX sh?
    ul=$(printf %s "$fn"|tr '[:print:]' -)
    printf '%s\n%s\n\n' "$fn" "$ul"
    cat -- "$arg"
done
