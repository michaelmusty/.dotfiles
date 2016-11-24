# Get mode of a list of numbers
# If the distribution is multimodal, the first mode is used
{ vals[$1]++ }
END {
    # Error out if we read no values at all
    if (!NR)
        exit(1)
    mode = vals[0]
    for (val in vals)
        if (vals[val] > vals[mode])
            mode = val
    print mode
}
