# Convert [[[hh:]mm:]ss] timestamps to seconds

# Separator is :
BEGIN {
    FS = ":"
}

# If no fields or illegal characters, warn, skip line, accrue errors
!NF || /[^0-9:]/ {
    print "sec: Bad format" > "/dev/stderr"
    err = 1
    next
}

# Strip leading zeroes to stop awk trying to be octal
{
    for (i = 1; i <= NF; i++)
        sub(/^0*/, "", $i)
}

# Match hh:mm:ss
NF == 3 {
    printf "%u\n", $1 * 3600 + $2 * 60 + $3
    next
}

# Match mm:ss
NF == 2 {
    printf "%u\n", $1 * 60 + $2
    next
}

# Match ss (in which case all we've done is strip zeroes)
NF == 1 {
    printf "%u\n", $1
    next
}

# Done, exit 1 if we had any errors on the way
END {
    exit(err > 0)
}