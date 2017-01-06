# Search for alphanumeric words in a file
BEGIN {
    
    # Name self
    self = "gwp"

    # Words are separated by any non-alphanumeric characters
    FS = "[^a-zA-Z0-9]+"

    # First argument is the word required; push its case downward so we can
    # match case-insensitively
    word = tolower(ARGV[1])

    # Blank the first argument so Awk doesn't try to read data from it as a file
    ARGV[1] = ""

    # Bail out if we don't have a suitable word
    if (!word)
        fail("Need a single non-null alphanumeric string as a search word")
    if (word ~ FS)
        fail("Word contains non-alphanumeric characters; use grep(1)")
}

# Bailout function
function fail(str) {
    printf "%s: %s\n", self, str | "cat >&2"
    exit(1)
}

# If there's more than one filename, precede the print of the current line with
# a filename, a colon, and a space, much like grep(1) does; otherwise just
# print it
function fnpr() {
    if (ARGC > 3)
        print FILENAME ":" OFS $0
    else
        print
}

# Iterate through the words on this line and if any of them match our word,
# print the line, and flag that we've found at least one word; once a single
# instance of the word is found, just print and continue on to the next line
{
    for (i = 1; i <= NF; i++) {
        if (tolower($i) == word) {
            found = 1
            fnpr()
            break
        }
    }
}

# Exit zero if we found at least one match, non-zero otherwise
END { exit(!found) }
