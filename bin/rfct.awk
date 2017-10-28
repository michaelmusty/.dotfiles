# Format an RFC in text format for terminal reading

# A record is a paragraph
BEGIN {
    RS = ""
    ORS = "\n\n"
}

# Skip paragraphs with ^L chars in them, as they likely contain headers and
# footers
/\f/ { next }

# Strip out other control characters, but allow newline and tab
{ gsub(/[\a\b\r\v]/, "") }

# If there's anything left after that, print it
length($0)
