# Get the median of a list of numbers
BEGIN {
    self = "med"
    stderr = "cat >&2"
}
{ vals[NR] = $1 }
NR > 1 && vals[NR] < vals[NR-1] && !warn++ {
    if (!stderr)
        stderr = "cat >&2"
    printf "%s: Input not sorted!\n", self | stderr
}
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    if (NR % 2)
        med = vals[(NR+1)/2]
    else
        med = (vals[NR/2] + vals[NR/2+1]) / 2
    print med
    if (stderr)
        close(stderr)
    if (warn)
        exit(1)
}
