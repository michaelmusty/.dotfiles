# Test that we have metadata about what options this system's grep(1) supports,
# and try to create it if not
(
    # Create a directory to hold metadata about grep
    gcd=$HOME/.cache/grep
    if ! [ -d "$gcd" ] ; then
        mkdir -p -- "$gcd" || exit
    fi

    # Write grep(1)'s --help output to a file, even if it's empty
    if ! [ -f "$gcd"/help ] ; then
        grep --help </dev/null >"$gcd"/help 2>/dev/null || exit

        # Iterate through some useful options and create files to show they're
        # available
        set -- binary-files \
               color        \
               devices      \
               directories  \
               exclude      \
               exclude-dir
        for opt ; do
            grep -Eq -- --"$opt" "$gcd"/help || continue
            touch -- "$gcd"/"$opt" || exit
        done
    fi
)
