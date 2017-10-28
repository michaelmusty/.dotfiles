# Get a low-quality random number between two integers. Depending on the awk
# implementation, if you don't have rnds(1df) available to generate a seed of
# sufficient quality, you might get very predictable random numbers based on
# the current epoch second.

BEGIN {
    self = "rndi"

    # Check we have two arguments
    if (ARGC != 3)
        fail("Need a lower and upper bound")

    # Floor args and check for sanity
    lower = int(ARGV[1] + 0)
    upper = int(ARGV[2] + 0)
    if (lower >= upper)
        fail("Bounds must be numeric, first lower than second")

    # Get a random seed if rnds(1df) available
    rnds = "rnds 2>/dev/null"
    rnds | getline seed
    close(rnds)

    # Truncate the seed to 8 characters because mawk might choke on it
    seed = substr(seed,1,8)
    if (length(seed))
        srand(seed + 0)
    else
        srand()

    # Print a random integer bounded by the first and second arguments
    print int(lower + rand() * (upper - lower + 1))

    # Bail before processing any lines
    exit
}

# Bailout function
function fail(str) {
    stderr = "cat >&2"
    printf "%s: %s\n", self, str | stderr
    close(stderr)
    exit(2)
}
