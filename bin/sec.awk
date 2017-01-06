# Convert [[[hh:]mm:]ss] timestamps to seconds

# Separator is :, strip out leading zeroes
BEGIN { FS = ":0*" }

# If no fields, too many fields, or illegal characters, warn, skip line, accrue
# errors
!NF || NF > 3 || /[^0-9:]/ {
    print "sec: Bad format" | "cat >&2"
    err = 1
    next
}

# Match hh:mm:ss
NF == 3 { printf "%u\n", $1 * 3600 + $2 * 60 + $3 }

# Match mm:ss
NF == 2 { printf "%u\n", $1 * 60 + $2 }

# Match ss (in which case all we've done is strip zeroes)
NF == 1 { printf "%u\n", $1 }

# Done, exit 1 if we had any errors on the way
END { exit(err > 0) }
