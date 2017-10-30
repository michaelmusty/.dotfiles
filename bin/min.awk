# Get the minimum of a list of numbers
BEGIN { min = 0 }
NR == 1 || $1 < min { min = $1 + 0 }
END {
    if (!NR)
        exit(1)
    print min
}
