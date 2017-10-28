# Get the mean of a list of numbers
BEGIN { tot = 0 }
{ tot += $1 + 0 }
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    print tot / NR
}
