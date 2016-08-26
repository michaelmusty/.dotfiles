# Cache the options available to certain programs. Run all this in a subshell
# (none of its state needs to endure in the session)
(
options() (

    # Check or create the directory to cache the options
    dir=$HOME/.cache/$1

    # Directory already exists; bail out
    [ -d "$dir" ] && exit

    # Create the directory and step into it
    mkdir -p -- "$dir" || exit
    cd -- "$dir" || exit

    # Write the program's --help output to a file, even if it's empty
    "$1" --help </dev/null >help 2>/dev/null || exit

    # Shift the program name off; remaining arguments are the options to check
    shift

    # Iterate through some useful options and create files to show they're
    # available if found in the help output
    for opt ; do
        grep -q -- '[^[:alnum:]]--'"$opt"'[^[:alnum:]]' help &&
            touch -- "$opt"
    done
)

# Cache options for bc(1)
options bc \
    quiet

# Cache options for ed(1)
options ed \
    verbose

# Cache options for grep(1)
options grep \
    binary-files \
    color        \
    devices      \
    directories  \
    exclude      \
    exclude-dir

# Cache options for ls(1)
options ls \
    almost-all         \
    block-size         \
    classify           \
    color              \
    format             \
    hide-control-chars \
    human-readable     \
    time-style
)
