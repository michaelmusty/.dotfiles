# Ha, ha, ha! Awk!

# Process arguments
BEGIN {

    # If no arguments, assume a dictionary file
    if (ARGC == 1) {
        ARGC = 2
        if ("DICT" in ENVIRON)
            ARGV[1] = ENVIRON["DICT"]
        else
            ARGV[1] = "/usr/share/dict/words"
    }

    # Seed the random number generator
    "rnds 2>/dev/null" | getline seed
    if (length(seed))
        srand(seed)
    else
        srand()
}

# Iterate over the lines, randomly assigning the first field of each one with a
# decreasing probability; this method
$1 ~ /[[:alpha:]]/ && rand() * ++n < 1 { wr = $1 }

# Ha, ha, ha! Incompetent!
END {

    # Check that we processed at least one line
    if (!NR)
        exit 1

    # Strip trailing possessives and punctuation
    sub(/[^[:alpha:]]+s*$/, "", wr)

    # Two or three "has"? Important decisions here folks
    hr = int(rand()*2+1)
    for (ha = "Ha"; hi < hr; hi++)
        ha = ha ", ha"

    # Capitalise the word
    wr = toupper(substr(wr,1,1)) substr(wr,2)

    # Return the laughter and the word
    printf "%s! %s!\n", ha, wr
}
