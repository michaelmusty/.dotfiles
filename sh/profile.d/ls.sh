# Test that we have metadata about what options this system's ls(1) supports,
# and try to create it if not
(
    # Create a directory to hold metadata about ls(1)
    lcd=$HOME/.cache/ls
    if ! [ -d "$lcd" ] ; then
        mkdir -p -- "$lcd" || exit
    fi

    # Write ls(1)'s --help output to a file, even if it's empty
    if ! [ -f "$lcd"/help ] ; then
        ls --help >"$lcd"/help 2>/dev/null || exit

        # Iterate through some useful options and create files to show they're
        # available
        set -- almost-all     \
               block-size     \
               classify       \
               color          \
               human-readable \
               time-style
        for opt ; do
            grep -q -- --"$opt" "$lcd"/help || continue
            touch -- "$lcd"/"$opt" || exit
        done
    fi
)
