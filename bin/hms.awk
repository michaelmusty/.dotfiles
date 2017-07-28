# Convert seconds to colon-delimited durations
BEGIN {
    OFS = ":"
    ex = 0
    stderr = ""
}

# Refuse to deal with anything that's not a positive (unsigned) integer
/[^0-9]/ {
    if (!stderr)
        stderr = "cat >&2"
    print "hms: Bad number" | stderr
    ex = 1
    next
}

# Integer looks valid
{
    # Break it down into hours, minutes, and seconds
    s = int($0 + 0)
    h = int(s / 3600)
    s %= 3600
    m = int(s / 60)
    s %= 60

    # Print it, with the biggest number without a leading zero
    if (h)
        printf "%u:%02u:%02u\n", h, m, s
    else if (m)
        printf "%u:%02u\n", m, s
    else
        printf "%u\n", s
}

# Done, exit 1 if we had any errors on the way
END {
    if (stderr)
        close(stderr)
    exit(ex)
}
