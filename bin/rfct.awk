# Format an RFC in text format for terminal reading

# A record is a paragraph
BEGIN {
    RS = ""
    ORS = "\n\n"
}

# Skip paragraphs with ^L chars in them
# We have to be literal here due to mawk's failures
// { next }

# If there's anything left, print it
length($0)
