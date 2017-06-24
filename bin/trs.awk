# Substitute one string for another in input (no newlines, no regex)
BEGIN {
    # Name self
    self = "trs"

    # No wordsplitting required
    FS = ""

    # Two and only two arguments required
    if (ARGC != 3)
        fail("Need a string and a replacement")

    # Get arguments and blank them so awk doesn't try to read them as files
    str = ARGV[1]
    rep = ARGV[2]
    ARGV[1] = ARGV[2] = ""

    # String length is relevant here
    if (!(len = length(str)))
        fail("String to replace cannot be null")
}

# Bailout function
function fail(str) {
    printf "%s: %s\n", self, str | "cat >&2"
    exit(2)
}

# Run on each line
{
    lin = ""
    for (buf = $0; ind = index(buf, str); buf = substr(buf, ind + len))
        lin = lin substr(buf, 1, ind - 1) rep
    lin = lin buf
    print lin
}
