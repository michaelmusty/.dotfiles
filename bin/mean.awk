# Get the mean of a list of integers
{ tot += $1 }
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    printf "%u\n", tot / NR
}
