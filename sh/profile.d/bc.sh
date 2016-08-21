# Test that we have metadata about what options this system's bc(1) supports,
# and try to create it if not
(
    # Create a directory to hold metadata about bc
    bcd=$HOME/.cache/bc
    if ! [ -d "$bcd" ] ; then
        mkdir -p -- "$bcd" || exit
    fi

    # Write bc(1)'s --help output to a file, even if it's empty
    if ! [ -f "$bcd"/help ] ; then
        bc --help </dev/null >"$bcd"/help 2>/dev/null || exit

        # Iterate through some useful options and create files to show they're
        # available
        set -- quiet
        for opt ; do
            grep -q -- --"$opt" "$bcd"/help || continue
            touch -- "$bcd"/"$opt" || exit
        done
    fi
)
