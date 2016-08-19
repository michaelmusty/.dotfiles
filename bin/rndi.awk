# Get a low-quality random number between two integers. Depending on the awk
# implementation, if you don't provide a third argument (a seed), you might get
# very predictable random numbers based on the current epoch second.

BEGIN {

    # Seed with the third argument if given
    if (ARGV[3]) {
        srand(ARGV[3])
    }

    # If not, just seed with what is probably a date/time-derived value
    else {
        srand()
    }

    # Print a random integer bounded by the first and second arguments
    print int(ARGV[1]+rand()*(ARGV[2]-ARGV[1]+1))

    # Bail before processing any lines
    exit
}
