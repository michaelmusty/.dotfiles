# Get the minimum of a list of numbers
{
    if (NR == 1 || $1 < min)
        min = $1
}
END {
    if (!NR)
        exit(1)
    print min
}
