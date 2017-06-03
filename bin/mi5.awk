# Crude m4 preprocessor
BEGIN {
    mac = 0
    if (!length(open))
        open = "<%"
    if (!length(shut))
        shut = "%>"
}

# Print an m4 opener as the first byte
NR == 1 { printf "`" }

# Blocks
NF == 1 && $1 == open && !mac++ {
    printf "'"
    next
}
NF == 1 && $1 == shut && mac-- {
    printf "`"
    next
}

# If in a block, print each line with any content on it after stripping leading
# and trailing whitespace
mac && NF {
    sub(/^ */, "")
    sub(/ *$/, "")
    print $0 "dnl"
}

# If not in a block, look for inlines to process
!mac {

    # We'll empty one variable into another
    src = $0
    dst = ""

    # As long as there's a pair of opening and closing tags
    while ((ind = index(src, open)) && index(src, shut) > ind) {

        # Read up to opening tag into seg, shift from src
        seg = substr(src, 1, ind - 1)
        src = substr(src, ind)

        # Escape quote closer and add to dst
        gsub(/'/, "''`", seg)
        dst = dst seg

        # Read up to closing tag into seg, shift from src
        ind = index(src, shut)
        seg = substr(src, length(open) + 1, ind - length(shut) - 1)
        src = substr(src, ind + length(shut))

        # Translate tags to quote open and close and add to dst
        sub(/^ */, "'", seg)
        sub(/ *$/, "`", seg)
        dst = dst seg
    }

    # Escape quote closers in whatever's left
    gsub(/'/, "''`", src)

    # Tack that onto the end, and print it
    dst = dst src
    print dst
}

# Print an m4 closer and newline deleter as the last bytes
END { print "'dnl" }
