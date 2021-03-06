# Show arguments or output in a pager if stdout looks like a terminal

# If no arguments, we'll use stdin
if [ "$#" -eq 0 ] ; then
    set -- -
fi

# If output seems to be to a terminal, try to run input through a pager of some
# sort; we'll fall back on more(1) to be POSIX-ish
if [ -t 1 ] ; then
    "${PAGER:-more}" -- "$@"

# Otherwise, just run it through with cat(1); a good pager does this anyway,
# provided it actually exists
else
    cat -- "$@"
fi
