# Crude m4 preprocessor
BEGIN {
    self = "mi5"

    # You can change any of these, but while changing these is still relatively
    # sane...
    if (!length(open))
        open = "<%"
    if (!length(shut))
        shut = "%>"

    # ... changing these probably isn't, and should compel you to rethink your
    # code, or quite possibly your entire life thus far.
    if (!length(quote))
        quote = "`"
    if (!length(unquote))
        unquote = "'"
    if (!length(dnl))
        dnl = "dnl"

    # We do not start in a block
    bmac = 0
}

# Fatal error function
function fatal(str) {
    printf "%s: %s\n", self, str | "cat >&2"
    exit(1)
}

# Print an m4 opener as the first byte
NR == 1 { printf "%s", quote }

# Blocks
NF == 1 && $1 == open && !bmac++ {
    printf "%s", unquote
    next
}
NF == 1 && $1 == shut && bmac-- {
    printf "%s", quote
    next
}

# If in a block, print each line with any content on it after stripping leading
# and trailing whitespace
bmac && NF {
    gsub(/(^ +| +$)/, "")
    print $0 dnl
}

# If not in a block, look for inlines to process
!bmac {

    # We'll parse one variable into another.
    src = $0
    dst = ""

    # Start off neither quoting nor macroing.
    iquo = imac = 0

    # Crude and slow, clansman. Your parser was no better than that of a clumsy
    # child.
    for (i = 1; i <= length(src); ) {

        # Inline macro expansion: commented
        # Look for end of comment and tip flag accordingly
        if (iquo)
            iquo = (substr(src, i, length(unquote)) != unquote)

        # Inline macro expansion
        else if (imac) {

            # Close the current inline macro expansion if a close tag is found
            # (in m4 terms: open a new quote), looking ahead past any spaces
            # from this point first
            for (j = i; substr(src, j, 1) ~ /[ \t]/; j++)
                continue
            if (substr(src, j, length(shut)) == shut) {
                dst = dst quote
                i = j + length(shut)
                imac = 0
                continue
            }

            # Look for start of comment and tip flag accordingly
            iquo = (substr(src, i, length(quote)) == quote)
        }

        # Plain text mode
        else {

            # Open a new inline macro expansion if an open tag is found (in m4
            # terms: close the quote), and then look ahead past any spaces from
            # that point afterward
            if (substr(src, i, length(open)) == open) {
                dst = dst unquote
                imac = 1
                for (i += length(open); substr(src, i, 1) ~ /[ \t]/; i++)
                    continue
                continue
            }

            # Escape quote terminators
            if (substr(src, i, length(unquote)) == unquote) {

                # Dear Mr. President. There are too many variables nowadays.
                # Please eliminate three. I am NOT a crackpot.
                dst = dst unquote unquote quote

                i += length(unquote)
                continue
            }
        }

        # If we got down here, we can just add the next character and move on
        dst = dst substr(src, i++, 1)
    }

    # If we're still in a macro expansion or quote by this point, something's
    # wrong; say so and stop, rather than print anything silly.
    if (iquo)
        fatal("Unterminated inline quote");
    else if (imac)
        fatal("Unterminated inline macro");
    else
        print dst
}

# Print an m4 closer and newline deleter as the last bytes if we've correctly
# stopped all our blocks
END {
    if (bmac)
        fatal("Unterminated block macro");
    else
        print unquote dnl
}
