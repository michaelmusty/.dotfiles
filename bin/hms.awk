BEGIN {
    OFS = ":"
}

# Refuse to deal with anything that's not a positive (unsigned) integer
/[^0-9]/ {
    print "hms: Bad number" | "cat >&2"
    err = 1
    next
}

# Integer looks valid
{
    # Break it down into hours, minutes, and seconds
    s = $0
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
END { exit(err > 0) }
