# Get the mean of a list of numbers
{ tot += $1 }
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    print tot / NR
}
