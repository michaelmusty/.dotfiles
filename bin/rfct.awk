# Format an RFC in text format for terminal reading

# A record is a paragraph
BEGIN {
    RS=""
}

# Print the block followed by two newlines, as long as it has at least one
# alphanumeric character and no pagebreak characters
/[a-zA-Z0-9]/ && !/\x0c/ { printf "%s\n\n", $0 }
