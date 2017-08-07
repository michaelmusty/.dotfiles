# Format an RFC in text format for terminal reading

# A record is a paragraph
BEGIN {
    RS = ""
    ORS = "\n\n"
}

# If there's anything left, print it
length($0)
