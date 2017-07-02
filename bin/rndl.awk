# Print a random line from input

# Process arguments
BEGIN {

    # Name self
    self = "rndl"

    # Seed the random number generator
    rnds = "rnds 2>/dev/null"
    rnds | getline seed
    close(rnds)
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
        stderr = "cat >&2"
        printf "%s: No lines found on input\n", self | stderr
        close(stderr)
        exit(1)
    }

    # Print the line
    print ln
}
