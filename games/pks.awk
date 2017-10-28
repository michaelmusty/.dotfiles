# Ha, ha, ha! Awk!

# Process arguments
BEGIN {

    # If no arguments left, assume a dictionary file
    if (ARGC == 1) {
        ARGC = 2
        if ("DICT" in ENVIRON)
            ARGV[1] = ENVIRON["DICT"]
        else
            ARGV[1] = "/usr/share/dict/words"
    }

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
}

# Iterate over the lines, randomly assigning the first field of each one with a
# decreasing probability; this method allows a single pass over the input,
# though it requires a lot of random numbers
$1 ~ /[a-zA-Z]/ && rand() * ++n < 1 { wr = $1 }

# Ha, ha! Conclusion!
END {

    # Check that we processed at least one line
    if (!NR)
        exit 1

    # Strip trailing possessives and punctuation
    sub(/[^a-zA-Z]+s*$/, "", wr)

    # Two or three "ha"s? Important decisions here folks
    hr = int(rand()*2+1)
    for (ha = "Ha"; hi < hr; hi++)
        ha = ha ", ha"

    # Capitalise the word
    wr = toupper(substr(wr,1,1)) substr(wr,2)

    # Print the laughter and the word
    printf "%s! %s!\n", ha, wr
}
