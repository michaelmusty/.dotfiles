# Format an RFC in text format for terminal reading

# A record is a paragraph
BEGIN {
    RS = ""
    ORS = "\n\n"
}

{
    # Strip out control characters, except tab and newline
    gsub(/[^[:print:]\n\t]/, "")

    # If there's anything left, print it
    if (length)
        print
}
