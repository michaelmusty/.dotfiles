# Test that we have metadata about what options this system's ed(1) supports,
# and try to create it if not
(
    # Create a directory to hold metadata about ed
    ecd=$HOME/.cache/ed
    if ! [ -d "$ecd" ] ; then
        mkdir -p -- "$ecd" || exit
    fi

    # Write ed(1)'s --help output to a file, even if it's empty
    if ! [ -f "$ecd"/help ] ; then
        ed --help </dev/null >"$ecd"/help 2>/dev/null || exit

        # Iterate through some useful options and create files to show they're
        # available
        set -- verbose
        for opt ; do
            grep -q -- --"$opt" "$ecd"/help || continue
            touch -- "$ecd"/"$opt" || exit
        done
    fi
)
