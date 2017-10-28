# Get the maximum of a list of numbers
BEGIN { max = 0 }
NR == 1 || $1 > max { max = $1 + 0 }
END {
    if (!NR)
        exit(1)
    print max
}
