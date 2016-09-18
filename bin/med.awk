# Get the median of a list of integers; if it has to average it, it uses the
# integer floor of the result
{ vals[NR] = $1 }
NR > 1 && vals[NR] < vals[NR-1] && !warn++ {
    printf "med: Input not sorted!\n" > "/dev/stderr"
}
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    if (NR % 2) {
        med = vals[(NR+1)/2]
    } else {
        med = (vals[NR/2] + vals[NR/2+1]) / 2
    }
    print med
    if (warn)
        exit(1)
}
