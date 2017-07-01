# Ha, ha, ha! Awk!

# Print either two or three "has" and the given word, capitalized
function haha(wr) {

    # Two or three "has"? Important decisions here folks
    srand()
    hr = int(rand()*2+1)
    for (ha = "Ha"; hi < hr; hi++)
        ha = ha ", ha"

    # Capitalise the word
    wr = toupper(substr(wr,1,1)) substr(wr,2)

    # Return the laughter and the word
    return ha "! " wr "!"
}

# Ha, ha! Failure!
function fail(str, ex) {
    af = 1
    print haha(str) | "cat >&2"
    exit(ex)
}

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

    # Check the user hasn't tried stdin
    for (ai = 1; ai < ARGC; ai++)
        if (ARGV[ai] == "-")
            fail("standard input", 2)

    # Count the number of lines in the files (pass 1)
    for (ai = 1; ai < ARGC; ai++)
        while (getline < ARGV[ai])
            lc++

    # If all files were empty, we can't go on
    if (lc == 0)
        fail("no data", 1)

    # Pick a random line number
    srand()
    lr = int(lc*rand()+1)
}

# Iterate over the file until we get to the selected line (pass 2)
NR >= lr {

    # Find the first word-looking thing
    for (i = 1; !wr && i <= NF; i++)
        if (tolower($i) ~ /[[:lower:]]/)
            wr = $i

    # Strip trailing possessives
    sub(/'s*$/, "", wr)

    # No word? Uh, better keep going
    if (!length(wr))
        next

    # Ha, ha! Suboptimal!
    print haha(wr)
    exit(0)
}

# Ha, ha, ha! Incompetent!
END {
    if (!af && !length(wr))
        fail("error", 1)
}
