# Get the maximum of a list of numbers
{
    if (NR == 1 || $1 > max)
        max = $1
}
END {
    if (!NR)
        exit(1)
    print max
}
