# Print a random line from input

# Process arguments
BEGIN {

    # Name self
    self = "rndl"

    # Seed the random number generator
    "rnds 2>/dev/null" | getline seed
    if (length(seed))
        srand(seed + 0)
    else
        srand()
}

# Iterate over the lines, randomly assigning the first field of each one with a
# decreasing probability
rand() * NR < 1 { ln = $0 }

# Check and print
END {

    # Check that we processed at least one line
    if (!NR) {
        printf "%s: No lines found on input\n", self | "cat >&2"
        exit(1)
    }

    # Print the line
    print ln
}
